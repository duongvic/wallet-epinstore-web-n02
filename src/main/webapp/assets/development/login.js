/**
 *
 */
'use strict';
var Login = function () {
  return {
    init: function () {
      //$("#navbar-main-1").bootstrapDropdownOnHover();
      //$("#navbar-main-2").bootstrapDropdownOnHover();
      //$("#navbar-main-3").bootstrapDropdownOnHover();
      $(".guide_alert_over").click(function () {
        $("body").addClass("body_over");
      });
      $(".modal-dismiss").click(function () {
        $("body").removeClass("body_over");
      });
      //submit form
      $('.sign-in').on('keypress', function (event) {
        if (event.which === 13) {
          document.forms['loginForm'].submit();
        }
      });
    }
  };
}();
jQuery(document).ready(function () {
  Login.init();
});