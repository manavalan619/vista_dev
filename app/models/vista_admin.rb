# == Schema Information
#
# Table name: vista_admins
#
#  id                     :bigint(8)        not null, primary key
#  first_name             :string
#  last_name              :string
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
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  failed_attempts        :integer          default(0), not null
#  unlock_token           :string
#  locked_at              :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_vista_admins_on_confirmation_token    (confirmation_token) UNIQUE
#  index_vista_admins_on_email                 (email) UNIQUE
#  index_vista_admins_on_reset_password_token  (reset_password_token) UNIQUE
#  index_vista_admins_on_unlock_token          (unlock_token) UNIQUE
#

class VistaAdmin < ApplicationRecord
  has_many :videos

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :trackable, :validatable, :confirmable

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
