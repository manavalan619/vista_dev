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

RSpec.describe ArticleSerializer do
  subject { JSON.parse(ArticleSerializer.new(article).to_json) }
  let(:article) { FactoryBot.create(:article) }
  let(:header_image) { PhotoSerializer.new(article.header_image) }

  it { expect(subject['id']).to eq(article.id) }
  it { expect(subject['title']).to eq(article.title) }
  it { expect(subject['content']).to eq(article.content) }
  it { expect(subject['published_at']).to eq(article.publish_at.iso8601(3)) }
  it { expect(subject['type']).to eq('article') }
  it { expect(subject['header_image']).to eq(JSON.parse(header_image.to_json)) }
end
