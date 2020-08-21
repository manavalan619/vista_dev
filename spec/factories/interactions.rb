# == Schema Information
#
# Table name: interactions
#
#  id              :bigint(8)        not null, primary key
#  user_id         :bigint(8)        not null
#  staff_member_id :bigint(8)
#  branch_id       :bigint(8)
#  category_id     :bigint(8)
#  description     :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  type            :string           default(""), not null
#
# Indexes
#
#  index_interactions_on_branch_id        (branch_id)
#  index_interactions_on_category_id      (category_id)
#  index_interactions_on_staff_member_id  (staff_member_id)
#  index_interactions_on_type             (type)
#  index_interactions_on_user_id          (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (branch_id => branches.id)
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (staff_member_id => staff_members.id)
#  fk_rails_...  (user_id => users.id)
#

FactoryBot.define do
  factory :interaction do
    user
    description { Faker::Lorem.sentence }

    after(:build) do |interaction|
      if Interaction::PARTNER_TYPES.include?(interaction.type)
        interaction.branch = interaction.staff_member.assigned_branches.first
      end
    end

    trait :recommendation do
      type { Interaction::PARTNER_TYPES.sample }
      staff_member
    end

    trait :mood do
      type { 'mood' }
      staff_member { nil }
      description { Interaction::MOODS.sample }
    end
  end
end
