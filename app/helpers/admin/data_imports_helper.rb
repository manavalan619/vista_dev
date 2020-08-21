module Admin::DataImportsHelper
  def import_status(data_import)
    case data_import.status
    when 'new'
      fa_icon('fw clock-o', text: 'Queued')
    when 'running'
      fa_icon('fw cog spin', text: 'Running')
    when 'finished'
      fa_icon('fw check', text: 'Finished')
    when 'failed'
      fa_icon('fw exclamation-triangle', text: 'Failed')
    end
  end
end
