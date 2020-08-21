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

class StaffMember < ApplicationRecord
  acts_as_paranoid column: :archived_at

  belongs_to :organisation
  has_many :staff_assignments, dependent: :destroy
  has_many :assigned_branches,
           class_name: 'Branch',
           through: :staff_assignments,
           source: :target, source_type: 'Branch'
  has_many :assigned_business_units,
           class_name: 'BusinessUnit',
           through: :assigned_branches,
           source: :business_unit
  # TODO: check if this is needed, IMO it should be singular
  # has_many :photos, as: :owner, dependent: :destroy
  has_many :role_assignments, dependent: :destroy
  has_many :roles, through: :role_assignments
  has_many :member_request_types, through: :roles
  has_many :interactions
  has_many :authentication_tokens, as: :user, dependent: :destroy
  has_many :preference_groups, through: :roles
  has_many :member_request_messages, as: :messageable
  has_many :member_requests, through: :assigned_branches

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :trackable, :validatable, :confirmable

  has_secure_token :authentication_token

  validates :employee_id,
            presence: true,
            uniqueness: { scope: :organisation_id, case_sensitive: false }
  validates :first_name, :last_name, presence: true
  validates :organisation, presence: true
  validates :assigned_branches, length: {
    minimum: 1, message: 'must be assigned to at least 1 branch'
  }, unless: :admin?
  accepts_nested_attributes_for :roles
  # accepts_nested_attributes_for :photos

  scope :with_type, ->(type) { where(type: type) }
  scope :only_staff_members, -> { with_type(nil) }
  scope :only_branch_managers, -> { with_type('BranchManager') }
  scope :only_admins, -> { with_type('Admin') }
  scope :management, -> { with_type(%w[Admin BranchManager]) }
  scope :with_role, ->(role) { joins(:roles).where(roles: { id: role }) }

  attr_reader :pin
  attr_accessor :pin_confirmation

  def pin=(new_pin)
    @pin = new_pin
    self.encrypted_pin = password_digest(@pin) if @pin.present?
  end

  def valid_pin?(pin)
    Devise::Encryptor.compare(self.class, encrypted_pin, pin)
  end

  def name
    [first_name, last_name].join(' ')
  end

  # new function to set the password without knowing the current
  # password used in our confirmation controller.
  def attempt_set_password(params)
    p = {}
    p[:password] = params[:password]
    p[:password_confirmation] = params[:password_confirmation]
    update_attributes(p)
  end

  # new function to return whether a password has been set
  def no_password?
    encrypted_password.blank?
  end
  alias has_no_password? no_password?

  # Devise::Models:unless_confirmed` method doesn't exist in Devise 2.0.0 anymore.
  # Instead you should use `pending_any_confirmation`.
  def only_if_unconfirmed
    pending_any_confirmation { yield }
  end

  def password_match?
    check_blank
    check_confirmation_blank
    check_passwords_match
    password == password_confirmation && !password.blank?
  end

  # def type=(type)
  #   super(type == 'StaffMember' ? nil : type)
  # end

  def status
    suspended_at.present? ? 'suspended' : 'active'
  end

  def branch_id=(branch_id)
    self.branch = Branch.find(branch_id)
  end

  def status=(status)
    case status
    when 'active'
      assign_attributes(suspended_at: nil)
    when 'suspended'
      assign_attributes(suspended_at: Time.now)
    end
  end

  def suspend
    update_attributes(suspended_at: Time.now)
  end

  def unsuspend
    update_attributes(suspended_at: nil)
  end

  def suspended?
    suspended_at.present?
  end

  def archived?
    archived_at.present?
  end

  def active_for_authentication?
    super && !suspended? && !archived?
  end

  def inactive_message
    if archived_at.present?
      :archived
    elsif suspended_at.present?
      :suspended
    else
      super
    end
  end

  %w[branch_manager admin].each do |role|
    define_method("#{role}?") { is_a?(role.classify.constantize) }
  end

  protected

  def email_required?
    branch_manager? || admin?
  end

  def password_required?
    # NB: Password is required if it is being set, but not for new records
    if new_record?
      false
    else
      password.present? || password_confirmation.present?
    end
  end

  private

  def check_blank
    add_error(:password, 'password_blank') if password.blank?
  end

  def check_confirmation_blank
    return unless password_confirmation.blank?
    add_error(:password_confirmation, 'password_blank')
  end

  def check_passwords_match
    return unless password != password_confirmation
    add_error(:password_confirmation, 'password_missmatch')
  end

  def add_error(field, error_idendifier)
    errors[field] = error_message(error_idendifier)
  end

  def error_message(identifier)
    I18n.t("errors.messages.#{identifier}")
  end
end
