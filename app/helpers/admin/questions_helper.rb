module Admin::QuestionsHelper
  def category_selection
    categories = Category.all.each_with_object([]) do |c, array|
      array.push([[c.ancestors, c].flatten.join('/'), c.id]) unless c.root?
      array
    end
    categories.sort_by { |c| c[0] }
  end
end
