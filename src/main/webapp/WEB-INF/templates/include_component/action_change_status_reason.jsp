<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="modal fade bs-example-modal-lg" id="action-blacklist" role="dialog" aria-labelledby="actionChangStatus" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
                <h4 class="modal-title"><spring:message code="account.dialog.change.status"></spring:message></h4>
            </div>
            <div class="modal-body">
                <spring:message code="label.user.active" var="active_special_merchant"/>
                <spring:message code="label.user.inactive" var="inActive_special_merchant"/>
                <!--tab1 -->
                <input type="hidden" id="account-id" name="account-id">
                <input type="hidden" id="blacklist-id" name="blacklist-id">
                <div class="row form-group">
                    <label class="col-md-4 col-sm-4 col-xs-4 control-label" for=""><spring:message code="account.dialog.change.status.reason"/></label>
                    <div class="col-md-8 col-sm-8 col-xs-8">
                            <select data-plugin-selectTwo
                                    class="form-control"
                                    id="blackListModal"
                                    name="isActive" style="width: 100%">
                                <option value=""><spring:message code="label.please.select"/></option>
                                <option value="true" ${account_object.isActive eq true ? 'selected' : ''}>${active_special_merchant}</option>
                                <option value="false" ${account_object.isActive eq false ? 'selected' : ''}>${inActive_special_merchant}
                                </option>
                            </select>
                        </select>
                    </div>
                </div>

                <div class="row form-group">
                    <label class="col-md-4 col-sm-4 col-xs-4 control-label" for="remark-modal-account-list"></label>
                    <div class="col-md-8 col-sm-8 col-xs-8">
                        <textarea class="form-control" rows="2" name="remark" id="remark-modal-account-list"></textarea>
                    </div>
                </div>

                <div id="wrapper-chk-customer-confirm" style="padding-left: 15px;">
                    <input type="checkbox" name="chk-customer-confirm" id="chk-customer-confirm">
                    <label for="chk-customer-confirm"><spring:message code="account.dialog.check.agree"/> </label>
                </div>

                <div id="msg-blacklist">
                </div>
                <!--end tab1 -->
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-sm btn-primary" id="btn-account-blacklist-save" onclick="changeStatusList()"><spring:message code="label.save"/> </button>
                <button type="button" class="btn btn-sm btn-default" data-dismiss="modal"><spring:message code="label.close"/></button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>