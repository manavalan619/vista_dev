class Category::Create
  prepend SimpleCommand

  def initialize(category)
    @category = category
  end

  def call
    errors.add(:category_create, 'could not create a category') unless @category.save
  end
end
