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

RSpec.describe Photo, type: :model do
  subject { build(:photo) }

  describe 'associations' do
    it { is_expected.to belong_to(:owner) }
  end

  describe 'validations' do
    it { is_expected.to be_valid }

    context 'with empty image' do
      subject { FactoryBot.build(:photo, image: nil) }

      it { is_expected.not_to be_valid }
      it { expect(subject.errors_on(:image)).to include('can\'t be blank') }
    end
  end
end
