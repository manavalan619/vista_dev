$(document).on('cocoon:after-insert', (e, insertedItem) => {
  const parent = $(insertedItem).parent()

  // NB: don't use es6 fat arrow to keep `this`
  parent.find('.position-field').each(function(idx) {
    $(this).val(idx + 1)
  })
})
