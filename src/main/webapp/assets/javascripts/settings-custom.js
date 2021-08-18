var grantCustomerRoleMode = null;
var grantRolePrivilegeMode = null;

//END VARIABLES
function confirmGrantRole(item) {
  var txt;
  var r = confirm("Do you really want to delete this " + item + "?");
  if (r == true) {
    txt = "You pressed OK!";
  } else {
    txt = "You pressed Cancel!";
  }
}

//Show password function
function togglePassword(field) {
  if (field.attr('type') == 'password') {
    field.attr('type') == 'text';
  } else {
    field.attr('type') == 'password';
  }
}

function callNotifyModal(msg, type) {
  if (type == 'success') {
    $('#notifyModal').find('.notify-message').addClass('text-success').html(
        msg);
  } else {
    $('#notifyModal').find('.notify-message').addClass('text-danger').html(msg);
  }
  $('#notifyModal').modal('show');
}

//privilege-description
$(document).ready(function () {
  //load default disable input for account detail screen
  $('#form-account-detail').find(':input:not(:button:not([type=submit]))').prop(
      'disabled', true);
  $('#form-account-detail').find('[name=atb-save]').prop('disabled', false);
  $('#form-account-detail').find('.not-disable').each(function (index, item) {
    jQuery(item).prop('disabled', false)
  });
  $('#form-account-detail').find('[name=accountId]').prop('disabled', false);
  $('#form-account-detail').find('[name=_csrf]').prop('disabled', false);
  $('#count-element-atb').prop('disabled', false);
  $('#form-role-detail').find(':input:not(:button:not([type=submit]))').prop(
      'disabled', true);
  $('#datatable-atb').find('.form-control').prop('disabled', false);

  $("#privilege-select").select2({
    width: '100%'
  }).on("change", function (e) {
    var msg = jQuery(e.target).find("option:selected").data('msg');
    jQuery('#privilege-description').html(msg);
  });
  //Clear notify modal
  $('#notifyModal').on('bs.modal.hidden', function () {
    $('#notifyModal').find('.notify-message').removeClass(
        'text-success').removeClass('text-danger').html('');
  });

  //Change password Handle
  function showChangePasswordValidate(validateResponse) {
    var form = $('#changePasswordForm');
    $.each(validateResponse, function (field, messages) {
      $.each(messages, function (i, message) {
        form.find(':input[name=' + field + ']').closest(
            '.col-md-8').append('<span class="help-block text-danger validated">'
            + message + '</span>');
      });
    });
  }

  function clearChangePasswordValidate() {
    $('#changePasswordForm').find('.help-block.validated').remove();
  }

  $('#changePasswordForm').submit(function (e) {
    e.preventDefault();
    clearChangePasswordValidate();
    var data = $(this).serialize();
    var msg = '';
    $.ajax({
      url: $(this).attr('action'),
      method: 'POST',
      data: data
    }).done(function (response) {
      var result = null;
      try {
        var result = JSON.parse(response);
      } catch (err) {
        result = response;
      }
      alertMsg(result.data.msg, result.data.type, 'msg-change-pwd');
    }).fail(function (jqXHR) {
      if (jqXHR.status == 422) {
        alertMsg('Please fix some problems!', 0, 'msg-change-pwd');
        showChangePasswordValidate(jqXHR.responseJSON);
      } else {
        msg = 'lbl_system_cannot_response';
        alertMsg(msg, 0, 'msg-change-pwd');
      }
    });
    return false;
  });
  //Grand Role
  $('#action-grant-role').on('hide.bs.modal', function (e) {
    if (e.namespace == 'bs.modal') {
      grantCustomerRoleMode = null;
      clearRoleValidate();
      $('#grand_account_role')[0].reset();
      $('#action-grant-role').find("#roleId").val('');
    }
  });
  $('#grand_account_role').submit(function (e) {
    e.preventDefault();
    //validate checkbox
    if (jQuery('#chk-customer-confirm').is(':checked') == false) {
      alertMsg('Please check Term of use!', 0, 'msg-grant-role');
      return;
    }
    var valueRoleSelect = jQuery('#role-select option:selected').val();
    //validate blacklist
    if (valueRoleSelect == '') {
      alertMsg('Please select Role name!', 0, 'msg-grant-role');
      return;
    }
    //validate date
    var validFrom = $('#validFrom').val();
    if (validFrom != null) {
      validFrom = new Date(moment(validFrom, 'DD/MM/YYYY'));
    }
    var validTo = $('#validTo').val();
    if (validTo != null) {
      validTo = new Date(moment(validTo, 'DD/MM/YYYY'));
    }
    if (validFrom != null && validTo != null && validFrom > validTo) {
      alertMsg('Valid From need before or equal Valid To!', 0,
          'msg-grant-role');
      return false;
    }

    $data = $(this).serialize();
    $.ajax({
      url: $(this).attr('action'),
      data: $data,
      method: 'POST'
    }).done(function (response) {
      if (response.status.code == 0) {
        if (grantCustomerRoleMode == 'edit') {
          alertMsg('Update Role Success!', 1, 'msg-grant-role');
          updateRoleTable($data);
        } else {
          alertMsg('Grant Role Success!', 1, 'msg-grant-role');
          addRoleToTable(response.umgrCustomerRoleId, $data);
        }
        $('#grant-role').prop('disabled', true);
      } else {
        alertMsg(response.status.value, 0, 'msg-grant-role');
      }
    }).fail(function (jqXHR) {
      if (jqXHR.status == 404) {
        alertMsg('Cannot connect to Server!', 0, 'msg-grant-role');
      }
      if (jqXHR.status == 405) {
        alertMsg('Method not Allowed!', 0, 'msg-grant-role');
      }
      if (jqXHR.status == 422) {
        clearRoleValidate();
        showRoleValidate(jqXHR.responseJSON);
        alertMsg('You must fill all required field!', 0, 'msg-grant-role');
      }
    });
  });
  //_END_ Grand Role

  $('#action-show-google-authen').on('shown.bs.modal', function (e) {
    var accountId = $("#accountId").val();
    $.ajax({
      url: ctx + "/ajax-controller/consumer/getGoogleAuthenticatorInfo",
      data: {account_id: accountId},
      method: 'POST'
    }).done(function (response) {
      if (response.status.code == 0) {
        $("#img_google_secret").attr("src", response.url);
      } else {
        alertMsg(response.status.value, 0, 'msg-grant-role');
      }
    }).fail(function (jqXHR) {
      if (jqXHR.status == 404) {
        alertMsg('Cannot connect to Server!', 0, 'msg-grant-role');
      }
      if (jqXHR.status == 405) {
        alertMsg('Method not Allowed!', 0, 'msg-grant-role');
      }
      if (jqXHR.status == 422) {
        showRoleValidate(jqXHR.responseJSON);
        alertMsg('You must fill all required field!', 0, 'msg-grant-role');
      }
    });
  })

  $('#reset_google_authen').submit(function (e) {
    if (!confirm('Do you really want to reset Google Authenticator?')) {
      return false;
    }
    $('#img_google_secret').attr("src",
        "/assets/development/static/images/loading_icon.gif");
    e.preventDefault();
    var data = $(this).serialize();
    $.ajax({
      url: $(this).attr('action'),
      data: data,
      method: 'POST'
    }).done(function (response) {
      if (response.status.code == 0) {
        alertMsg('Reset Google Authenticator Success!', 1,
            'msg-grant-privilege');
        $('#img_google_secret').attr("src", response.url);
      } else {
        alertMsg(response.status.value, 0, 'msg-grant-role');
      }
    }).fail(function (jqXHR) {
      if (jqXHR.status == 404) {
        alertMsg('Cannot connect to Server!', 0, 'msg-grant-role');
      }
      if (jqXHR.status == 405) {
        alertMsg('Method not Allowed!', 0, 'msg-grant-role');
      }
      if (jqXHR.status == 422) {
        showRoleValidate(jqXHR.responseJSON);
        alertMsg('You must fill all required field!', 0, 'msg-grant-role');
      }
    });
  })

  //action grant privilege for role
  $('#action-grant-privilege').on('hide.bs.modal', function (e) {
    if (e.namespace == 'bs.modal') {
      grantRolePrivilegeMode = null;
      clearPrivilegeValidate();
      $('#grand_role_privilege')[0].reset();
      $('#action-grant-role').find("#privilegeId").val('');
      jQuery('#privilege-select').val('').trigger("change");
    }
  });
  $('#grand_role_privilege').submit(function (e) {
    e.preventDefault();
    $data = $(this).serialize();
    $data += '&isEdit=' + grantRolePrivilegeMode;
    var privilegeName = jQuery('#privilege-select').val();
    //validate checkbox
    if (jQuery('#chk-customer-confirm').is(':checked') == false) {
      alertMsg('Please check Term of use!', 0, 'msg-grant-privilege');
      return false;
    }

    if (privilegeName == '') {
      alertMsg('Privilege Name is null!', 0, 'msg-grant-privilege');
      return false;
    }

    $.ajax({
      url: $(this).attr('action'),
      data: $data,
      method: 'POST'
    }).done(function (response) {
      if (response.status.code == 0) {
        if (grantRolePrivilegeMode == 'edit') {
          alertMsg('Update Privilege Success!', 1, 'msg-grant-privilege');
          updatePrivilegeTable($data);
          $('#grant_role_privilege').prop('disabled', true);
        } else {
          alertMsg('Grant Privilege Success!', 1, 'msg-grant-privilege');
          addPrivilegeToTable(privilegeName, $data);
        }
        $('#grant-role').prop('disabled', true);
      } else {
        alertMsg(response.status.value, 0, 'msg-grant-privilege');
      }
    }).fail(function (jqXHR) {
      if (jqXHR.status == 404) {
        alertMsg('Cannot connect to Server!', 0, 'msg-grant-privilege');
      }
      if (jqXHR.status == 405) {
        alertMsg('Method not Allowed!', 0, 'msg-grant-privilege');
      }
      if (jqXHR.status == 422) {
        clearPrivilegeValidate();
        showPrivilegeValidate(jqXHR.responseJSON);
        alertMsg('You must fill all required field!', 0, 'msg-grant-privilege');
      }
    });
  });

  // jQuery('#action-blacklist').on('show.bs.modal', function (e) {
  //   alert(123);
  // });

});

//=====Grand Role
//show dialog role
$('#action-grant-role').on('hide.bs.modal', function (e) {
  if (e.namespace == 'bs.modal') {
    grantCustomerRoleMode = null;
    clearRoleValidate();
    // $('#grand_account_role')[0].reset();
    $('#action-grant-role').find("#roleId").val('');
  }
});

//submit update role
$('#grand_account_role').submit(function (e) {
  e.preventDefault();
  //validate checkbox
  if (jQuery('#chk-customer-confirm').is(':checked') == false) {
    alertMsg('Please check Term of use!', 0, 'msg-grant-role');
    return;
  }
  var valueRoleSelect = jQuery('#role-select option:selected').val();
  //validate blacklist
  if (valueRoleSelect == '') {
    alertMsg('Please select Role name!', 0, 'msg-grant-role');
    return;
  }
  //validate date
  var validFrom = $('#validFrom').val();
  if (validFrom != null) {
    validFrom = new Date(moment(validFrom, 'DD/MM/YYYY'));
  }
  var validTo = $('#validTo').val();
  if (validTo != null) {
    validTo = new Date(moment(validTo, 'DD/MM/YYYY'));
  }
  if (validFrom != null && validTo != null && validFrom > validTo) {
    alertMsg('Valid From need before or equal Valid To!', 0,
        'msg-grant-role');
    return false;
  }

  $data = $(this).serialize();
  $.ajax({
    url: $(this).attr('action'),
    data: $data,
    method: 'POST'
  }).done(function (response) {
    if (response.status.code == 0) {
      if (grantCustomerRoleMode == 'edit') {
        alertMsg('Update Role Success!', 1, 'msg-grant-role');
        updateRoleTable($data);
      } else {
        alertMsg('Grant Role Success!', 1, 'msg-grant-role');
        addRoleToTable(response.umgrCustomerRoleId, $data);
      }
      $('#grant-role').prop('disabled', true);
    } else {
      alertMsg(response.status.value, 0, 'msg-grant-role');
    }
  }).fail(function (jqXHR) {
    if (jqXHR.status == 404) {
      alertMsg('Cannot connect to Server!', 0, 'msg-grant-role');
    }
    if (jqXHR.status == 405) {
      alertMsg('Method not Allowed!', 0, 'msg-grant-role');
    }
    if (jqXHR.status == 422) {
      clearRoleValidate();
      showRoleValidate(jqXHR.responseJSON);
      alertMsg('You must fill all required field!', 0, 'msg-grant-role');
    }
  });
});

//=========EDIT CUSTOMER ROLE
function editCustomerRoleModal(id, button) {
  grantCustomerRoleMode = 'edit';
  var $row = $(button).closest('tr').addClass('selected');
  updateGrantCustomerModal(id, $row);
  jQuery('#action-grant-role').modal('show');
  return false;
}

function updateGrantCustomerModal(id, row) {
  var roleName = row.find('.roleName').html();
  var validFrom = row.find('.roleValidFrom').html();
  var validTo = row.find('.roleValidTo').html();

  jQuery('#action-grant-role').find("#role-id").val(id);
  jQuery('#action-grant-role').find("#role-select").val(roleName).trigger(
      'change');
  jQuery('#action-grant-role').find("#validFrom").val(validFrom);
  jQuery('#action-grant-role').find("#validTo").val(validTo);
}

//=======_END_ EDIT CUSTOMER ROLE

//account list


function alertMsg(msg, isSuccess, idMsg) {
  var htmlMsg = '';
  if (isSuccess == 0) {
    htmlMsg += '<i class="fa fa-info-circle text-danger fa-lg" aria-hidden="true"></i> ';
  } else {
    htmlMsg += '<i class="fa fa-check text-success fa-lg" aria-hidden="true"></i> ';
  }
  htmlMsg += msg;
  if (isSuccess == 0) {
    jQuery('#' + idMsg).html(
        '<div class="form-group warp-msg"><div class="alert alert-danger">'
        + htmlMsg
        + '</div></div>'
    );
  } else {
    jQuery('#' + idMsg).html(
        '<div class="form-group warp-msg"><div class="alert alert-success">'
        + htmlMsg
        + '</div></div>'
    );
  }

}

function removeCustomerRoleModal(roleName) {
  $('#datatable-role').find('tr.selected').removeClass('selected');
  jQuery('#roleName').val(roleName);
  jQuery('#msg-delete-role').html('');
  jQuery('#chk-account-confirm').prop('checked', false);
  $('#removeRole').prop('disabled', false);
  $('tr.' + roleName).addClass('selected');
  $('#action-grant-delete').modal('show');
}

function removeCustomerRole() {
  var accountId = jQuery('#accountId').val();
  var roleName = jQuery('#roleName').val();
  //validate checkbox
  if (jQuery('#chk-account-confirm').is(':checked') == false) {
    alertMsg('Please check Term of use!', 0, 'msg-delete-role');
    return;
  }
  $.ajax({
    url: ctx + '/ajax-controller/account/remove-customer-role',
    method: 'POST',
    data: {roleName: roleName, customerId: accountId},
    success: function (response) {
      var result = null;
      try {
        result = JSON.parse(response);
      } catch (e) {
        result = response;
      }
      if (result.status.code == 0) {
        jQuery('#datatable-role').dataTable().api().row('#datatable-role .'
            + roleName).remove().draw();
        //success
        alertMsg('Remove role successful!', 1, 'msg-delete-role');
        $('#removeRole').prop('disabled', true);
      }
    }
  });
}

//account list end
function showRoleValidate(validateResponse) {
  var form = $('#grand_account_role');
  $.each(validateResponse, function (field, messages) {
    $.each(messages, function (i, message) {
      form.find(':input[name=' + field
          + ']').parent().append('<span class="help-block text-danger validated">'
          + message + '</span>');
    });
  });
}

//role manager
function clearRoleValidate() {
  $('#grand_account_role').find('.help-block.validated').remove();
  $('#action-grant-role').find("#role-select").val('').trigger('change');
  $('#grand_account_role').find("#validFrom").val();
  $('#grand_account_role').find("#validTo").val();
  jQuery('#role-description').html('');
  jQuery('#msg-grant-role').html('');
  jQuery('#chk-customer-confirm').prop('checked', false);
  $('#grant-role').prop('disabled', false);
}

function addRoleToTable($id, $data) {
  $data = decodeURIComponent($data);
  $row = $.parseJSON('{"' + $data.replace(/&/g, '","').replace(/=/g, '":"')
      + '"}');
  $action = getRoleAccountAction($id);
  $node = roleTable.api().row.add(
      ['', $row.role, getTimeFormat($row.validFrom),
        getTimeFormat($row.validTo), '', $action]).draw().node();
  $($node).addClass(String($id));
  $($node).find('td').eq(1).addClass('roleName');
  $($node).find('td').eq(2).addClass('roleValidFrom');
  $($node).find('td').eq(3).addClass('roleValidTo');
}

function updateRoleTable($data) {
  $data = decodeURIComponent($data);
  $row = $.parseJSON('{"' + $data.replace(/&/g, '","').replace(/=/g, '":"')
      + '"}');
  $action = getRoleAccountAction($row.roleId);
  $dateFrom = {
    '@data-order': moment($row.validFrom, "DD/MM/YYYY").format("x"),
    'display': moment($row.validFrom, "DD/MM/YYYY").format(
        "DD/MM/YYYY")
  };
  $dateTo = {
    '@data-order': moment($row.validTo, "DD/MM/YYYY").format("x"),
    'display': moment($row.validTo, "DD/MM/YYYY").format(
        "DD/MM/YYYY")
  };
  $node = roleTable.api().row('#datatable-role tr.selected').data(
      [null, $row.role, $dateFrom.display, $dateTo.display, null,
        $action]).draw();
  $($node.node()).removeClass('selected');
  grantCustomerRoleMode = null;
}

function getRoleAccountAction(id) {
  $html = '';
  $html += getRoleAccountEditAction(id);
  $html += getRoleAccountDeleteAction(id);
  return $html;
}

function getRoleAccountEditAction(id) {
  $html = '<i class="fa fa-2x fa-pencil-square text-success" onclick="editCustomerRoleModal('
      + id + ', this)" style="cursor: pointer;" aria-hidden="true"></i> ';
  return $html;
}

function getRoleAccountDeleteAction(id) {
  $html = '<i class="fa fa-2x fa-trash-o text-danger" data-toggle="popover" data-trigger="hover" data-placement="top" data-content="Xóa" style="cursor: pointer;" onclick="removeCustomerRoleModal(\''
      + id + '\')" aria-hidden="true"></i>'
  return $html;
}

function getTimeFormat($data) {
  if (!$data) {
    return '';
  }
  return decodeURIComponent($data)
}

function removeRoleModal(roleName) {
  jQuery('#roleName').val(roleName);
  jQuery('#msg-delete-role').html('');
  jQuery('#chk-account-confirm').prop('checked', false);
  $('#removeRole').prop('disabled', false);
}

function removeRole() {
  var roleName = jQuery('#roleName').val();
  var token = window.Laravel.csrfToken;
  //validate checkbox
  if (jQuery('#chk-account-confirm').is(':checked') == false) {
    alertMsg('Please check Term of use!', 0, 'msg-delete-role');
    return;
  }
  $.ajax({
    url: '/role/remove-role',
    method: 'DELETE',
    data: {roleName: roleName, _token: token},
    success: function (response) {
      var result = JSON.parse(response);
      if (result.status.code == 0) {
        jQuery('#datatable-role').dataTable().api().row('#datatable-role .'
            + roleName).remove().draw();
        //success
        alertMsg('Remove role successful!', 1, 'msg-delete-role');
        $('#removeRole').prop('disabled', true);
      }
    }
  });
}

function preChangeStatusRole(roleName) {
  //init
  jQuery('#roleName').val(roleName);
  var chkStatus = jQuery('#chk' + roleName).is(":checked");
  jQuery('#chk-account-confirm').attr('checked', false);
  var status = 'Y';
  if (chkStatus == true) {
    status = 'N';
  }
  jQuery('#btnChangeStatusRole').attr('disabled', false);
  jQuery('#roleStatus').val(status);
  jQuery('#action-change-status-role').modal('show');
  jQuery('#msg-change-role').html('');
  return false;
}

function changeStatusRole() {
  var roleName = jQuery('#roleName').val();
  var status = jQuery('#roleStatus').val();
  // var token = $("meta[name='_csrf']").attr("content");
  //validate checkbox
  if (jQuery('#chk-account-confirm').is(':checked') == false) {
    alertMsg('Please check Term of use!', 0, 'msg-change-role');
    return;
  }
  $.ajax({
    url: ctx + '/ajax-controller/role/change-status-role',
    method: 'POST',
    data: {roleName: roleName, active: status},
    success: function (result) {
      if (result.status.code == 0) {
        //success
        alertMsg('Change status role successful!', 1, 'msg-change-role');
        var isChecked = (status == 'Y') ? true : false;
        jQuery('#chk' + roleName).prop('checked', isChecked);
        jQuery('#btnChangeStatusRole').prop('disabled', true);
      } else {
        alertMsg(result.status.value, 0, 'msg-change-role');
      }
    }, error: function (e) {
      alertMsg('Change status role failed!', 0, 'msg-change-role');
    }
  });
}

function createRolePrivilegeModal() {
  jQuery('#privilege-select').prop("disabled", false);
  jQuery('#grant_role_privilege').prop('disabled', false);
  $('#action-grant-privilege').find("#validFrom").val();
  $('#action-grant-privilege').find("#validTo").val();

  $('#action-grant-privilege').find("#privilege-id").val('');
  $('#action-grant-privilege').modal('show');
}

function editRolePrivilegeModal(id, button) {
  grantRolePrivilegeMode = 'edit';
  jQuery('#privilege-select').prop("disabled", true);
  jQuery('#grant_role_privilege').prop('disabled', false);
  var $row = $(button).closest('tr').addClass('selected');
  updateRolePrivilegeModal(id, $row);
  $('#action-grant-privilege').modal('show');
}

function updateRolePrivilegeModal(id, row) {
  var node = roleTable.api().row(row).data();
  var roleName = node[1];
  var validFrom = node[2];
  var validTo = node[3];
  $('#action-grant-privilege').find("#privilege-id").val(roleName);
  jQuery('#privilege-select').val(roleName).trigger("change");
  $('#action-grant-privilege').find("#validFrom").val(null);
  $('#action-grant-privilege').find("#validTo").val(null);
  if (validFrom != '') {
    $('#action-grant-privilege').find("#validFrom").val(validFrom);
  }
  if (validTo != '') {
    $('#action-grant-privilege').find("#validTo").val(validTo);
  }
}

function showPrivilegeValidate(validateResponse) {
  var form = $('#grand_role_privilege');
  $.each(validateResponse, function (field, messages) {
    $.each(messages, function (i, message) {
      form.find(':input[name=' + field
          + ']').parent().append('<span class="help-block text-danger validated">'
          + message + '</span>');
    });
  });
}

function clearPrivilegeValidate() {
  $('#grand_role_privilege').find('.help-block.validated').remove();
  jQuery('#msg-grant-privilege').html('');
  jQuery('#chk-customer-confirm').prop('checked', false);
  $('#grand_role_privilege').prop('disabled', false);
}

function addPrivilegeToTable($id, $data) {
  $data = decodeURIComponent($data);
  var row = $.parseJSON('{"' + $data.replace(/&/g, '","').replace(/=/g, '":"')
      + '"}');
  var action = getGrantRoleAction($id);

  $node = roleTable.api().row.add(
      ['', row.privilege, row.validFrom, row.validTo, '', action]).draw();
  $($node.node()).addClass(row.privilege);
  $('[data-toggle="popover"]').popover()
}

function getGrantRoleAction(id) {
  var html = '';
  html += '<i class="fa fa-2x fa-pencil-square text-success" onclick="editRolePrivilegeModal(\''
      + id + '\',this)" style="cursor: pointer;" aria-hidden="true"></i>  ';
  html += '<i class="fa fa-2x fa-trash-o text-danger" onclick="deleteRolePrivilegeModal(\''
      + id + '\');" style="cursor: pointer;"></i>';
  return html;
}

function updatePrivilegeTable($data) {
  $data = decodeURIComponent($data);
  var row = $.parseJSON('{"' + $data.replace(/&/g, '","').replace(/=/g, '":"')
      + '"}');
  var action = getGrantRoleAction(row.privilege_id);

  $node = roleTable.api().row('#datatable-role tr.selected').data(
      ['', row.privilege_id, row.validFrom, row.validTo, '', action]).draw();
  $($node.node()).removeClass('selected');
  grantRolePrivilegeMode = null;
  $('[data-toggle="popover"]').popover()
}

function deleteRolePrivilegeModal(privilegeName) {
  jQuery('#action-role-delete').modal('show');
  jQuery('#privilegeName').val(privilegeName);
  jQuery('#chk-grant-privilege-confirm').prop('checked', false);
  jQuery('#btn-remove-role-privilege').prop('disabled', false);
  jQuery('#msg-delete-privilege').html('');
}

function deleteRolePrivilege() {
  //validate checkbox
  if (jQuery('#chk-grant-privilege-confirm').is(':checked') == false) {
    alertMsg('Please check Term of use!', 0, 'msg-delete-privilege');
    return;
  }
  var privilegeName = jQuery('#privilegeName').val();
  var roleName = jQuery('#role-name').val();
  $.ajax({
    url: ctx + '/ajax-controller/role/remove-role-privilege',
    method: 'POST',
    data: {privilegeId: privilegeName, roleId: roleName},
    success: function (result) {
      if (result !== null && result !== "" && result.status.code == 0) {
        //success
        jQuery('#datatable-role').dataTable().api().row('#datatable-role .'
            + privilegeName).remove().draw();
        alertMsg('Remove privilege successful!', 1, 'msg-delete-privilege');
        jQuery('#btn-remove-role-privilege').prop('disabled', true);

      } else {
        alertMsg(result.status.value, 0, 'msg-delete-privilege');
      }
    }
  });
}

//role manager end
//privileges manager
function preChangeStatusPrivilege(privilegeName) {
  //init
  jQuery('#privilegeName').val(privilegeName);
  var chkStatus = jQuery('#chk' + privilegeName).is(":checked");
  jQuery('#chk-account-confirm').attr('checked', false);
  var status = 'Y';
  if (chkStatus == true) {
    status = 'N';
  }
  jQuery('#btnChangeStatusPrivilege').attr('disabled', false);
  jQuery('#privilegeStatus').val(status);
  jQuery('#action-change-status-privilege').modal('show');
  jQuery('#msg-change-privilege').html('');
  return false;

}

function changeStatusPrivilege() {
  var privilegeName = jQuery('#privilegeName').val();
  var status = jQuery('#privilegeStatus').val();
  //validate checkbox
  if (jQuery('#chk-account-confirm').is(':checked') == false) {
    alertMsg('Please check Term of use!', 0, 'msg-change-privilege');
    return;
  }
  $.ajax({
    url: ctx + '/ajax-controller/privilege/change-status-privilege',
    method: 'POST',
    data: {privilegeName: privilegeName, active: status},
    success: function (result) {
      if (result.status.code == 0) {
        //success
        alertMsg('Change status role successful!', 1, 'msg-change-privilege');
        var isChecked = (status == 'Y') ? true : false;
        jQuery('#chk' + privilegeName).prop('checked', isChecked);
        jQuery('#btnChangeStatusPrivilege').prop('disabled', true);
      } else {
        alertMsg(result.status.value, 0, 'msg-change-privilege');
      }
    },
    error: function (e) {
      alertMsg('Change status privilege failed!', 0, 'msg-privilege-role');
    }
  });
}

// privileges manager end

// resend info account
function resendInfo(cifId) {
  jQuery('#resend-customer-id').val(cifId);
  jQuery('#btn-resend-info').prop('disabled', false);
  jQuery('#msg-resend').text('');
  jQuery('#resend-info').modal('show');
}

function actionResendInfo() {
  var customerId = jQuery('#resend-customer-id').val();
  // var token = window.csrfToken;

  $.ajax({
    url: ctx + '/ajax-controller/account/resendInfo',
    method: 'POST',
    // data: {cif:cif,_csrf:token},
    data: {customerId: customerId},
    success: function (result) {
      if (result.status.code == 0) {
        //success
        alertMsg('Gửi lại thông tin kết nối thành công!', 1, 'msg-resend');
        jQuery('#btn-resend-info').prop('disabled', true);
        setTimeout(
            function () {
              jQuery('#resend-info').modal('toggle');
            }, 5000);
      } else {
        alertMsg(result.status.value, 0, 'msg-resend');
      }
    }
  });
}

function addAttribute() {
  var countElementAtb = jQuery('#count-element-atb');
  var stt = parseInt(countElementAtb.val()) + 1;
  var listAtb = jQuery('#list-attribute').find('select:first-child').prop(
      'disabled', false).prop('required', true).clone();
  listAtb.prop('name', 'accountAttributeId' + stt);
  listAtb.removeClass('hidden');
  listAtb.removeClass('select2-hidden-accessible');
  var atbValue = '<input class="form-control" name="accountAttributeValue'
      + stt + '" type="text" required>';
  var btnDelete = '<i class="fa fa-2x fa-trash-o text-danger" data-toggle="popover" '
      +
      'data-trigger="hover" data-placement="top" data-content="delete" style="cursor: pointer;" '
      +
      'onclick="removeAtb(null, null, this)" ></i>';

  jQuery('#datatable-atb').dataTable().api().row.add(
      ['', listAtb[0].outerHTML, atbValue,
        '<center>' + btnDelete + '</center>']).draw();
  jQuery('[data-toggle="popover"]').popover();
  countElementAtb.val(stt);
}

function saveAttribute() {
  // alert('AAAAAAA');
  // return false;
}

function removeAtb(account_id, attribute_id, e) {
  if (attribute_id == null || account_id == null) {
    var row = jQuery(e).closest('tr');
    jQuery('#datatable-atb').dataTable().api().row(row).remove().draw();
  } else {
    $.ajax({
      url: ctx + "/ajax-controller/consumer/" + account_id
      + "/deleteCustomerAttribute",
      data: {attribute_id: attribute_id},
      method: 'POST'
    }).done(function (response) {
      if (response.status.code == 0) {
        var row = jQuery(e).closest('tr');
        jQuery('#datatable-atb').dataTable().api().row(row).remove().draw();
      }
    }).fail(function (jqXHR) {
      if (jqXHR.status == 404) {
        alertMsg('Cannot connect to Server!', 0, 'msg-grant-role');
      }
      if (jqXHR.status == 405) {
        alertMsg('Method not Allowed!', 0, 'msg-grant-role');
      }
      if (jqXHR.status == 422) {
        clearRoleValidate();
        showRoleValidate(jqXHR.responseJSON);
        alertMsg('You must fill all required field!', 0, 'msg-grant-role');
      }
    });
  }
}

function selectCustomerType(customer_type_id) {
  var wallet_type = $('#lbl-wallet-type');
  var user_type = $('#lbl-user-type');
  if (8 == customer_type_id || 9 == customer_type_id || 10 == customer_type_id
      || 6 == customer_type_id || 7 == customer_type_id) {
    wallet_type.html("Account");
  } else {
    wallet_type.html("Wallet");
  }

  if (8 == customer_type_id || 9 == customer_type_id || 10
      == customer_type_id) {
    user_type.html("System");
  } else {
    user_type.html("User");
  }
}

function changeStatusAccount(accountId, blackListReason) {
  //init
  var blackListReasonValue = jQuery('#user-' + accountId + '-blackListReason').val();
  jQuery('#msg-blacklist').text('');
  jQuery('#remark-modal-account-list').val('');
  jQuery('#wrapper-chk-customer-confirm').show();
  jQuery('#chk-customer-confirm').attr('checked', false);
  jQuery('#btn-account-blacklist-save').attr('disabled', false);

  var actionBlackList = jQuery('#action-blacklist');
  actionBlackList.find('#account-id').val(accountId);
  actionBlackList.find('#blacklist-id').val(blackListReasonValue);
  actionBlackList.find('#blackListModal').val(blackListReasonValue).trigger('change');
  actionBlackList.modal('show');
  return false;
}

function changeStatusList() {
  var accountId = jQuery('#account-id').val();
  var blacklistIdOld = jQuery('#blacklist-id').val();
  var valueBlackList = jQuery('#blackListModal').val();
  var valueBlackListText = jQuery('#blackListModal option:selected').text();
  //validate blacklist
  if (valueBlackList == '') {
    alertMsg('Please select change status!', 0, 'msg-blacklist');
    return;
  }
  if (blacklistIdOld == valueBlackList) {
    alertMsg('Please change status!', 0, 'msg-blacklist');
    return;
  }

  //validate remark
  var remark = jQuery('#remark-modal-account-list').val();
  if (remark == '') {
    alertMsg('Please input Remark', 0, 'msg-blacklist');
    return;
  }

  //validate checkbox
  if (jQuery('#chk-customer-confirm').is(':checked') == false) {
    alertMsg('Please check Term of use!', 0, 'msg-blacklist');
    return;
  }

  //change blackList reason
  actionChangeStatus(valueBlackList, remark, accountId,
      valueBlackListText);
}

function actionChangeStatus(valueBlackList, remark, accountId,
    valueBlackListText) {
  $.ajax({
    url: ctx + '/ajax-controller/account/changeStatus',
    method: 'POST',
    data: {
      isActive: valueBlackList,
      customerId: accountId,
      description: remark
    },
    success: function (result) {
      if (result !== null && result !== "" && result.status.code === 0) {
        //success
        alertMsg('Status change success!', 1, 'msg-blacklist');
        jQuery('#wrapper-chk-customer-confirm').hide();
        jQuery('#btn-account-blacklist-save').attr('disabled', true);
        //Update Input Change Status;
        jQuery('#user-' + accountId + '-blackListReason').val(valueBlackList);
        jQuery('#txn-blacklist-reason-' + accountId).text(valueBlackListText);
        if (valueBlackList == 'true') {
          jQuery('#txn-blacklist-reason-' + accountId).removeClass(
              'text-danger');
          jQuery('#txn-blacklist-reason-' + accountId).addClass('text-success');
          jQuery('#chk-blacklist-status-' + accountId).prop('checked', true);
        } else {
          jQuery('#txn-blacklist-reason-' + accountId).removeClass(
              'text-success');
          jQuery('#txn-blacklist-reason-' + accountId).addClass('text-danger');
          jQuery('#chk-blacklist-status-' + accountId).prop('checked', false);
        }

      } else {
        alertMsg(result.status.value, 0, 'msg-blacklist');
      }
    }
  });
}



function removeSpecialCustomer(cifId) {
  jQuery('#customer-id-remove').val(cifId);
  jQuery('#btn-remove-account').prop('disabled', false);
  jQuery('#msg-remove-account').text('');
  jQuery('#chk-account-confirm').prop('checked', false);

  jQuery('#delete-account-confirm-label').show();
  jQuery('#wrapper-chk-customer-confirm').show();
  jQuery('#chk-account-confirm').show();

  jQuery('#dialogMD-remove-special-customer').modal('show');
}

function actionRemoveSpecialCustomer() {
  var customerId = jQuery('#customer-id-remove').val();
  var token = window.csrfToken;
//validate checkbox
  if (jQuery('#chk-account-confirm').is(':checked') == false) {
    alertMsg('Please check Term of use!', 0, 'msg-remove-account');
    return;
  }
  $.ajax({
    url: ctx + '/ajax-controller/account/remove-account',
    method: 'POST',
    data: {customerId: customerId, _csrf: token},
    success: function (result) {
      if (result.status.code == 0) {
        //success
        jQuery(
            '#acount-list-table').dataTable().api().row('#acount-list-table .customer-'
            + customerId + '').remove().draw();
        alertMsg('Xóa tài khoản thành công !', 1,
            'msg-remove-account');

        jQuery('#btn-remove-account').prop('disabled', true);
        // setTimeout(
        //     function () {
        //       jQuery('#dialogMD-remove-special-customer').modal('toggle');
        //     }, 5000);
      } else {
        alertMsg(result.status.value, 0, 'msg-remove-account');
      }
      jQuery('#delete-account-confirm-label').hide();
      // jQuery('#chk-account-confirm').hide();
      jQuery('#wrapper-chk-customer-confirm').hide();
    }
  });
}