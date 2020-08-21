module HasPreferenceGroups
  extend ActiveSupport::Concern

  included do
    has_many :role_preference_group_assignments
    has_many :preference_groups, through: :role_preference_group_assignments

    accepts_nested_attributes_for :role_preference_group_assignments
  end

  def preference_structure_left
    role_preference_group_assignments.left.map do |rp|
      preference_structure_json(rp)
    end
  end

  def preference_structure_left=(array)
    assign_attributes(
      role_preference_group_assignments_attributes(array, 'left')
    )
  end

  def preference_structure_right
    role_preference_group_assignments.right.map do |rp|
      preference_structure_json(rp)
    end
  end

  def preference_structure_right=(array)
    assign_attributes(
      role_preference_group_assignments_attributes(array, 'right')
    )
  end

  private

  def preference_structure_json(rp)
    {
      id: rp.preference_group_id,
      position: rp.position
    }
  end

  def role_preference_group_assignments_attributes(array, column)
    {
      role_preference_group_assignments_attributes: array.map do |i|
        {
          preference_group_id: i['id'].to_i,
          position: i['position'].to_i,
          column: column
        }
      end
    }
  end
end
