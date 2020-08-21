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

RSpec.describe User, type: :model do
  let(:user) { build(:user) }
  subject { user }

  it { is_expected.to be_versioned }

  describe 'associations' do
    it { is_expected.to have_one(:photo).dependent(:destroy) }
    it { is_expected.to have_many(:answers).dependent(:destroy) }
    it { is_expected.to have_many(:shares).dependent(:destroy) }
    it { is_expected.to have_many(:profile_requests).dependent(:destroy) }
    it { is_expected.to have_many(:devices).dependent(:destroy) }
    it { is_expected.to have_many(:ignores).dependent(:destroy) }
    it { is_expected.to have_many(:interactions).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to be_valid }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_length_of(:password).is_at_least(8) }

    context 'with invalid email' do
      let(:user) { build(:user, email: 'test') }
      let(:message) do
        i18n_scope = 'activerecord.errors.models.user.attributes.email.invalid'
        I18n.translate(i18n_scope)
      end

      it { is_expected.not_to be_valid }
      it { expect(subject.errors_on(:email)).to include(message) }
    end
  end
end
