# frozen_string_literal: true
# == Schema Information
#
# Table name: organisations
#
#  id          :bigint(8)        not null, primary key
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  about       :text
#  archived_at :datetime
#

class OrganisationSerializer < ApplicationSerializer
  attributes :id, :name, :about
  attribute :sharing_profile, if: :user?

  has_one :address
  has_one :photo

  def sharing_profile
    # TODO: implement this
    false
  end

  def user?
    scope.current_user.is_a?(User)
  end
end
