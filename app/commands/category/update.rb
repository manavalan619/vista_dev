class Category::Update
  prepend SimpleCommand

  def initialize(category, params)
    @category = category
    @params = params
  end

  def call
    errors.add(:category_update, 'could not update a category') unless @category.update(@params)
  end
end
