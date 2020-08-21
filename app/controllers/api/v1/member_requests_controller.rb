module Api::V1
  class MemberRequestsController < Api::V1::BaseController
    before_action :find_member_request, except: [:index, :create, :request_details]
    serialization_scope :current_user

    def index
      @member_requests = current_user.member_requests.for_branch(params[:branch_id]).includes(:member_request_type).order('updated_at DESC').page(params[:page])
      render json: @member_requests, limit_messages: true if stale?(@member_requests)
    end

    def show
      render json: @member_request if stale?(@member_request)
    end

    def create
      @member_request = current_user.member_requests.new(new_request_params)

      if @member_request.save
        render json: @member_request, status: 200
      else
        render json: @member_request, status: 422
      end
    end

    def mark_as_read
      @member_request.member_request_messages.from_staff_member.unread.map(&:mark_as_read!)

      render json: @member_request, status: 200
    end

    def send_message
      message = @member_request.member_request_messages.new(messageable: current_user)
      message.assign_attributes(message_params)

      if message.save
        render json: message, status: 200
      else
        render json: message, status: 422
      end
    end

    # Endpoint for retrieving a MemberRequest
    # used when a member receives a NewMessage push notification
    # in order to retrieve relevant request/branch details
    def request_details
      member_request = current_user.member_requests.with_message(params[:id]).first

      if member_request
        render json: member_request, status: 200
      else
        render json: 'Not Found', status: 422
      end
    end


    private

    # ensure messageable is set on any incoming message attached to member request
    # as accepts_nested_attributes_for on MemberRequest has polymorphic relationship
    def new_request_params
      new_params = request_params

      messages = new_params[:member_request_messages_attributes].map do |message|
        message = message.merge(messageable: current_user, skip_notify: true)
      end

      new_params[:member_request_messages_attributes] = messages
      new_params
    end

    def request_params
      params.require(:member_request).permit(
        :member_request_type_id, :branch_id, member_request_messages_attributes: %i[body]
      )
    end

    def message_params
      params.require(:message).permit(:body)
    end

    def find_member_request
      @member_request = current_user.member_requests.find(params[:id])
    end
  end
end
