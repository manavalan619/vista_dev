module Api::V1
  class NotificationsController < Api::V1::BaseController
    after_action :mark_all_read, only: :index

    def index
      @notifications = current_user.notifications.includes(:object).page(params[:page])
      render json: @notifications
    end

    def update
      @notification = current_user.notifications.find(params[:id])
      if @notification.update(notification_params)
        render json: @notification, status: 204
      else
        render json: @notification, status: 422
      end
    end

    private

    def notification_params
      # NOTE: this may need to change in future to allow arrays
      params.require(:notification).permit(:response)
    end

    # NB: only mark the notifications returned in query so that we don't mark
    # new notifications as unread accidentally
    def mark_all_read
      @notifications.unread.mark_all_read
    end
  end
end
