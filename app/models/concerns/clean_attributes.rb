module CleanAttributes
  extend ActiveSupport::Concern

  module ClassMethods
    def clean_attributes(*args)
      class_eval do
        define_method(:clean_attributes) do
          args.each do |attribute_name|
            value = send(attribute_name)
            if value.respond_to?(:squish)
              send("#{attribute_name}=", value.squish)
            end
          end
        end
        before_validation :clean_attributes
      end
    end
  end
end
