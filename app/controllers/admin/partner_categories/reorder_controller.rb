class Admin::PartnerCategories::ReorderController < Admin::BaseController
  def update
    params[:order].each do |_key, value|
      PartnerCategory.find(value[:id]).update_attribute(:position, value[:position])
    end
    head :ok
  end
end
