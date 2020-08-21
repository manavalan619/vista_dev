class Category::Destroy
  prepend SimpleCommand

  def initialize(category)
    @category = category
  end

  def call
    errors.add(:removing_account, 'cannot remove account of member') unless @category.destroy
  end
end
