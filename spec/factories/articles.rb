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

FactoryBot.define do
  factory :article do
    title { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraph(3) }
    publish_at { Time.now }
    association :header_image, factory: :photo
  end
end
