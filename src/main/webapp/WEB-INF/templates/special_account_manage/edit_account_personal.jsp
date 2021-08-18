<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="panel-title">
  <h4 style="margin-bottom: 1.5rem">Thông tin thêm</h4>

  <div class="panel-tools hidden">
    <sec:authorize access="hasAnyRole('ADMIN_OPERATION')">
      <a class="mb-xs mt-xs btn btn-success" style="line-height: 28px" href="#">
        <i class="fa fa-plus"></i>&nbsp;</a>
    </sec:authorize>
  </div>
</div>
<div class="panel-body">
  <div class="row">
    <div class="form-group">
      <div class="col-md-6 col-lg-6 col-sm-12">
        <label class="col-md-4 col-lg-4  col-sm-4 control-label nowrap">Ảnh đại diện&nbsp; *</label>
        <div class="col-md-8 col-lg-8  col-sm-8 double-input">
          <img src="${img_profile}" height="140px"/>
        </div>
      </div>
      <div class="col-md-6 col-lg-6 col-sm-12">
        <label class="col-md-5 col-lg-4 col-sm-4 control-label nowrap"></label>
        <div class="col-md-7 col-lg-8 col-sm-8"></div>
      </div>
    </div>
  </div>

  <div class="row">
    <div class="">
      <div class="col-md-6 col-lg-6 col-sm-12  form-group">
        <label class="col-md-4 col-lg-4 col-sm-4 control-label nowrap">Quốc tịch</label>
        <div class="col-md-8 col-lg-8 col-sm-8">
          <input type="text" id="account-country" name="account-country" class="form-control w100"
                 value="${account_object.country}"/>
        </div>
      </div>
      <div class="col-md-6 col-lg-6 col-sm-12  form-group">
        <label class="col-md-5 col-lg-4 col-sm-4 control-label nowrap">Ngày sinh</label>
        <div class="col-md-7 col-lg-8 col-sm-8">
          <input type="text" id="account-dateofbirth" name="account-dateofbirth"
                 data-inputmask="'alias': 'date'"
                 pattern="(0[1-9]|1[0-9]|2[0-9]|3[01])/(0[1-9]|1[012])/[0-9]{4}"
                 class="form-control w100" value="${account_object.textDateOfBirth()}">
        </div>
      </div>
    </div>
  </div>

  <div class="row">
    <div class="form-group">
      <div class="col-md-6 col-lg-6 col-sm-12">
        <label class="col-md-4 col-lg-4 col-sm-4 control-label nowrap">Giới thiệu</label>
        <div class="col-md-8 col-lg-8 col-sm-8">
          <textarea class="form-control w100" id="account-about" name="account-about"
                    maxlength="255">${account_object.description}</textarea>
        </div>
      </div>

      <div class="col-md-6 col-lg-6 col-sm-12">
        <label class="col-md-5 col-lg-4 col-sm-4 control-label nowrap"><spring:message code="label.gender"/></label>
        <div class="col-md-7 col-lg-8 col-sm-8">
          <select class="form-control w100" data-plugin-selectTwo id="account-gender"
                  name="account-gender" required>
            <option value="0" ${account_object.gender eq 0 ? 'selected' : ''}>Nam</option>
            <option value="1" ${account_object.gender eq 1 ? 'selected' : ''}>Nữ</option>
            <option value="2" ${account_object.gender eq 2 ? 'selected' : ''}>Khác</option>
          </select>
        </div>
      </div>
    </div>
  </div>

  <div class="row">
    <div class="form-group">
      <div class="col-md-6 col-lg-6 col-sm-12">
        <label class="col-md-4 col-lg-4 col-sm-4 control-label nowrap">Địa chỉ hiện tại</label>
        <div class="col-md-7 col-lg-8  col-sm-8">
          <input type="text" id="account-living-address" name="account-living-address"
                 value="${account_object.livingAddress}" class="form-control w100">
        </div>
      </div>

      <div class="col-md-6 col-lg-6 col-sm-12">
        <label class="col-md-5 col-lg-4  col-sm-4 control-label">Địa chỉ khai báo</label>
        <div class="col-md-7 col-lg-8  col-sm-8">
          <c:if
              test="${account_object.addresses ne null && fn:length(account_object.addresses) gt 0 }">
            <c:forEach var="itemAddress" items="${account_object.addresses}">
              <input type="text" id="account-nameAddr" name="account-nameAddr"
                     class="form-control w100" value="${itemAddress.street1}">
            </c:forEach>
          </c:if>
          <c:if test="${account_object.addresses eq null}">
            <input type="text" id="account-nameAddr" name="account-nameAddr"  class="form-control w100" value=""/>
          </c:if>
        </div>
      </div>
    </div>
  </div>

  <div class="row">
    <div class="form-group">
      <div class="col-sm-12 text-right">
        <button class="btn btn-sm btn-success ${'edit' eq edit_type ? '' : 'hidden'}" type="button"
                id="edit_btn" name="edit" onclick="editAccountPersonal()" value="create">
          <i class="fa fa-pencil"></i>&nbsp;<spring:message code="common.btn.edit"/></button>
        <button class="btn btn-sm btn-primary" type="submit" value="save-account-personal"
                name="btn-action" id="btn-save-personal" ${'edit' eq edit_type ? 'disabled' : ''}>
          <i class="fa fa-save"></i>&nbsp;<spring:message code="common.btn.save"/></button>
      </div>
    </div>
  </div>
</div>