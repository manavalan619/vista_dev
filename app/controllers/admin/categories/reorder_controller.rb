class Admin::Categories::ReorderController < Admin::BaseController
  def update
    params[:order].each do |_key, value|
      Category.find(value[:id]).update_attribute(:position, value[:position])
    end
    head :ok
  end
end
