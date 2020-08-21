module Api
  module V1
    class BranchesController < Api::V1::BaseController
      has_scope :in_category, as: :category_id
      has_scope :in_city, as: :city_id
      has_scope :ordered_by_distance, as: :coords
      has_scope :vista_partners, type: :boolean
      has_scope :search

      def index
        @branches = apply_scopes(branch_scope).includes(:address, :shares, :categories, :photo, :business_unit).page(params[:page])
        render json: @branches
      end

      def show
        @branch = Branch.find params[:id]
        render json: @branch, full_detail: true
      end

      private

      def branch_scope
        if ActiveModel::Type::Boolean.new.cast(params[:authorised])
          return current_user.authorised_branches
        end
        Branch
      end
    end
  end
end
