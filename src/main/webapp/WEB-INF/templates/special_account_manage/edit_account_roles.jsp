<%@ taglib uri="https://processing.function.template/service/jsp/jstl/functions" prefix="ewallet" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://displaytag.sf.net/el" prefix="display" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="panel-title">
  <h4 style="margin-bottom: 1.5rem">Gán vai trò</h4>
  <div class="panel-tools">
    <button class="btn btn-sm btn-primary" type="button"
            data-target="#action-grant-role"
            data-toggle="modal"
            name="grant-role" ${'edit' eq edit_type ? '' : 'disabled'}
            onclick="createRolePrivilegeModal()">
      <i class="fa fa-users"></i> Gán vai trò
    </button>
  </div>
</div>
<div class="panel-body">
  <table class="table table-bordered table-responsive table-striped mb-none"
         id="datatable-role">
    <thead style="line-height: 22px; cursor: pointer;">
    <tr>
      <th width="50">#</th>
      <th>Tên vai trò</th>
      <th>Có hiệu lực từ</th>
      <th> Có hiệu lực đến</th>
      <th>Mô tả</th>
      <th>Thao tác</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${customer_roles}"
               var="customer_role_item"
               varStatus="customer_role_id">
      <tr class="${customer_role_item.id}">
        <td>${customer_role_id.count}</td>
        <td class="roleName">${customer_role_item.role}</td>
        <td class="roleValidFrom"><fmt:formatDate pattern="dd/MM/yyyy" value="${customer_role_item.validFromDate }"/></td>
        <td class="roleValidTo"><fmt:formatDate pattern="dd/MM/yyyy" value="${customer_role_item.validToDate }"/></td>
        <td></td>
        <td>
          <c:if test="${customer_role_item.id != null}">
            <i class="fa fa-2x fa-pencil-square text-success"
               style="cursor: pointer;"
               data-toggle="popover"
               data-trigger="hover"
               data-placement="top"
               data-content="Chỉnh sửa"
               onclick="editCustomerRoleModal('${customer_role_item.id}', this)"
               aria-hidden="true"></i>
            <i class="fa fa-2x fa-trash-o text-danger"
               data-toggle="popover"
               data-trigger="hover"
               data-placement="top"
               data-content="Xóa"
               style="cursor: pointer;"
               onclick="removeCustomerRoleModal('${customer_role_item.id}')"
               aria-hidden="true"></i>
          </c:if>
        </td>
      </tr>
    </c:forEach>
    </tbody>
  </table>
</div>