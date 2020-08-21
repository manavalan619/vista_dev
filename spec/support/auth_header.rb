def auth_headers(user)
  { 'Authorization' => "Token token=#{user.authentication_token}" }
end
