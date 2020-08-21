class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  include CacheWarmer
  include EnforceNil
  include CleanAttributes

  scope :updated_since, lambda { |datetime|
    where("#{table_name}.updated_at > ?", datetime)
  }

  def self.pluck_to_hash(*keys)
    pluck(*keys).map { |key| Hash[keys.zip(key)] }
  end
end
