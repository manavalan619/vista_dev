module Admin::LayoutHelper
  def navbar_breadcrumbs
    breadcrumbs(
      autoroot: false,
      display_single_fragment: false,
      style: :ul,
      separator: nil,
      link_current: true,
      current_class: 'is-active'
    )
  end
end
