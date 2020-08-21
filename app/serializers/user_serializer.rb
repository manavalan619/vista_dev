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

class UserSerializer < ApplicationSerializer
  attributes :id, :email, :first_name, :last_name, :name, :job_title, :company,
             :address, :member_id, :updated_at, :onboarding_complete, :gender,
             :mood, :preferences
  attribute :authentication_token, if: :just_registered?

  has_one :photo, key: :avatar

  def just_registered?
    [%w[members create], %w[partners create]].include?(context) &&
      !errors_present?
  end

  def context
    [scope.controller_name, scope.action_name] if scope
  end
end
