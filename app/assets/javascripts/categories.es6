$(function() {
  $(document).on('click', '.toggleable .list-toggle', function() {
    $(this).closest('li').find('> ol').toggle()
    $(this).toggleClass('fa-chevron-down')
    $(this).toggleClass('fa-chevron-right')
  })
})
