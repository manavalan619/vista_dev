//= require alertify
//= require unobtrusive_flash

flashHandler = function(e, params) {
  setTimeout(function () {
    noticeType = params.type == 'notice' ? 'success' : params.type;
    notify[noticeType](params.message);
  }, 0);
};

$(window).bind('rails:flash', flashHandler);

$(function() {
  alertify.parent(document.body);
  alertify.logPosition("bottom right");

  notify = {
    alert: function(msg) {
      alertify.setLogTemplate(function(msg) {
        return '<div class="icon"><i class="fa fa-bell"></i></div>' + msg;
      }).log(msg);
    },

    success: function(msg) {
      alertify.setLogTemplate(function(msg) {
        return '<div class="icon"><i class="fa fa-check"></i></div>' + msg;
      }).success(msg);
    },

    notice: function(msg) {
      alertify.setLogTemplate(function(msg) {
        return '<div class="icon"><i class="fa fa-info"></i></div>' + msg;
      }).log(msg);
    },

    warning: function(msg) {
      alertify.setLogTemplate(function(msg) {
        return '<div class="icon"><i class="fa fa-warning"></i></div>' + msg;
      }).warning(msg);
    },

    error: function(msg) {
      alertify.setLogTemplate(function(msg) {
        return '<div class="icon"><i class="fa fa-remove"></i></div>' + msg;
      }).error(msg);
    }
  }
});
