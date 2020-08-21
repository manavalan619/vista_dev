module Admin::VideosHelper
  def published_status(video)
    video.published? ? 'Published' : 'Not Published'
  end

  def published_at(video)
    return 'n/a' if !video.published?

    video.published_at&.localtime&.strftime('%A, %e %B %Y at %H:%M')
  end

  def organisation_name(video)
    video.organisation ? video.organisation.name : 'Vista'
  end

  def organisation_select
    Organisation.all.map { |o| [o.name, o.id] }.unshift(['Vista', 'vista'])
  end
end
