<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal fade" id="dialogMD-remove-special-customer" tabindex="-1" role="dialog" aria-hidden="true">

  <div class="modal-dialog" role="document" style="width: 400px;">
    <input type="hidden" name="customer-id-remove" id="customer-id-remove">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
            aria-hidden="true">x</span></button>
        <h4 class="modal-title"><spring:message code="label.warning"/></h4>
      </div>
      <div class="modal-body">

        <div class="row form-group" id="delete-account-confirm-label">
          <label class="control-label"><spring:message
              code="label.delete.account.confirm.label"/></label>
        </div>
        <div id="wrapper-chk-customer-confirm">
          <input type="checkbox" name="chk-account-confirm" id="chk-account-confirm">
          <label for="chk-account-confirm"><spring:message
              code="account.dialog.check.agree"/></label>
        </div>
        <div id="msg-remove-account"></div>


      </div>
      <div class="modal-footer">
        <button id="btn-remove-account" type="button" class="btn btn-primary"
                onclick="actionRemoveSpecialCustomer()"><spring:message
            code="label.delete"/></button>
        <button type="button" class="btn btn-default" data-dismiss="modal"><spring:message
            code="popup.footer.label.cancel"/></button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div>


