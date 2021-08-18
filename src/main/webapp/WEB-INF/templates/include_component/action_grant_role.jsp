<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="modal fade bs-example-modal-lg in" id="action-grant-role" role="dialog"
     aria-labelledby="grantRole" aria-hidden="false">
    <%--<div class="modal-backdrop fade in"></div>--%>
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <form method="post" action="/ajax-controller/account/${account_object.id}/grantRole" id="grand_account_role">
                <input type="hidden" name="role_id" id="role-id">

                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span></button>
                    <h4 class="modal-title"><spring:message
                            code="setting.account.role.add.label"/></h4>
                </div>
                <div class="modal-body">
                    <!--tab1 -->
                    <div class="row form-group">
                        <div class="">
                            <label class="col-md-3 col-sm-3 col-xs-3 control-label">
                                <spring:message
                                        code="setting.account.role.input.name.required.label"/>
                            </label>
                            <div class="col-md-9 col-sm-9 col-xs-9">
                                <select class="form-control" data-plugin-selectTwo style="width: 100%"
                                        name="role" id="role-select"
                                        aria-hidden="true">
                                    <option value="" data-msg=""><spring:message
                                            code="setting.account.role.select.label"/></option>
                                    <c:forEach var="roleItem"
                                            items="${list_role}">
                                        <option data-msg="${roleItem.role}" value="${roleItem.role}">
                                                ${roleItem.role}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="row form-group" style="margin-bottom: 0px;">
                            <label class="col-md-3 col-sm-3 col-xs-3 control-label"></label>
                            <div class="col-md-9 col-sm-9 col-xs-9" style="padding-left: 23px"
                                 id="role-description">
                            </div>
                        </div>
                    </div>
                    <div class="row form-group">
                        <label class="col-md-3 col-sm-3 col-xs-3 control-label"><spring:message
                                code="label.from.date.label"/></label>
                        <div class="col-md-9 col-sm-9 col-xs-9">
                            <input type="text"
                                   placeholder="<spring:message code="label.from.date.label"/>"
                                   class="form-control single-date-picker"
                                   name="validFrom" id="validFrom">
                        </div>
                    </div>
                    <div class="row form-group">
                        <label class="col-md-3 col-sm-3 col-xs-3 control-label"><spring:message
                                code="label.to.date.label"/></label>
                        <div class="col-md-9 col-sm-9 col-xs-9">
                            <input type="text"
                                   placeholder="<spring:message code="label.to.date.label"/>"
                                   class="form-control single-date-picker-to"
                                   name="validTo" id="validTo">
                        </div>
                    </div>
                    <div id="wrapper-chk-customer-confirm" style="padding-left: 15px">
                        <input type="checkbox" name="chk-customer-confirm"
                               id="chk-customer-confirm">
                        <label for="chk-customer-confirm"><spring:message
                                code="account.dialog.check.agree"/></label>
                    </div>
                    <div id="msg-grant-role">
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

    var singleDatePickerTo = $('.single-date-picker-to');
    singleDatePickerTo.daterangepicker({
      singleDatePicker: true,
      showDropdowns: true,
      minYear: 1901,
      locale: {
        format: 'DD/MM/YYYY'
      },
      startDate: moment().add(1, 'years')
    });
  });
</script>
<style>
    .daterangepicker{
        z-index:1151 !important;
    }
</style>