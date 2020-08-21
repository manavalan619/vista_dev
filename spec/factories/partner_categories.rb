# == Schema Information
#
# Table name: partner_categories
#
#  id         :bigint(8)        not null, primary key
#  title      :string
#  position   :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_partner_categories_on_position  (position)
#

FactoryBot.define do
  factory :partner_category do
    title       { 'MyString' }
    ancestry    { 'MyString' }
    description { 'MyText' }
    position    { 1 }
  end
end
