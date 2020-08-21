Types::CheckInType = GraphQL::ObjectType.define do
  name 'CheckIn'
  field :userId, types.ID, property: :user_id
  field :branchId, types.ID, property: :branch_id
  field :arrivalDate, Types::DateType, property: :arrival_date
  field :arrivalTimeStart, Types::TimeType, property: :arrival_time_start
  field :arrivalTimeEnd, Types::TimeType, property: :arrival_time_end
end
