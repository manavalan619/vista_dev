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

require 'rails_helper'

RSpec.describe OrganisationSerializer do
  let(:serializer) { OrganisationSerializer.new(organisation) }
  let(:organisation) { create(:organisation) }

  subject { JSON.parse(serializer.to_json) }

  it { expect(subject['id']).to eq(organisation.id) }
  it { expect(subject['name']).to eq(organisation.name) }
  it { expect(subject['address']).to be_a(Hash) }
end
