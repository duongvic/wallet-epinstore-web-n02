<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="panel-title">
  <h4 style="margin-bottom: 1.5rem">Thuộc tính</h4>
  <div class="panel-tools">
    <button class="btn btn-sm btn-primary ${'edit' eq edit_type ? '' : 'hidden'}"
            type="button"
            data-target="#action-show-google-authen"
            data-toggle="modal"
            name="show-google-authen">Hiển thị Google
      Authenticator
    </button>
    <button class="btn btn-sm btn-primary" type="button"
            id="action-add-attribute"
            onclick="addAttribute()"
            name="action-add-attribute" ${'edit' eq edit_type ? '' : 'disabled'}>
      <i class="fa fa-plus"></i> Thêm
    </button>
    <button class="btn btn-sm btn-primary" type="submit"
            value="Save" id="atb-save"
            name="atb-save" ${'edit' eq edit_type ? '' : 'disabled'}>
      <i class="fa fa-save"></i> Lưu
    </button>
    <input type="hidden" id="count-element-atb"
           name="count-element-atb"
           value="${fn:length(customer_attributes)}">
  </div>
</div>
<div class="panel-body">
  <table class="table table-bordered table-responsive table-striped mb-none"
         id="datatable-atb">
    <thead style="line-height: 22px; cursor: pointer;">
    <tr>
      <th width="min-w">#</th>
      <th width="35%">Tên thuộc tính</th>
      <th width="35%">Giá trị</th>
      <th width="30%" class="text-center">Thao tác
      </th>
    </tr>
    </thead>

    <tbody>
    <c:forEach items="${customer_attributes}"
               var="cus_attr"
               varStatus="cus_attr_id">
      <tr>
        <td>${cus_attr_id.count}</td>
        <td>
          <select class="form-control"
                  data-plugin-selectTwo
                  name="accountAttributeId${cus_attr_id.count}"
                  required>
            <c:forEach
                items="${customer_attribute_types}"
                var="cus_attr_types">
              <option value="${cus_attr_types.key}" ${cus_attr_types.key eq cus_attr.customerAttributeTypeId ? 'selected' : ''}>${cus_attr_types.value}</option>
            </c:forEach>
          </select>
        </td>
        <td><input class="form-control"
                   name="accountAttributeValue${cus_attr_id.count}"
                   value="${cus_attr.value}"
                   type="text" required>
        </td>
        <td class="text-center">
          <i class="fa fa-2x fa-trash-o text-danger"
             data-toggle="popover"
             data-trigger="hover"
             data-placement="top"
             data-content="Xóa"
             style="cursor: pointer;"
             onclick="removeAtb('${account_object.id}', '${cus_attr.customerAttributeTypeId}', this)"></i>
        </td>
      </tr>
    </c:forEach>
    </tbody>
  </table>
</div>
<!-- list attribute -->
<div id="list-attribute" class="hidden">
  <select data-plugin-selectTwo class="form-control">
    <c:forEach items="${customer_attribute_types}"
               var="cus_attr_types">
      <option value="${cus_attr_types.key}">${cus_attr_types.value}</option>
    </c:forEach>
  </select>
</div>