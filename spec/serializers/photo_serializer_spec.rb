# == Schema Information
#
# Table name: photos
#
#  id         :bigint(8)        not null, primary key
#  owner_id   :integer
#  owner_type :string
#  image      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  photo_type :string
#
# Indexes
#
#  index_photos_on_owner_id_and_owner_type_and_photo_type  (owner_id,owner_type,photo_type)
#  index_photos_on_photo_type                              (photo_type)
#

require 'rails_helper'

RSpec.describe PhotoSerializer do
  subject { JSON.parse(PhotoSerializer.new(photo).to_json) }
  let(:photo) { FactoryBot.create(:photo) }

  it { expect(subject['id']).to eq(photo.id) }
  it { expect(subject['large_url']).to eq(photo.image.large.url) }
  it { expect(subject['thumb_url']).to eq(photo.image.thumb.url) }
end
