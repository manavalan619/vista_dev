import Rails from 'rails-ujs'
import $ from 'jquery'
import Popper from 'popper.js'
// window.Popper = Popper
// import jQuery from 'jquery'
// window.jQuery = jQuery
// import './bootstrap-custom'
// import 'bootstrap/js/dist/dropdown.js'
import 'bootstrap'
import './cocoon'
// import './dashboard'
// import './rowlink'
import 'select2'
import Turbolinks from 'turbolinks'

Rails.start()
Turbolinks.start()

$(document).on('turbolinks:load', function() {
  $('.dropdown-toggle').dropdown();
});

$(function() {
  $('select').each(function() {
    if ($(this).data('url')) {
      var url = $(this).data('url');

      $(this).select2({
        ajax: {
          url: url,
          dataType: 'json',
          data: function (params) {
            var query = {
              q: params.term
            }

            // Query parameters will be ?q=[term]
            return query;
          },
          cache: false
        }
      });
    } else {
      $(this).select2();
    }
  });

  // $('tbody.rowlink').rowlink();

  // lbd.checkFullPageBackgroundImage();

  setTimeout(function(){
    // after 1000 ms we add the class animated to the login/register card
    $('.card').removeClass('card-hidden');
  }, 700);
});
