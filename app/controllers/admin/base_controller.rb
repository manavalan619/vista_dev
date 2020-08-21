class Admin::BaseController < ApplicationController
  before_action :authenticate_vista_admin!
  before_action :set_raven_context
  before_action :set_paper_trail_whodunnit
  # before_action :check_release_data
  after_action :prepare_unobtrusive_flash

  rescue_from Pundit::NotAuthorizedError, with: :not_authorized

  layout 'admin'

  def pundit_user
    current_vista_admin
  end

  def user_for_paper_trail
    current_vista_admin.try(:id) || 'Missing'
  end

  private

  def not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_to(admin_root_path)
  end

  def set_raven_context
    Raven.user_context(
      id: current_vista_admin.try(:id),
      type: 'VistaAdmin',
      ip_address: request.ip
    )
    Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end

  # TODO: finish me, but maybe move me to a helper
  def check_release_data
    release = Release.limit(1).pluck(:created_at).first

    if release.blank?
      flash[:notice] << 'No current release. Consider creating a release.'
      return
    end

    questions_count = Question.updated_since(release).count
    categories_count = Category.updated_since(release).count

    return unless categories_count.positive? || questions_count.positive?

    initial_message = 'There have been'
    message = [initial_message]

    message.push("#{categories_count} categories") if categories_count.positive?
    message.push('and') if categories_count.positive? && questions_count.positive?
    message.push("#{questions_count} questions") if questions_count.positive?
    message.push('updated since last release. Consider creating a new release.')

    flash[:notice] << message.join(' ')
  end
end
