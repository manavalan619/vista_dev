class MemberRequests::Finalise
  prepend SimpleCommand

  def initialize(params)
    @staff_member = params[:staff_member]
    @member_request = @staff_member.member_requests.find(params[:member_request_id])
    @interaction = Interaction.find(params[:interaction_id])
  end

  def call
    message = @member_request.member_request_messages.new(
      messageable: @staff_member,
      body: "This request has now been closed with the following interaction:\n\n#{@interaction.notes}"
    )

    if message.save
      Notification::NewMessage.create(object: message, user: @member_request.user)
    end

    nil
  end
end
