class ImportJob < ApplicationJob
  queue_as :imports

  def perform(data_import)
    data_import.import_all
  end
end
