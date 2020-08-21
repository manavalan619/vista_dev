module CacheWarmer
  extend ActiveSupport::Concern

  module ClassMethods
    def cache_warm_attributes(*attributes)
      class_eval do
        after_commit :warm_cache, on: %i[create update]
        define_method(:cache_warm_attributes) { attributes }
      end
    end
  end

  private

  def warm_cache
    CacheWarmerJob.perform_later(self)
  end
end
