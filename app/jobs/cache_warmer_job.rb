class CacheWarmerJob < ApplicationJob
  queue_as :default

  discard_on ActiveJob::DeserializationError

  def perform(object)
    object.cache_warm_attributes.each { |attribute| object.send(attribute) }
  end
end
