# == Schema Information
#
# Table name: data_imports
#
#  id          :bigint(8)        not null, primary key
#  file        :string
#  status      :string           default("new")
#  log         :text
#  finished_at :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  options     :jsonb
#

class DataImport < ApplicationRecord
  STATUSES = %w[running finished failed].freeze
  GOOGLE_DRIVE_REGEX = %r{https:\/\/drive.google.com\/open\?id=([A-Za-z0-9_-]+)}

  QUESTION_TYPES = {
    'Yes/ No' => 'boolean',
    'This option only' => 'option',
    'These options' => 'unordered_list',
    'These options in this order' => 'ordered_list',
    'This description' => 'text',
    'This value' => 'number',
    'Between these values' => 'number_range',
    'At this time' => 'time',
    'Between these times' => 'time_range'
  }.freeze

  mount_uploader :file, FileUploader

  default_scope -> { order(created_at: :desc) }

  after_create_commit :schedule_import

  jsonb_accessor :options,
                 categories: [:boolean, default: true],
                 questions: [:boolean, default: true],
                 locking_conditions: [:boolean, default: true],
                 visibility_conditions: [:boolean, default: true]

  validates :file, presence: true

  STATUSES.each do |method_name|
    define_method("#{method_name}?") { status == method_name }
  end

  def filename
    file.to_s.split('/').last
  end

  def import_all
    update(status: 'running')
    import_categories if categories?
    import_questions if questions?
    update_visibility_conditions if visibility_conditions?
    update_locking_conditions if locking_conditions?
    update(status: 'finished', finished_at: Time.now)
    ActionCable.server.broadcast('import_channel', id: id, filename: filename, status: 'finished')
  rescue => e
    notify e.to_s, 'ERROR'
    update(status: 'failed', finished_at: Time.now)
    ActionCable.server.broadcast('import_channel', id: id, filename: filename, status: 'failed')
  end

  def import_categories
    spreadsheet = categories_spreadsheet
    header_index = 1
    header = spreadsheet.row(header_index)

    (header_index + 1..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      row.each_value { |c| c.try(:squish!) }
      title = row['Category']
      parent_title = get_parent_title(title, row['Parent'])
      parent_category = find_category(parent_title)
      category = current_scope(parent_category).find_or_initialize_by(title: title)
      if background_url = row['Images']
        url = get_drive_file(background_url)
        category.photo_attributes = { remote_image_url: url }
      end
      # NB: manually adding `/category.title` because it is not yet saved and
      # the caching inside the method seems to break fetching ¯\_(ツ)_/¯
      if category.save
        notify "Saved category: #{category.title_with_nesting}"
      else
        notify "Failed to save category: #{category.title_with_nesting}"
        notify category.errors.full_messages, 'ERROR'
      end
    end
  end

  def import_questions
    spreadsheet = questions_spreadsheet
    header_index = 2
    header = spreadsheet.row(header_index)

    (header_index + 1..spreadsheet.last_row).each do |row_num|
      row = Hash[[header, spreadsheet.row(row_num)].transpose]
      row.each_value { |c| c.try(:squish!) }
      title = row['Question']
      next unless title_present(title)
      question = Question.find_or_initialize_by(title: title)
      category = find_category(row['Category'])
      unless category
        notify "Category #{row['Category']} not found", 'WARNING'
        next
      end
      question.category = category
      question.kind = QUESTION_TYPES[row['Question Type']]
      question.allows_note = row['Commentable'] == 'Yes'
      question.intro = row['Onboarding Question?'] == 'Yes'

      if background_url = row['Background image URL']
        url = get_drive_file(background_url)
        question.photo_attributes = { remote_image_url: url }
      end

      question.answers_attributes = get_answers(question, row, row_num)
      if question.save
        notify "Saved question: #{question.title}"
      else
        notify "Failed to save question: #{question.title}"
        notify question.errors.full_messages, 'ERROR'
      end
    end
  end

  def update_locking_conditions
    spreadsheet = questions_spreadsheet
    header_index = 2
    header = spreadsheet.row(header_index)

    (header_index + 1..spreadsheet.last_row).each do |row_num|
      row = Hash[[header, spreadsheet.row(row_num)].transpose]
      row.each_value { |c| c.try(:squish!) }
      title = row['Question']
      next unless title_present(title)
      question = Question.find_by(title: title)

      locking_conditions = []

      if question
        if row['Question IDs'] && row['Question Answer ID']
          q_value = spreadsheet.formatted_value(row_num, 3)
          a_value = spreadsheet.formatted_value(row_num, 4)
          question_ids = q_value.split(',')
          # NB: for some reason he's putting answer ids in brackets ¯\_(ツ)_/¯
          answer_ids = a_value.gsub(/\(|\)/, '').split(',')

          answer_ids.each_with_index do |answer_id, idx|
            question_id = question_ids[idx] || question_ids[0]

            question_row = question_rows.find { |r| r['ID'] == question_id.to_i }
            question_title = question_row['Question']
            answer_title = question_row["Answer #{answer_id}"]
            next unless title_present(question_title)

            locking_question = Question.find_by(title: question_title)
            answer = locking_question.answers.find_by(title: answer_title)
            if answer
              locking_conditions.push(
                question_id: locking_question.id,
                answer: answer.title
              )
            else
              notify "Could not find answer: '#{answer_title}' for question " \
                     "#{question_title}", 'WARNING'
            end
          end
          # locking_conditions = Hash[[question_ids, answer_ids].transpose]
          if locking_conditions.length
            notify "Updating locking conditions for #{question.title}"
            question.update locking_conditions: locking_conditions
          else
            notify "No locking conditions to update for #{question.title}"
          end
        else
          notify "No locking conditions for #{title}"
        end
      else
        notify "Could not find question: #{title}", 'WARNING'
      end
    end
  end

  def update_visibility_conditions
    spreadsheet = categories_spreadsheet
    header_index = 1
    header = spreadsheet.row(header_index)

    (header_index + 1..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      row.each_value { |c| c.try(:squish!) }
      next unless row['Visibility Conditions']
      title = row['Category']
      parent_title = get_parent_title(title, row['Parent'])
      parent_category = find_category(parent_title)
      category = current_scope(parent_category).find_by(title: title)

      if category
        conditions = get_visibility_conditions(row['Visibility Conditions'])
        category.visibility_conditions = conditions
        notify "Updating #{category.title_with_nesting} visibility conditions"
        category.save!
      elsif parent_title
        notify "Could not find category with title: '#{title}' for parent: " \
                "#{parent_title} while updating visibility conditions", 'WARNING'
      else
        notify "Could not find category with title: '#{title}' " \
               'while updating visibility conditions', 'WARNING'
      end
    end
  end

  private

  def categories_spreadsheet
    @categories_spreadsheet ||= begin
      spreadsheet = Roo::Spreadsheet.open(file.url)
      spreadsheet.sheet(0)
    end
  end

  def questions_spreadsheet
    @questions_spreadsheet ||= begin
      spreadsheet = Roo::Spreadsheet.open(file.url)
      spreadsheet.sheet(2)
    end
  end

  def get_visibility_conditions(visibility_conditions)
    return nil unless visibility_conditions
    conditions = []
    YAML.safe_load(visibility_conditions).each do |condition|
      question = Question.find_by(title: condition['question'].squish)
      if question
        answer = question.answers.find_by(title: condition['answer'].squish)
        unless answer
          notify "WARNING: Answer not found for question #{question.id}: " \
                 "#{condition['answer']}", 'WARNING'
        end
        conditions.push(question_id: question.id, answer: condition['answer'].squish)
      else
        notify "Question not found: #{condition['question']}", 'WARNING'
      end
    end
    conditions
  end

  def find_category(parent_title)
    return nil unless parent_title
    parent_array = parent_title.split('/')
    category = nil
    parent_array.each do |category_title|
      category = current_scope(category).find_by(title: category_title)
    end
    category
  end

  def current_scope(category)
    return category.children if category
    Category.all
  end

  def get_parent_title(title, parent_title)
    return nil unless parent_title
    parent_array = parent_title.split('/')
    if parent_array.last == title
      parent_array.pop
      return parent_array.join('/')
    end
    parent_array.join('/')
  end

  def title_present(title)
    title || puts('Question title missing, skipping...')
  end

  def get_answers(question, row, row_num)
    answers_attributes = []
    (1..20).each do |n|
      col_num = n * 2 + 8

      begin
        answer_value = questions_spreadsheet.formatted_value(row_num, col_num)
        next unless answer_value
      rescue
        next
      end

      case QUESTION_TYPES[row['Question Type']]
      when 'number_range', 'number'
        answer_value.to_s.split('-').each do |answer_title|
          answer_attributes = attributes_for_answer(question, answer_title, row, n)
          answers_attributes.push(answer_attributes)
        end
      else
        answer_attributes = attributes_for_answer(question, answer_value, row, n)
        answers_attributes.push(answer_attributes)
      end
    end
    answers_attributes
  end

  def attributes_for_answer(question, title, row, answer_idx)
    answer_attributes = {
      title: title,
      photo_attributes: { remote_image_url: get_drive_file(row["A#{answer_idx} Image URL"]) },
      position: answer_idx
    }
    existing_answer = question.answers.find_by(title: title)
    answer_attributes[:id] = existing_answer.id if existing_answer
    answer_attributes
  end

  def get_drive_file(url)
    if url =~ GOOGLE_DRIVE_REGEX
      file_id = Regexp.last_match[1]
      drive_uri = URI("https://drive.google.com/uc?id=#{file_id}")
      result = Net::HTTP.get_response(drive_uri)
      result['location']
    end
  rescue => e
    notify "ERROR: Bad url: #{url}", 'ERROR'
    notify e.to_s, 'ERROR'
    nil
  end

  def question_rows
    spreadsheet = questions_spreadsheet
    header_index = 2
    header = spreadsheet.row(header_index)

    (header_index + 1..spreadsheet.last_row).map do |row_num|
      row = Hash[[header, spreadsheet.row(row_num)].transpose]
      row.each_value { |c| c.try(:squish!) }
      row
    end
  end

  def notify(message, level = 'INFO')
    puts message
    self.log = [log, message].compact.join('\n')
    # ::ActionCable.server.broadcast(
    #   'import_channel',
    #   level: level,
    #   message: message
    # )
  end

  def schedule_import
    ImportJob.perform_later(self)
  end
end
