<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal fade bs-example-modal-lg in" id="action-grant-privilege" role="dialog"
     aria-labelledby="grantRole" aria-hidden="false">
    <%--<div class="modal-backdrop fade in"></div>--%>
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <form method="post" action="/ajax-controller/role/${roleId}/grantPrivilege"
                  id="grand_role_privilege">
                <input type="hidden" name="privilege_id" id="privilege-id" value="">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span></button>
                    <h4 class="modal-title"><spring:message
                            code="setting.account.privilege.add.label"/></h4>
                </div>
                <div class="modal-body">
                    <!--tab1 -->
                    <div class="row form-group">
                        <div class="">
                            <label class="col-md-3 col-sm-3 col-xs-3 control-label">
                                <spring:message
                                        code="setting.account.privilege.name.required.label"/>
                            </label>
                            <div class="col-md-9 col-sm-9 col-xs-9">
                                <select class="form-control js-select2-single select2-hidden-accessible"
                                        name="privilege" id="privilege-select" tabindex="-1"
                                        aria-hidden="true">
                                    <option value="" data-msg=""><spring:message
                                            code="setting.account.privilege.select.label"/></option>
                                    <c:forEach var="privilegeItem"
                                            items="${privileges}"
                                            varStatus="privileges_id">
                                        <option data-msg="${privilegeItem.privilege}" value="${privilegeItem.privilege}">
                                                ${privilegeItem.privilege}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="row form-group" style="margin-bottom: 0px;">
                            <label class="col-md-3 col-sm-3 col-xs-3 control-label"></label>
                            <div class="col-md-9 col-sm-9 col-xs-9" style="padding-left: 23px"
                                 id="privilege-description">
                            </div>
                        </div>
                    </div>
                    <div class="row form-group">
                        <label class="col-md-3 col-sm-3 col-xs-3 control-label"><spring:message
                                code="setting.account.privilege.from.date.label"/></label>
                        <div class="col-md-9 col-sm-9 col-xs-9">
                            <input type="text"
                                   placeholder="<spring:message code="setting.account.privilege.from.date.label"/>"
                                   class="form-control single-date-picker"
                                   name="validFrom" id="validFrom">
                        </div>
                    </div>
                    <div class="row form-group">
                        <label class="col-md-3 col-sm-3 col-xs-3 control-label"><spring:message
                                code="setting.account.privilege.to.date.label"/></label>
                        <div class="col-md-9 col-sm-9 col-xs-9">
                            <input type="text"
                                   placeholder="<spring:message code="setting.account.privilege.to.date.label"/>"
                                   class="form-control single-date-picker"
                                   name="validTo" id="validTo">
                        </div>
                    </div>
                    <div id="wrapper-chk-customer-confirm" style="padding-left: 15px">
                        <input type="checkbox" name="chk-customer-confirm"
                               id="chk-customer-confirm">
                        <label for="chk-customer-confirm"><spring:message
                                code="account.dialog.check.agree"/></label>
                    </div>
                    <div id="msg-grant-privilege">
                    </div>
                    <!--end tab1 -->
                </div>
                <div class="modal-footer">
                    <button type="submit" id="grant_role_privilege" class="btn btn-sm btn-primary">
                        <spring:message code="label.save"/></button>
                    <button type="button" class="btn btn-sm btn-default" data-dismiss="modal">
                        <spring:message code="label.close"/></button>
                </div>
            </form>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>
<script>
  $(function() {
    var singleDatePicker = $('.single-date-picker');
    singleDatePicker.daterangepicker({
      singleDatePicker: true,
      showDropdowns: true,
      minYear: 1901,
      locale: {
        format: 'DD/MM/YYYY'
      }
    });
  });
</script>
<style>
    .daterangepicker{
        z-index:1151 !important;
    }
</style>