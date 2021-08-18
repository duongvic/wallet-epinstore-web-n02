/**
 * Created by binhminh on 29/08/2017.
 */
$(document).ready(function () {
  //------------------------ SERVICE LIST ----------------------
  $("#table").treeFy({
    initState: 'collapsed',
    expanderExpandedClass: 'fa fa-chevron-down',
    expanderCollapsedClass: 'fa fa-chevron-right',
    treeColumn: 0
  });

  $('<span style="color: #428bca;" class="icon node-icon glyphicon glyphicon-bookmark"></span>').insertAfter(".treetable-expander");
  $('.switch input[name=switch]').each(function () {
    var item = document.querySelector('#' + $(this).attr('id'));
    var color = '#64bd63';
    var switchery = new Switchery(item, {color: color, size: 'small'});
    if ($(this).disabled) {
      switchery.disable();
    }
  });
  //------------------------ SERVICE ADD ----------------------
  $('.link-add').click(function () {
    resetAllvalue();
    createParentServiceCodeAdd($("#serviceType").val(), $("#serviceLevel").val());
  });
  $('form[name=add]').submit(function () {
    $(".btnSubmit").button('loading');
    $.post($(this).attr('action'), $(this).serialize(), function (json) {
      $.MessageBox({message: json.message});
      if (json.code == 0) {
        $('#add').modal('toggle');
        location.reload();
      }
      setTimeout(function () {
        $(".btnSubmit").button('reset');
      }, 1000);
    });
    return false;
  });
  function resetAllvalue() {
    $("form[name=add] input[name=serviceCodeSuffix]").val("");
    $("form[name=add] input[name=serviceCode]").val("");
    $("form[name=add] input[name=serviceName]").val("");
    $("form[name=add] select[name=serviceType]").val("TOPUP");
    $("form[name=add] select[name=parentServiceCode]").val("");
    $("form[name=add] textarea[name=serviceDesc]").val("");
    $("form[name=add] select[name=serviceLevel]").val("0");
    $('#scServiceType').val($('#serviceType').val());
    if ($('#serviceType').val() === 'TOPUP') {
      $("#scTelcoType").css("display", "none");
      $("#scTelcoType").blur();
      if ($("#scTelcoType").is(":visible")) {
        $("#scTelcoType").hide();
        $("#scTelcoType").prop('required', null);
        $("#scTelcoType").val();
      }
      $("#scTelcoServiceType").show();
      $("#scTelcoServiceType").attr('required', 'required');
    } else {
      $("#scTelcoType").show();
      $("#scTelcoType").attr('required', 'required');
      $("#scTelcoServiceType").blur();
      if ($("#scTelcoServiceType").is(":visible")) {
        $("#scTelcoServiceType").hide();
        $("#scTelcoServiceType").prop('required', null);
        $("#scTelcoServiceType").val();
      }
    }
  }

  //change input default
  $("#serviceType").change(function () {
    $('#scServiceType').val($('#serviceType').val());
    createParentServiceCodeAdd($('#serviceType').val(), $('#serviceLevel').val());
    if ($('#serviceType').val() === 'TOPUP') {
      $("#scTelcoType").blur();
      if ($("#scTelcoType").is(":visible")) {
        $("#scTelcoType").hide();
        $("#scTelcoType").prop('required', null);
        $("#scTelcoType").val();
      }
      $("#scTelcoServiceType").show();
      $("#scTelcoServiceType").attr('required', 'required');
    } else {
      $("#scTelcoType").show();
      $("#scTelcoType").attr('required', 'required');
      $("#scTelcoServiceType").blur();
      if ($("#scTelcoServiceType").is(":visible")) {
        $("#scTelcoServiceType").hide();
        $("#scTelcoServiceType").prop('required', null);
        $("#scTelcoServiceType").val();
      }
    }
  });
  $("#serviceLevel").change(function () {
    createParentServiceCodeAdd($('#serviceType').val(), $('#serviceLevel').val());
  });
  //------------------------ SERVICE DELETE ----------------------
  $(".link-delete").click(function () {
    $("form[name=delete] input[name=serviceCode]").val($(this).attr("serviceCode"));
    $("form[name=delete] input[name=serviceId]").val($(this).attr("serviceId"));
    $(".textService").html($(this).attr("serviceName") + ' [ ' + $(this).attr("serviceCode") + ' ]');
    $.ajax({
      type: 'GET',
      url: ctx + '/service/service-profile/listChildrenDelete',
      data: {
        serviceId: $(this).attr("serviceId")
      },
      success: function (data) {
        if (data.length > 1) {
          $("#messageDelete").html('<spring:message code="system.service.popup.delete.lable.message.deleteAll"/>');
        } else {
          $("#messageDelete").html('<spring:message code="system.service.popup.delete.lable.message.delete"/>');
        }
      }
    });
  });
  $('form[name=delete]').submit(function () {
    var answer = $('form[name=delete] input[name=ckaccess]').is(":checked");
    if (answer) {
      $(".btnSubmit").button('loading');
      $.post($(this).attr('action'), $(this).serialize(), function (json) {
        $.MessageBox({message: json.message});
        if (json.code == 0) {
          $('#delete').modal('toggle');
          location.reload();
        }
        setTimeout(function () {
          $(".btnSubmit").button('reset');
        }, 1000);
      });
    } else {
      $.MessageBox({message: 'Xác nhận xóa dịch vụ !'});
    }
    return false;
  });
  $('#labelCheckboxDelete').click(function () {
    if ($('#checkboxDelete').is(':checked')) {
      $('#checkboxDelete').prop('checked', false);
    } else {
      $('#checkboxDelete').prop('checked', true);
    }
  });
  //------------------------ SERVICE EDIT ----------------------
  $(".link-edit").click(function () {
    var serviceCode = $(this).attr("serviceCode");
    var level = $(this).attr("serviceLevel");
    var serviceType = $(this).attr("serviceType");
    var serviceParentId = $(this).attr("serviceParentId");
    $("form[name=edit] input[name=serviceId]").val($(this).attr("serviceId"));
    $("form[name=edit] input[name=serviceTypeEdit]").val(serviceType);
    $("form[name=edit] input[name=serviceCodeEdit]").val(serviceCode);
    $("form[name=edit] input[name=serviceName]").val($(this).attr("serviceName"));
    $("form[name=edit] textarea[name=serviceDesc]").val($(this).attr("serviceDesc"));
    $("form[name=edit] input[name=serviceprice]").val($(this).attr("servicePrices"));
    var isActorPayee = $(this).attr("isActorPayee");
    if (isActorPayee === 'Y') {
      $("form[name=edit] input[id=isActorPayeeEdit]").prop('checked', true);
    } else {
      $("form[name=edit] input[id=isActorPayerEdit]").prop('checked', true);
    }
    $('#nameService').text($(this).attr("serviceName") + ' [ ' + serviceCode + ' ] ');
    if (level == "0") {
      $("#serviceLevelEdit").css("display", "none");
      $("#serviceLevelParentEdit").css("display", "block");
      $('#serviceLevelParentEdit').prop('disabled', true);
      $("form[name=edit] select[name=serviceLevelParentEdit]").val(level);
      $('#parentServiceCodeEdit').prop('disabled', true);
    } else {
      $("#serviceLevelEdit").css("display", "block");
      $("#serviceLevelParentEdit").css("display", "none");
      $('#serviceLevelParentEdit').prop('disabled', false);
      $("form[name=edit] select[name=serviceLevelEdit]").val(level);
      $('#parentServiceCodeEdit').prop('disabled', false);
    }
    createParentServiceCode(serviceParentId, serviceType, level, serviceCode);
  });
  $("#serviceLevelEdit").change(function () {
    createParentServiceCode($('#parentServiceCodeEdit').val(), $('#serviceTypeEdit').val(), $('#serviceLevelEdit').val(), $('#serviceCodeEdit').val());
  });
  $("#serviceLevelParentEdit").change(function () {
    createParentServiceCode($('#parentServiceCodeEdit').val(), $('#serviceTypeEdit').val(), $('#serviceLevelParentEdit').val(), $('#serviceCodeEdit').val());
  });
  $('form[name=edit]').submit(function () {
    $(".btnSubmit").button('loading');
    $.post($(this).attr('action'), $(this).serialize(), function (json) {
      $.MessageBox({message: json.message});
      if (json.code == 0) {
        $('#edit').modal('toggle');
        location.reload();
      }
      setTimeout(function () {
        $(".btnSubmit").button('reset');
      }, 1000);
    });
    return false;
  });
  //------------------------ SERVICE INACTIVE ----------------------
  $('.link-status').click(function () {
    var serviceId = $(this).attr('serviceId');
    var serviceCode = $(this).attr('serviceCode');
    var serviceName = $(this).attr('serviceName');
    var active = $(this).attr('active');
    var isTrueSet = (active === 'Y');
    var textAlert = "Bật dịch vụ: ";
    if (isTrueSet) {
      textAlert = "Tắt dịch vụ";
    }
    textAlert = textAlert + serviceName + '[' + serviceCode + ']';
    $('#titlePopupInactive').text(textAlert);
    if (isTrueSet) {
      $('#messageInactive').text('<spring:message code="system.service.popup.inactive.message.inactive"/>');
    } else {
      $('#messageInactive').text('<spring:message code="system.service.popup.inactive.message.active"/>');
    }
    $('form[name=changeStatus]').submit(function () {
      var answer = $('form[name=changeStatus] input[name=ckaccess]').is(":checked");
      if (answer) {
        $(".btnSubmit").button('loading');
        $.post('changeStatus', {serviceId: serviceId, active: active}, function (json) {
          $.MessageBox({message: json.message});
          if (json.code == 0) {
            $('#delete').modal('toggle');
            location.reload();
          }
          setTimeout(function () {
            $(".btnSubmit").button('reset');
          }, 1000);
        });
      } else {
        $.MessageBox({message: '<spring:message code="common.confirm.action"/>'});
      }
      return false;
    });
  });
  $('#labelCheckbox').click(function () {
    if ($('#checkboxInactive').is(':checked')) {
      $('#checkboxInactive').prop('checked', false);
    } else {
      $('#checkboxInactive').prop('checked', true);
    }
  });
  //------------------------ SERVICE RULE_ADD ----------------------
  $('form[name=trueServiceMatrix]').submit(function () {
    $(".btnSubmit").button('loading');
    $.post($(this).attr('action'), $(this).serialize(), function (json) {
      $.MessageBox({message: json.message});
      if (json.code == 0) {
        $('#trueServiceMatrix').modal('toggle');
        location.reload();
      }
      setTimeout(function () {
        $(".btnSubmit").button('reset');
      }, 1000);
    });
    return false;
  });
  $('.service-rule-add').click(function () {
    var serviceId = $(this).attr("serviceId");
    var serviceCode = $(this).attr("serviceCode");
    var serviceName = $(this).attr("serviceName");
    $("#matrixServiceId").val(serviceId);
    $("#lbServiceName").html(serviceName + ' [ ' + serviceCode + ' ] ');
    $('button.confirmRequest').prop('disabled', false);
    $('button.confirmRequest').button('loading');
    $('button.confirmRequest').show();
    var url = ctx + '<%=TrueServiceController.TRUE_SERVICE_CONTROLLER%>' + '/findTransactionRuleMatrix';
    $.get(url, {serviceId: serviceId}, function (json) {
      if (json != null && json instanceof Array && json.length > 0) {
        var tbody = $('form[name=trueServiceMatrix] table.datatable-default tbody');
        tbody.html('');
        var matrix = json;
        var i = 1;
        $.each(json, function (key, transactionRuleMatrix) {
          var tr = '<tr>' +
              '<td class="center">' +
              '<input type="radio" id="tranRuleMatrixId' + i + '" name="tranRuleMatrixId" value="' + transactionRuleMatrix.id + '" ' + transactionRuleMatrix.existMatrix + '>' +
              '</td>' +
              '<td>' + transactionRuleMatrix.code + '</td>' +
              '<td>' + transactionRuleMatrix.name + '</td>' +
              '<td>' + transactionRuleMatrix.serviceType + '</td>' +
              '</tr>';
          tbody.append(tr);
          i++;
        });
        $('button.confirmRequest').button('reset');
      } else {
        $('button.confirmRequest').prop('disabled', true);
        $('button.confirmRequest').hide();
      }
    });
  });
});

function createParentServiceCodeAdd(serviceType, serviceLevel) {
  $('#parentServiceCode').html('refresh', true);
  $.ajax({
    type: 'POST',
    url: ctx + '/service/service-profile/listFeeAdd',
    data: {
      serviceType: serviceType, serviceLevel: serviceLevel
    },
    success: function (data) {
      $("#parentServiceCode").append("<option  value=''>"
          + "<spring:message code='system.service.popup.create.lable.selectParentServiceCode'/>"
          + "</option>");
      var data = JSON.parse(data);

      function formatResult(node) {
        var $result = $('<span style="padding-left:' + (20 * node.level) + 'px;">'
            + '<span style="color: #428bca;" class="icon node-icon glyphicon glyphicon-bookmark"></span>'
            + '&nbsp;' + node.text + ' - ' + node.id + '</span>');
        return $result;
      }
      $("#parentServiceCode").select2({
        dropdownParent: $("#add"),
        placeholder: '<spring:message code="system.service.popup.create.lable.selectParentServiceCode"/>',
        width: "100%",
        data: data,
        formatSelection: function (item) {
          return item.text
        },
        formatResult: function (item) {
          return item.text
        },
        templateResult: formatResult
      });
    }
  });
}
function createParentServiceCode(parentServiceId, serviceType, serviceLevel, serviceCode) {
  $('#parentServiceCodeEdit').html('refresh', true);
  $.ajax({
    type: 'POST',
    url: ctx + '/service/service-profile/listFeeEdit',
    data: {
      parentServiceId: parentServiceId, serviceType: serviceType, serviceLevel: serviceLevel, serviceCode: serviceCode
    },
    success: function (data) {
      var listData = data.split(';');
      if (listData != null && listData != "" && listData instanceof Array) {
        var trueServices = JSON.parse(listData[0]);

        function formatResult(node) {
          var $result = $('<span style="padding-left:' + (20 * node.level) + 'px;">'
              + '<span style="color: #428bca;" class="icon node-icon glyphicon glyphicon-bookmark"></span>'
              + '&nbsp;' + node.text + ' - ' + node.code + '</span>');
          return $result;
        }

        $("#parentServiceCodeEdit").select2({
          dropdownParent: $("#edit"),
          placeholder: '<spring:message code="system.service.popup.create.lable.selectParentServiceCode"/>',
          width: "100%",
          data: trueServices,
          formatSelection: function (item) {
            return item.text + ' - ' + item.code
          },
          formatResult: function (item) {
            return item.id
          },
          templateResult: formatResult
        });
        $("#select2-parentServiceCodeEdit-container").html(listData[1]);
        $("#parentServiceCodeEdit").val(listData[2]);
      }
    }
  });
}