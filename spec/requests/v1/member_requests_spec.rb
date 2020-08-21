require 'rails_helper'

RSpec.describe 'Api::V1::MemberRequestsController', type: :request do
  let(:user) { create(:user) }
  let(:branch) { create(:branch) }
  let(:staff_member) { create(:staff_member) }
  let(:member_request) { create(:member_request, user: user, branch: branch) }
  let!(:member_request_message) { create(:member_request_message, messageable: user, member_request: member_request) }

  describe 'GET /api/v1/member_requests' do
    it 'should return member requests for the current user' do
      get api_v1_member_requests_url(subdomain: 'api'), params: { branch_id: branch.id }, headers: auth_headers(user)
      expect(JSON.parse(response.body)[0]["id"]).to eq member_request.id
    end
  end

  describe 'GET /api/v1/member_request/:id' do
    it 'should return the member request messages' do
      get api_v1_member_request_url(subdomain: 'api', id: member_request.id), headers: auth_headers(user)
      expect(JSON.parse(response.body)["memberRequestMessages"][0]["body"]).to eq member_request_message.body
    end
  end

  describe 'POST /api/v1/member_requests' do
    subject { response }

    it 'should create a new member request' do
      expect {
        post api_v1_member_requests_url(subdomain: 'api'), headers: auth_headers(user), params: {
          "member_request": {
            "member_request_type_id": create(:member_request_type, business_unit: branch.business_unit).id,
            "branch_id": branch.id,
            "member_request_messages_attributes": [{
              "body": "Testing creating a new MR with a MRM"
            }]
          }
        }
      }.to change { MemberRequest.count }.by 1
    end

    it 'should create the initial provided message for the request' do
      expect {
        post api_v1_member_requests_url(subdomain: 'api'), headers: auth_headers(user), params: {
          "member_request": {
            "member_request_type_id": create(:member_request_type, business_unit: branch.business_unit).id,
            "branch_id": branch.id,
            "member_request_messages_attributes": [{
              "body": "Testing creating a new MR with a MRM"
            }]
          }
        }
      }.to change { MemberRequestMessage.count }.by 1
    end
  end

  describe 'POST /api/v1/member_requests/:id/mark_as_read' do
    subject { response }

    it 'should mark all staff member unread messages as read' do
      staff_member_message = create(:member_request_message, member_request: member_request, messageable: staff_member, body: 'test')
      expect {
        post mark_as_read_api_v1_member_request_url(subdomain: 'api', id: member_request.id), headers: auth_headers(user)
      }.to change { MemberRequestMessage.last.status }.to 'read'
    end
  end

  describe 'POST /api/v1/member_requests/:id/send_message' do
    subject { response }

    it 'should create a new message for the request' do
      expect {
        post send_message_api_v1_member_request_url(subdomain: 'api', id: member_request.id), headers: auth_headers(user), params: {
          message: { body: 'new message' }
        }
      }.to change { MemberRequestMessage.count }.by 1
    end
  end
end
