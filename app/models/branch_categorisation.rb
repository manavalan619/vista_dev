# == Schema Information
#
# Table name: branch_categorisations
#
#  id                  :bigint(8)        not null, primary key
#  branch_id           :bigint(8)        not null
#  partner_category_id :bigint(8)        not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_branch_categorisations_on_branch_id            (branch_id)
#  index_branch_categorisations_on_partner_category_id  (partner_category_id)
#
# Foreign Keys
#
#  fk_rails_...  (branch_id => branches.id)
#  fk_rails_...  (partner_category_id => partner_categories.id)
#

class BranchCategorisation < ApplicationRecord
  belongs_to :branch, touch: true
  belongs_to :partner_category

  validates :branch, :partner_category, presence: true
end
