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

require 'rails_helper'

RSpec.describe VistaAdmin, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
