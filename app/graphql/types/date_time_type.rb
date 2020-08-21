class Types::DateTimeType < Types::BaseScalar
  graphql_name 'DateTime'

  class << self
    def coerce_input(input_value, _ctx)
      Time.zone.parse(input_value)
    end

    def coerce_result(ruby_value, _ctx)
      ruby_value.to_time.utc.iso8601
    end
  end
end
