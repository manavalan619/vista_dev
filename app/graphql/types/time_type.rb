Types::TimeType = GraphQL::ScalarType.define do
  name 'Time'

  coerce_input ->(value, _ctx) { Time.zone.parse(value) }
  coerce_result ->(value, _ctx) { value.utc.strftime('%H:%M') }
end
