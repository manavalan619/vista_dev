module EnforceNil
  extend ActiveSupport::Concern

  module ClassMethods
    def enforce_nil(*args)
      class_eval do
        define_method(:enforce_nil) do
          args.each do |argument|
            field = send(argument)
            send("#{argument}=", nil) if field.blank?
          end
        end
        before_save :enforce_nil
      end
    end
  end
end
