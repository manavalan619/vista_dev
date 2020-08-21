module Admin::ReleasesHelper
  def release_status(release)
    case release.status
    when 'queued'
      fa_icon('fw clock-o', text: 'Queued')
    when 'processing'
      fa_icon('fw cog spin', text: 'Processing')
    when 'complete'
      fa_icon('fw check', text: 'Complete')
    end
  end
end
