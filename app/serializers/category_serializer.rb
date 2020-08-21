# == Schema Information
#
# Table name: categories
#
#  id                      :bigint(8)        not null, primary key
#  title                   :citext
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  ancestry                :string
#  description             :text
#  position                :integer          default(0), not null
#  initial                 :boolean          default(FALSE)
#  visibility_conditions   :jsonb            not null
#  text_style              :string           default("dark")
#  subtree_questions_count :integer          default(0)
#  questions_count         :integer          default(0)
#
# Indexes
#
#  index_categories_on_ancestry               (ancestry)
#  index_categories_on_ancestry_and_position  (ancestry,position)
#

class CategorySerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :parent_id, :ancestry,
             :subtree_questions_count, :ignored, :position, :initial,
             :text_style
  attribute :children?, key: :has_children
  attribute :visibility_conditions_tree, key: :visibility_conditions

  has_one :photo

  def ignored
    Rails.cache.fetch [object, scope.current_user, :ignored] do
      object.ignores.exists?(user: scope.current_user)
    end
  end
end
