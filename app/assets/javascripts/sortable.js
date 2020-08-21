$(function() {
  function toggleList(element) {
    $(element).closest('li').find('> .step-container > [data-action="collapse"]').toggle();
    $(element).closest('li').find('> .step-container > [data-action="expand"]').toggle();
    $(element).closest('li').children('ol').toggle();
  }

  $('[data-action="collapse"], [data-action="expand"]').on('click', function(e) {
    toggleList(this);
  });

  function toggleVisibleDirectionButtons() {
    $('.sortable').find('> li .position-btn').show();
    $('.sortable').find('> li:first-child .position-btn[data-direction="up"]').hide();
    $('.sortable').find('> li:last-child .position-btn[data-direction="down"]').hide();
  }

  function updateSortOrder(list) {
    var updatedOrder = [];

    list.find('> li').each(function(i) {
      updatedOrder.push({
        id: $(this).data('id'),
        position: i + 1
      });
    });

    $.ajax({
      url: $(list).data('url'),
      method: 'PUT',
      data: {
        order: updatedOrder
      },
      success: function() {
        notify.success('Order updated successfully.');
      },
      error: function(response, textStatus, error) {
        notify.error(textStatus);
      }
    });

    toggleVisibleDirectionButtons();
  }

  $.each($('.sortable'), function(idx, list) {
    $(list).sortable({
      ghostClass: 'element-placeholder',
      scrollSensitivity: 150,
      handle: '.drag-handle',
      onSort: function(e) {
        updateSortOrder($(list));
      }
    });
    toggleVisibleDirectionButtons();
  });

  $('[data-toggle=direction]').on('click', function(e) {
    e.preventDefault();
    var direction = $(this).data('direction');
    var id = $(this).closest('li').data('id');
    var list = $(this).closest('ol');
    var sortable = $(list).sortable('widget');
    var order = $(list).sortable('widget').toArray();
    var oldIndex = order.indexOf(id);
    var newIndex = direction === 'up' ? oldIndex - 1 : oldIndex + 1;
    var newOrder = order.move(oldIndex, newIndex);
    sortable.sort(newOrder);
    updateSortOrder(list);
    var listItem = $(this).closest('li');
    listItem.find('.step-inner').stop().addClass('flash');
    setTimeout(function () {
      listItem.find('.step-inner').stop().removeClass('flash');
    }, 1500);
  });
});
