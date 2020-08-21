# == Schema Information
#
# Table name: users
#
#  id                     :bigint(8)        not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  authentication_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  archived_at            :datetime
#  first_name             :string
#  last_name              :string
#  job_title              :string
#  company                :string
#  address                :string
#  onboarding_complete    :boolean          default(FALSE)
#  gender                 :string
#  preferences            :jsonb
#
# Indexes
#
#  index_users_on_authentication_token  (authentication_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_first_name            (first_name)
#  index_users_on_last_name             (last_name)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

require 'rails_helper'

RSpec.describe UserSerializer do
  subject { JSON.parse(UserSerializer.new(user).to_json) }
  let(:user) { FactoryBot.create(:user) }

  it { expect(subject['id']).to eq(user.id) }
  it { expect(subject['email']).to eq(user.email) }
  it { expect(subject['first_name']).to eq(user.first_name) }
  it { expect(subject['last_name']).to eq(user.last_name) }
  it { expect(subject['name']).to eq(user.name) }
  it { expect(subject['job_title']).to eq(user.job_title) }
  it { expect(subject['company']).to eq(user.company) }
  it { expect(subject['address']).to eq(user.address) }
  it { expect(subject['member_id']).to eq(user.member_id) }
  it { expect(subject['updated_at']).to eq(user.updated_at.iso8601(3)) }
  it { expect(subject['avatar']).to eq(user.photo) }
  it { expect(subject['onboarding_complete']).to eq(user.onboarding_complete) }
end
