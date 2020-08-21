class AddImageAndBranchInfoToBranch < ActiveRecord::Migration[5.1]
  def change
    add_column :branches, :image, :string
    add_column :branches, :branch_info, :string
  end
end
