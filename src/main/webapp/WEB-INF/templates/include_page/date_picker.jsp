<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script type="text/javascript">
  var range = '<c:out value="${param.range}"/>';
  var isFullTime = '<c:out value="${param.isFullTime}"/>';
  var isFilter = '<c:out value="${param.isFilter}"/>';

  var textRange = '<spring:message code="daterange.locale.fulltime" />';
  var textRangeNoSign = '<spring:message code="daterange.locale.fulltime.nosign" />';
  $(document).ready(function () {
    var cb = function (start, end) {
      if (start.isSame(end)) {
        $('#reportrange span').html(textRange);
      } else {
        $('#reportrange span').html(start.format('DD/MMMM/YYYY HH:mm:ss') + ' - ' + end.format('DD/MMMM/YYYY HH:mm:ss'));
      }
    };


    var urlBase = location.origin + location.pathname;
    $('#reportrange').on('apply.daterangepicker', function (ev, picker) {
      var startDate = picker.startDate.format('DD/MM/YYYY HH:mm:ss');
      var endDate = picker.endDate.format('DD/MM/YYYY HH:mm:ss');
      var date = '';
      if (picker.startDate.isSame(picker.endDate)) {
        date = textRangeNoSign;
      } else {
        date = startDate + ' - ' + endDate;
      }

      $('#reportrange input:hidden[name="range"]').val(date);

      var url = urlBase + '?' + $('#tbl-filter').serialize();
      /*if (searchText != 'undefined' && searchText != '') {
        url += '&id=' + searchText;
      }*/
      if (isFilter === 'true') {
        location = url;
      }
    });


    var ranges = [];
    if (isFullTime === 'true') {
      if (range === '') {
        range = textRangeNoSign;
      }
      ranges = {
        '<spring:message code="daterange.locale.fulltime" />': [moment().startOf('day'), moment().startOf('day')],
        '<spring:message code="daterange.locale.todayLabel" />': [moment().startOf('day'), moment().endOf('day')],
        '<spring:message code="daterange.locale.yesterdayLabel" />': [moment().startOf('day').subtract(1, 'days'), moment().endOf('day').subtract(1, 'days')],
        '<spring:message code="daterange.locale.7daysBeforeLabel" />': [moment().startOf('day').subtract(6, 'days'), moment().endOf('day')],
        '<spring:message code="daterange.locale.30daysBeforeLabel" />': [moment().startOf('day').subtract(29, 'days'), moment().endOf('day')],
        '<spring:message code="daterange.locale.thisMonthLabel" />': [moment().startOf('day').startOf('month'), moment().endOf('day').endOf('month')],
        '<spring:message code="daterange.locale.prevMonthLabel" />': [moment().startOf('day').subtract(1, 'month').startOf('month'), moment().endOf('day').subtract(1, 'month').endOf('month')]
      }
    } else {
      //range = '';
      ranges = {
        '<spring:message code="daterange.locale.fulltime" />': [moment().startOf('day'), moment().startOf('day')],
        '<spring:message code="daterange.locale.todayLabel" />': [moment().startOf('day'), moment().endOf('day')],
        '<spring:message code="daterange.locale.yesterdayLabel" />': [moment().startOf('day').subtract(1, 'days'), moment().endOf('day').subtract(1, 'days')],
        '<spring:message code="daterange.locale.7daysBeforeLabel" />': [moment().startOf('day').subtract(6, 'days'), moment().endOf('day')],
        '<spring:message code="daterange.locale.30daysBeforeLabel" />': [moment().startOf('day').subtract(29, 'days'), moment().endOf('day')],
        '<spring:message code="daterange.locale.thisMonthLabel" />': [moment().startOf('day').startOf('month'), moment().endOf('day').endOf('month')],
        '<spring:message code="daterange.locale.prevMonthLabel" />': [moment().startOf('day').subtract(1, 'month').startOf('month'), moment().endOf('day').subtract(1, 'month').endOf('month')]
      }
    }

    var initDateRange = function (currentRange) {
      if (currentRange == textRangeNoSign) {
        $('#reportrange span').html(textRange);
        //$('#reportrange input:hidden[name="range"]').val(moment().startOf('day') + ' - ' + moment().startOf('day'));
        $('#reportrange input:hidden[name="range"]').val(textRangeNoSign);
      } else if (currentRange != '') {
        $('#reportrange span').html(currentRange);
        $('#reportrange input:hidden[name="range"]').val(currentRange);
      } else {
        $('#reportrange input:hidden[name="range"]').val(moment().startOf('day').subtract(0, 'days').format('DD/MMMM/YYYY HH:mm:ss') + ' - ' + moment().endOf('day').format('DD/MMMM/YYYY HH:mm:ss'));
        cb(moment().startOf('day').subtract(0, 'days'), moment().endOf('day'));
      }
      if ($("#reservation").length) {
        $('#reportrange').daterangepicker({
          timePicker: true,
          timePicker24Hour: true,
          timePickerSeconds: true,
          timePickerIncrement: 1,
          locale: {
            format: 'DD/MM/YYYY HH:mm:ss',
            applyLabel: '<spring:message code="daterange.locale.applyLabel" />',
            cancelLabel: '<spring:message code="daterange.locale.cancelLabel" />',
            customRangeLabel: '<spring:message code="daterange.locale.customRangeLabel" />',
          },
          startDate: $("#reservation").val().length > 0 ? $("#reservation").val().substring(0, $("#reservation").val().indexOf('-')) : '',
          endDate: $("#reservation").val().length > 0 ? $("#reservation").val().substring($("#reservation").val().indexOf('-') + 1) : '',
          ranges: ranges
        }, cb);
      }
    };
    initDateRange(range);
  });
</script>