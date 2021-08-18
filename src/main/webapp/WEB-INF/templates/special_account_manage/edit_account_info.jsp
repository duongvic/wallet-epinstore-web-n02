<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<spring:message code="label.user.active" var="active_special_merchant"/>
<spring:message code="label.user.inactive" var="inActive_special_merchant"/>

<div class="panel-title">
  <h4 style="margin-bottom: 1.5rem"><spring:message code="system.account.info.page.title"/></h4>

  <div class="panel-tools hidden">
    <sec:authorize
        access="hasAnyRole('ADMIN_OPERATION')">
      <a class="mb-xs mt-xs btn btn-success" style="line-height: 28px"
         href="${contextPath}/provider/special-account/manage/add"><i
          class="fa fa-plus"></i>&nbsp;<spring:message
          code="common.btn.Add"/></a>
    </sec:authorize>
  </div>
</div>
<div class="panel-body">
  <div class="row">
    <div class="form-group">
      <div class="col-md-6 col-lg-6 col-sm-12">
        <spring:message
            code="${account_object.displayName != null ? account_object.displayName : null}"
            var="first_name"/>
        <label class="col-md-4 col-lg-4  col-sm-4 control-label nowrap"><spring:message
            code="lable.last.first.name"/>&nbsp; *</label>
        <div class="col-md-8 col-lg-8  col-sm-8">
          <input class="form-control"
                 pattern="^[^&amp;&gt;&lt;\\*?%:!&quot;#$()+,;=@\[\]{}~\^|`\n\t\r/]+$"
                 required value="${first_name}"
                 type="text" name="displayName" id="displayName"
                 placeholder="Tên">
        </div>
      </div>

      <div class="col-md-6 col-lg-6 col-sm-12  form-group">
        <label class="col-md-4 col-lg-4 col-sm-4 control-label nowrap"><spring:message
            code="setting.account.notification.mode.EMAIL"/>&nbsp;</label>
        <div class="col-md-8 col-lg-8 col-sm-8">
          <div class="input-group" style="width: 100%">
            <input class="form-control"
                   pattern="[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[a-z]{2,3}$"
                   required id="email"
                   value="${account_object.email}"
                   type="text" name="email"
                   placeholder="Thư điện tử">
            <%--<span class="input-group-addon border-input hidden"--%>
            <%--data-toggle="popover"--%>
            <%--data-trigger="hover"--%>
            <%--data-placement="top"--%>
            <%--data-content="${authenticated}">--%>
            <%--<i class="fa fa-lg fa-check-circle text-success"--%>
            <%--aria-hidden="true"></i>--%>
            <%--</span>--%>
          </div>
        </div>
      </div>
    </div>
  </div>

  <div class="row">
    <div class="">
      <div class="col-md-6 col-lg-6 col-sm-12  form-group">
        <label class="col-md-5 col-lg-4 col-sm-4 control-label nowrap"><spring:message
            code="label.phone"/>*</label>
        <div class="col-md-7 col-lg-8 col-sm-8">
          <div class="input-group" style="width: 100%">
            <input class="form-control"
                   pattern="[0-9]{10,11}"
                   required id="phone"
                   value="${account_object.phoneNumber}"
                   type="text" name="phone"
                   placeholder="<spring:message code="label.phone"/>">
          </div>
        </div>
      </div>

      <div class="col-md-6 col-lg-6 col-sm-12 form-group">
        <label class="col-md-5 col-lg-4 col-sm-4 control-label nowrap"
               for="isActive"
               style="min-width: 100px"><spring:message code="label.change.status"/> &nbsp;*</label>
        <div class="col-md-7 col-lg-8 col-sm-8">
          <select data-plugin-selectTwo
                  class="form-control"
                  id="isActive"
                  name="isActive">
            <option value=""><spring:message code="label.please.select"/></option>
            <option
                value="true" ${account_object.isActive eq true ? 'selected' : ''}>${active_special_merchant}
            </option>
            <option
                value="false" ${account_object.isActive eq false ? 'selected' : ''}>${inActive_special_merchant}
            </option>
          </select>
        </div>
      </div>
    </div>
  </div>

  <div class="row">
    <div class="form-group">
      <div class="col-md-6 col-lg-6 col-sm-12">
        <label class="col-md-5 col-lg-4  col-sm-4 control-label">CIF</label>
        <div class="col-md-7 col-lg-8  col-sm-8">
          <input class="${'edit' eq edit_type ? 'form-control' : 'hidden'}"
                 type="text"
                 name="account-id" id="account-id"
                 disabled
                 value="${account_object.cif}">
          <input class="${'edit' eq edit_type ? 'hidden' : 'form-control'}"
                 type="text"
                 name="cif"
                 pattern="[a-zA-Z0-9-_]{10,11}"
                 placeholder="CIF"
                 value="${account_object.cif}">
        </div>
      </div>

      <div class="col-md-6 col-lg-6 col-sm-12 form-group">
        <label class="col-md-5 col-lg-4 col-sm-4 control-label nowrap"
               for="customerType"
               style="min-width: 100px"><spring:message
            code="select.customerType"/>&nbsp;* </label>
        <div class="col-md-7 col-lg-8 col-sm-8">
          <select data-plugin-selectTwo
                  class="form-control"
                  id="customerType"
                  name="customerType">
            <option value=""><spring:message code="label.please.select"/></option>
            <option value="1" ${account_object.customerType eq 1 ? 'selected' : ''}>CUSTOMER</option>
            <option value="3" ${account_object.customerType eq 3 ? 'selected' : ''}>MERCHANT</option>
          </select>
        </div>
      </div>

    </div>
  </div>

  <div class="row">
    <div class="form-group">
      <div class="col-md-6 col-lg-6 col-sm-12">
        <label class="col-md-5 col-lg-4  col-sm-4 control-label">Mô tả </label>
        <div class="col-md-7 col-lg-8  col-sm-8">
          <textarea name="description" id="description" class="form-control" rows="3" cols="3">${account_object.description}</textarea>
        </div>
      </div>
    </div>
  </div>

  <div class="row">
    <div class="form-group">
      <div class="col-sm-12 text-right">
        <button class="btn btn-sm btn-success ${'edit' eq edit_type ? '' : 'hidden'}"
                type="button" id="edit_btn"
                name="edit" onclick="editAccount()"
                value="create"><i
            class="fa fa-pencil"></i> <spring:message code="common.btn.edit"/>
        </button>
        <button class="btn btn-sm btn-primary"
                type="submit" value="save-account-info"
                name="btn-action" id="save_btn"
        ${'edit' eq edit_type ? 'disabled' : ''}><i
            class="fa fa-save"></i>
          <spring:message code="common.btn.save"/>
        </button>
      </div>
    </div>
  </div>
</div>