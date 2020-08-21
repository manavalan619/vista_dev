module PaperTrailUser
  extend ActiveSupport::Concern

  module ClassMethods
    def paper_trail_actor(user_type)
      class_eval do
        define_method :actor do
          @whodunnit ||= begin
            return nil unless whodunnit.present?
            klass = user_type.to_s.classify.constantize
            klass.find(whodunnit.to_i)
          end
        end
      end
    end
  end
end
