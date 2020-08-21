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

FactoryBot.define do
  factory :photo do
    association :owner, factory: :user
    image { fixture_file('trump.jpg') }
  end
end

def fixture_file(file_name)
  Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'fixtures', file_name), 'image/jpg')
end
