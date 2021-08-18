/**
 *
 */
var Inquiry = function () {
  var urlBase = location.origin + location.pathname;
  var filterTransactionByDateRange = function () {
    $('#reportrange').on('apply.daterangepicker',
      function (ev, picker) {
        var date = picker.startDate.format('DD/MM/YYYY HH:mm:ss') + '-' + picker.endDate.format('DD/MM/YYYY HH:mm:ss');
        $('#reportrange input:hidden[name="range"]').val(date);
        var url = urlBase + '?' + $('#transaction-filter').serialize();
        if (searchText != 'undefined' && searchText != '') {
          url += '&id=' + searchText;
        }
        location = url;
      });
  };
  var searchTransaction = function () {
    $('#btn-search').on('click', function () {
      var url = location.href.replace(/&?id=([^&]$|[^&]*)/i, '');
      if (url.indexOf('?') == -1) {
        url = url + '?';
      }
      location = url + '&id=' + $('#search').val();
    });
    $('#search').on('keypress', function (event) {
      if (event.which === 13) {
        var url = location.href.replace(/&?id=([^&]$|[^&]*)/i, '');
        if (url.indexOf('?') == -1) {
          url = url + '?';
        }
        location = url + '&id=' + $('#search').val();
      }
    });
  };
  var filterByMerchants = function () {
    if (merchants != '' && merchants.length > 0) {
      $('.multiple-select').find('option').each(
        function () {
          if ($.inArray($(this).val(), merchants) > -1) {
            $('.multiple-select').multiselect('select', $(this).val(), true);
          } else {
            $('.multiple-select').multiselect('deselect', $(this).val());
          }
        });
    }
    $('.ms-btn-sbm').on('click', function () {
      var url = urlBase + '?' + $('#transaction-filter').serialize();
      if (searchText != 'undefined' && searchText != '') {
        url += '&id=' + searchText;
      }
      location = url;
    });
  };
  var filterByService = function () {
    $('select[name="service"]').on("change", function () {
      var url = urlBase + '?' + $('#transaction-filter').serialize();
      if (searchText != 'undefined' && searchText != '') {
        url += '&id=' + searchText;
      }
      location = url;
    });
  };
  var filterByType = function () {
    $('select[name="type"]').on("change", function () {
      var url = urlBase + '?' + $('#transaction-filter').serialize();
      if (searchText != 'undefined' && searchText != '') {
        url += '&id=' + searchText;
      }
      location = url;
    });
  };
  var filterByStatus = function () {
    $('select[name="status"]').on("change", function () {
      var url = urlBase + '?' + $('#transaction-filter').serialize();
      if (searchText != 'undefined' && searchText != '') {
        url += '&id=' + searchText;
      }
      location = url;
    });
  };
  return {
    // main function to initiate the module
    init: function () {
      // dropdown navbar
      $("#navbar-main-1").bootstrapDropdownOnHover();
      $("#navbar-main-2").bootstrapDropdownOnHover();
      $("#navbar-main-3").bootstrapDropdownOnHover();
      $(".guide_alert_over").click(function () {
        $("body").addClass("body_over");
      });
      $(".modal-dismiss").click(function () {
        $("body").removeClass("body_over");
      });
      $('.c-column .multiselect-container li').last().after('<li class="btn-rs"><a href="">Reset as default</a></li>');
      //filter by date
      filterTransactionByDateRange();
      //fulltext search
      searchTransaction();
      filterByMerchants();
      filterByType();
      filterByStatus();
      filterByService();
    }
  };
}();
jQuery(document).ready(function () {
  Inquiry.init();
});