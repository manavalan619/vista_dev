module Api::V1
  module Categories
    class IgnoreController < Api::V1::BaseController
      before_action :find_category

      def create
        ignore = current_user.ignores.find_or_initialize_by(category: @category)

        if ignore.save
          head 204
        else
          head 422
        end
      end

      def destroy
        ignore = current_user.ignores.find_by(category: @category)

        if ignore.destroy
          head 204
        else
          head 422
        end
      end

      private

      def find_category
        @category = Category.find params[:id]
      end
    end
  end
end
