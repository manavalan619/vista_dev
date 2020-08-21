namespace :import do
  desc 'Import categories and questions'
  task all: :environment do
    DataImport.import_all(File.open(ENV['file']))
  end

  desc 'Import categories from a spreadsheet'
  task categories: :environment do
    d = DataImport.new(File.open(ENV['file']))
    d.import_categories
  end

  desc 'Update category visibility conditions'
  task update_visibility_conditions: :environment do
    d = DataImport.new(File.open(ENV['file']))
    d.update_visibility_conditions
  end

  desc 'Import questions and answers from a spreadsheet'
  task questions: :environment do
    d = DataImport.new(File.open(ENV['file']))
    d.import_questions
  end

  desc 'Update question locking conditions'
  task update_locking_conditions: :environment do
    d = DataImport.new(File.open(ENV['file']))
    d.update_locking_conditions
  end
end
