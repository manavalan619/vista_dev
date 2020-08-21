class MemberRequests::Message
  prepend SimpleCommand

  def initialize(params)
    staff_member = params[:staff_member]
    member_request = staff_member.member_requests.find(params[:member_request_id])
    @member_request_message = member_request.member_request_messages.new(
      messageable: staff_member,
      body: params[:body]
    )
  end

  def call
    if @member_request_message.save
      Notification::NewMessage.create(object: @member_request_message, user: @member_request_message.member_request.user)
      return @member_request_message
    end
    @member_request_message.errors.map { |key, value| errors.add(key, value) }
    nil
  end
end
