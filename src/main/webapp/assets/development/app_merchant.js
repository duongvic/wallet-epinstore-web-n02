/**
 *
 */
'use strict';
var App = function () {
  return {
    // main function to initiate the module
    init: function () {
      $('.multiple-select').multiselect({
        maxHeight: 400,
        includeSelectAllOption: true,
        enableCaseInsensitiveFiltering: true,
        selectAllText: 'All Customers'
      });
    }
  };
}();
jQuery(document).ready(function () {
  App.init();
});