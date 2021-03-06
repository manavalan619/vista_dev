# == Schema Information
#
# Table name: videos
#
#  id                  :bigint(8)        not null, primary key
#  name                :string
#  description         :text
#  url                 :string
#  published_at        :datetime
#  organisation_id     :bigint(8)
#  vista_admin_id      :bigint(8)
#  notification_job_id :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  published           :boolean          default(FALSE)
#  archived_at         :datetime
#  platform_id         :string
#
# Indexes
#
#  index_videos_on_organisation_id  (organisation_id)
#  index_videos_on_published        (published)
#  index_videos_on_vista_admin_id   (vista_admin_id)
#

FactoryBot.define do
  factory :video do
    name { Faker::Lorem.words(3) }
    description { Faker::Lorem.paragraphs(1) }
    url { "#{Faker::Internet.url}/file.mp4" }
    published { true }
    vista_admin
    organisation
    content_categories { create_list(:content_category, 3) }
  end
end
