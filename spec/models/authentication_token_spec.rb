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

require 'rails_helper'

RSpec.describe AuthenticationToken, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
