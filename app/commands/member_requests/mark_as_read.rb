class MemberRequests::MarkAsRead
  prepend SimpleCommand

  def initialize(params)
    staff_member = params[:staff_member]
    @member_request = staff_member.member_requests.find(params[:member_request_id])
  end

  def call
    return @member_request if @member_request.member_request_messages.from_member.unread.map(&:mark_as_read!)
    nil
  end
end
