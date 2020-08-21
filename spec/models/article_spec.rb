# == Schema Information
#
# Table name: articles
#
#  id                  :bigint(8)        not null, primary key
#  title               :string
#  content             :text
#  publish_at          :datetime
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  notification_job_id :integer
#
# Indexes
#
#  index_articles_on_publish_at  (publish_at)
#

require 'rails_helper'
require Rails.root.join "spec/concerns/has_content_categories_spec.rb"

RSpec.describe Article, type: :model do
  subject { build(:article) }

  it_behaves_like 'has_content_categories'

  describe 'associations' do
    it { is_expected.to have_one(:header_image) }
  end

  describe 'validations' do
    it { is_expected.to be_valid }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:content) }
  end
end
