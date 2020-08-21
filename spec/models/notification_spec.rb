# == Schema Information
#
# Table name: notifications
#
#  id           :bigint(8)        not null, primary key
#  user_id      :bigint(8)
#  type         :string
#  response     :jsonb
#  object_type  :string
#  object_id    :bigint(8)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  read_at      :datetime
#  responded_at :datetime
#
# Indexes
#
#  index_notifications_on_object_type_and_object_id  (object_type,object_id)
#  index_notifications_on_read_at                    (read_at)
#  index_notifications_on_type                       (type)
#  index_notifications_on_user_id                    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

require 'rails_helper'

RSpec.describe Notification, type: :model do
  subject { notification }

  let(:notification) { build(:notification) }

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:object) }
  end

  context 'ShareRequest' do
    let(:notification) { build(:share_request_notification) }
    let(:responses) { Notification::ShareRequest::RESPONSES }

    describe 'validations' do
      it { is_expected.to be_valid }
      it { is_expected.to validate_inclusion_of(:response).in_array(responses) }
    end
  end

  context 'RatingRequest' do
    let(:notification) { build(:rating_request_notification) }
    let(:responses) { Notification::RatingRequest::RESPONSES }

    describe 'validations' do
      it { is_expected.to be_valid }
      it { is_expected.to validate_inclusion_of(:response).in_array(responses) }
    end
  end
end
