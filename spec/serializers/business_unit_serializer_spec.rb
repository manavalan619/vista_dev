# == Schema Information
#
# Table name: business_units
#
#  id              :bigint(8)        not null, primary key
#  name            :string
#  organisation_id :bigint(8)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  archived_at     :datetime
#
# Indexes
#
#  index_business_units_on_organisation_id  (organisation_id)
#
# Foreign Keys
#
#  fk_rails_...  (organisation_id => organisations.id)
#

require 'rails_helper'

RSpec.describe BusinessUnitSerializer do
  let(:serializer) { BusinessUnitSerializer.new(business_unit) }
  let(:business_unit) { create(:business_unit) }

  subject { JSON.parse(serializer.to_json) }

  it { expect(subject['id']).to eq(business_unit.id) }
  it { expect(subject['name']).to eq(business_unit.name) }
end
