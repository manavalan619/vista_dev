class Partners::BaseController < ApplicationController
  before_action :authenticate_staff_member!
  before_action :set_raven_context
  before_action :set_paper_trail_whodunnit
  after_action :prepare_unobtrusive_flash

  rescue_from Pundit::NotAuthorizedError, with: :not_authorized

  layout 'admin'

  helper_method :current_organisation

  def pundit_user
    current_staff_member
  end

  def user_for_paper_trail
    current_staff_member.try(:id) || 'Missing'
  end

  private

  def not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_to(partners_root_path)
  end

  def current_organisation
    current_staff_member.organisation if staff_member_signed_in?
  end

  def set_raven_context
    Raven.user_context(
      id: current_staff_member.try(:id),
      type: current_staff_member.try(:class).try(:to_s) || 'StaffMember',
      ip_address: request.ip
    )
    Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end
end
