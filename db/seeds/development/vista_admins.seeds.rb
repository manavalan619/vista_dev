VistaAdmin.create_with(
  first_name: 'Kanso',
  last_name: 'Team',
  password: 'password',
  confirmed_at: Time.now.utc
).find_or_create_by(email: 'team@kanso.io')
