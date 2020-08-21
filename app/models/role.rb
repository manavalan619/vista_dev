# == Schema Information
#
# Table name: roles
#
#  id                 :bigint(8)        not null, primary key
#  name               :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  archived_at        :datetime
#  business_unit_id   :bigint(8)
#  top_questions_data :jsonb
#  interactions       :string           is an Array
#
# Indexes
#
#  index_roles_on_business_unit_id  (business_unit_id)
#
# Foreign Keys
#
#  fk_rails_...  (business_unit_id => business_units.id)
#

class Role < ApplicationRecord
  include HasPreferenceGroups

  acts_as_paranoid column: :archived_at

  belongs_to :business_unit
  has_one :organisation, through: :business_unit
  has_many :role_assignments
  has_many :staff_members, through: :role_assignments
  has_many :member_request_type_assignments
  has_many :member_request_types, through: :member_request_type_assignments

  validates :name, :business_unit, presence: true

  def top_questions_data=(array)
    type_cast_data = array.map do |i|
      { id: i['id'].to_i, position: i['position'].to_i }
    end
    write_attribute(:top_questions_data, type_cast_data)
  end

  def top_question(position)
    return nil if top_questions_data.empty?
    top_questions_data.find { |q| q['position'] == position }['id']
  end

  def top_question_ids
    top_questions_data.map { |q| q['id'] }
  end

  def top_questions
    Question.where(id: top_question_ids)
  end
end
