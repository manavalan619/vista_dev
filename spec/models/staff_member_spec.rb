# == Schema Information
#
# Table name: staff_members
#
#  id                     :bigint(8)        not null, primary key
#  email                  :string           default(""), not null
#  first_name             :string
#  last_name              :string
#  mobile_number          :string
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
#  organisation_id        :bigint(8)
#  type                   :string
#  employee_id            :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  suspended_at           :datetime
#  archived_at            :datetime
#  encrypted_pin          :string
#  unconfirmed_email      :string
#
# Indexes
#
#  index_staff_members_on_archived_at                      (archived_at)
#  index_staff_members_on_authentication_token             (authentication_token) UNIQUE
#  index_staff_members_on_confirmation_token               (confirmation_token) UNIQUE
#  index_staff_members_on_email                            (email)
#  index_staff_members_on_employee_id_and_organisation_id  (employee_id,organisation_id) UNIQUE
#  index_staff_members_on_organisation_id                  (organisation_id)
#  index_staff_members_on_reset_password_token             (reset_password_token) UNIQUE
#  index_staff_members_on_suspended_at                     (suspended_at)
#

require 'rails_helper'

RSpec.describe StaffMember, type: :model do
  let(:user) { build(:staff_member) }
  subject { user }

  describe 'associations' do
    it { is_expected.to belong_to(:organisation) }
    it { is_expected.to have_many(:staff_assignments).dependent(:destroy) }
    it { is_expected.to have_many(:assigned_branches) }
    # it { is_expected.to have_many(:photos).dependent(:destroy) }
    it { is_expected.to have_many(:role_assignments).dependent(:destroy) }
    it { is_expected.to have_many(:roles).through(:role_assignments) }
    it { is_expected.to have_many(:interactions) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:employee_id) }
    it do
      is_expected.to validate_uniqueness_of(:employee_id)
        .scoped_to(:organisation_id).case_insensitive
    end
    it { is_expected.to validate_length_of(:password).is_at_least(8) }

    # FIXME: not sure whether the spec is bad or the implementation is wrong
    # context 'when password has already been set' do
    #   it { is_expected.to validate_presence_of(:password) }
    # end

    context 'when basic staff member' do
      it 'validates that the length of assigned branches is at least 1' do
        user.assigned_branches = []
        expect(subject).to be_invalid
        expect(subject.errors_on(:assigned_branches)).to \
          include('must be assigned to at least 1 branch')
      end
    end

    context 'when branch manager' do
      let(:user) { build(:branch_manager)}
      it { is_expected.to validate_presence_of(:email) }

      it 'validates that the length of assigned branches is at least 1' do
        user.assigned_branches = []
        expect(subject).to be_invalid
        expect(subject.errors_on(:assigned_branches)).to \
          include('must be assigned to at least 1 branch')
      end

      context 'with invalid email' do
        let(:user) { build(:branch_manager, email: 'test') }

        it { is_expected.not_to be_valid }
        it { expect(subject.errors_on(:email)).to include('is invalid') }
      end
    end

    context 'when admin' do
      let(:user) { build(:admin)}
      it { is_expected.to validate_presence_of(:email) }

      context 'with invalid email' do
        let(:user) { build(:admin, email: 'test') }

        it { is_expected.not_to be_valid }
        it { expect(subject.errors_on(:email)).to include('is invalid') }
      end
    end

    context 'when password has not been set' do
      it { is_expected.to_not validate_presence_of(:password) }
    end
  end
end
