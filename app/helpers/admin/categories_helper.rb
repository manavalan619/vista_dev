module Admin::CategoriesHelper
  def category_parent_selection
    cats = Category.all.map { |c| [[c.ancestors, c].flatten.join('/'), c.id] }
    cats.sort_by { |c| c[0] }
  end

  def render_partner_categories(categories)
    render_sortable(categories, reorder_admin_partner_categories_path)
  end

  def render_categories(categories)
    render_sortable(categories, reorder_admin_categories_path)
  end

  def render_sortable(collection, url)
    return if collection.nil? || collection.empty?
    content_tag(
      :ol,
      render(collection),
      class: 'sortable category-list',
      data: { url: url }
    )
  end
end
