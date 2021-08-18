<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="modal fade bs-example-modal-lg in" id="action-role-delete" role="dialog"
     aria-labelledby="grantRole" aria-hidden="false">
    <%--<div class="modal-backdrop fade in"></div>--%>
    <div class="modal-dialog" role="document" style="width: 400px;">
        <input type="hidden" name="privilegeName" id="privilegeName" value="">
        <input type="hidden" name="roleName" id="roleName" value="">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">x</span></button>
                <h4 class="modal-title"><spring:message code="label.warning"/></h4>
            </div>
            <div class="modal-body">
                <!--tab1 -->
                <div class="row form-group">
                    <label class="control-label"><spring:message code="label.delete.confirm"/></label>
                </div>
                <div id="wrapper-chk-customer-confirm">
                    <input type="checkbox" name="chk-grant-privilege-confirm"
                           id="chk-grant-privilege-confirm">
                    <label for="chk-grant-privilege-confirm">
                        <spring:message code="account.dialog.check.agree"/>
                    </label>
                </div>
                <div id="msg-delete-privilege"></div>
                <!--end tab1 -->
            </div>
            <div class="modal-footer">
                <button type="button" id="btn-remove-role-privilege" class="btn btn-sm btn-primary"
                        onclick="deleteRolePrivilege()">
                    <spring:message code="label.delete"/>
                </button>
                <button type="button" class="btn btn-sm btn-default" data-dismiss="modal">
                    <spring:message code="popup.footer.label.cancel"/>
                </button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>