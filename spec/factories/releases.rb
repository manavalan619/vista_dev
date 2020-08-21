# == Schema Information
#
# Table name: releases
#
#  id         :bigint(8)        not null, primary key
#  file       :string
#  status     :string           default("queued")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :release do
    file { 'MyString' }
  end
end
