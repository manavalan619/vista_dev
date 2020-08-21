# == Schema Information
#
# Table name: authentication_tokens
#
#  id           :bigint(8)        not null, primary key
#  context      :string
#  body         :string
#  user_type    :string
#  user_id      :bigint(8)
#  last_used_at :datetime
#  ip_address   :inet
#  user_agent   :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_authentication_tokens_on_context                (context)
#  index_authentication_tokens_on_user_type_and_user_id  (user_type,user_id)
#

FactoryBot.define do
  factory :authentication_token do
    body { 'MyString' }
    user
    kind { 'MyString' }
    last_used_at { '2018-01-10 14:56:07' }
    ip_address { '' }
    user_agent { 'MyString' }
  end
end
