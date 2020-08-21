class ReleaseJob < ApplicationJob
  queue_as :releases

  def perform(release)
    @release = release
    @release.process!

    categories_json = []
    Category.find_each do |category|
      category_json = serialized(category)
      categories_json << category_json
    end

    questions_json = []
    Question.find_each do |question|
      question_json = serialized(question)
      questions_json << question_json
    end

    full_json = {
      version: @release.created_at.to_i,
      categories: categories_json,
      questions: questions_json
    }

    file = Tempfile.new(filename, "#{Rails.root}/tmp")
    file.binmode

    begin
      file.write(full_json.to_json)
      file.rewind
      @release.complete!(file: Rails.root.join(file.path).open)
    ensure
      file.close
      file.unlink
    end
  end

  private

  def serialized(object)
    ActiveModelSerializers::SerializableResource.new(
      object, scope: serializer_scope
    ).serializable_hash
  end

  def filename
    "release-#{@release.created_at.to_i}.json"
  end

  def serializer_scope
    OpenStruct.new(current_user: User.new)
  end
end
