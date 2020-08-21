after 'development:members' do
  if MemberRequest.any?
    return
  end

  member = User.find_by(email: 'seed-member@kanso.io')
  branch = member.authorised_branches.last
  staff_member = branch.staff_members.find_or_create_by(email: 'seed-staff-member@kanso.io')
  staff_member.first_name = 'Jane'
  staff_member.last_name = 'Bloggs'
  staff_member.organisation = branch.business_unit.organisation
  staff_member.employee_id = '123abc'
  staff_member.assigned_branches << branch
  staff_member.save

  50.times do |i|
    request_type = branch.business_unit.member_request_types.find_or_create_by(name: 'Test Type')
    request = MemberRequest.create(branch: branch, user: member, member_request_type: request_type)
    request.member_request_messages.create(
      messageable: member,
      body: "Test member request message #{i}"
    )

    request.member_request_messages.create(
      messageable: staff_member,
      body: "Test staff member reply to a request #{i}"
    )
  end
end
