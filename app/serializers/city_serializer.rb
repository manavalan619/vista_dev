# == Schema Information
#
# Table name: cities
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  status     :string
#
# Indexes
#
#  index_cities_on_status  (status)
#

class CitySerializer < ApplicationSerializer
  attributes :id, :name, :status

  has_one :photo
end
