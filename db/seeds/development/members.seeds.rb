after 'development:branches' do
  user = User.find_or_create_by(email: 'seed-member@kanso.io')
  user.password = 'password'
  user.first_name = 'Seed'
  user.last_name = 'Member'
  user.save

  if user.authorised_branches.size === 0
    bu = BusinessUnit.find_by(name: 'Developer Division')
    branch = bu.branches.last
    share = Share.create(user: user, branch: branch, authorised_at: Time.now, status: 'authorised')
  end
end
