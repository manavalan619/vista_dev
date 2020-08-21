class MemberRequests::Update
  prepend SimpleCommand

  def initialize(params)
    staff_member = params[:staff_member]
    @request_type_id = params[:member_request_type_id]
    @member_request = staff_member.member_requests.find(params[:member_request_id])
    @member_request.status = params[:status] if params[:status]
    @member_request.member_request_type_id = @request_type_id if @request_type_id
  end

  def call
    if @member_request.save
      if @request_type_id
        @member_request.mark_as_unread
      end

      return @member_request
    end

    @member_request.errors.map { |key, value| errors.add(key, value) }
    nil
  end
end
