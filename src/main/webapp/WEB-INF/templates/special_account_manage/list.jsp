<%@ page language="java" trimDirectiveWhitespaces="true" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="../include_page/taglibs.jsp" %>


<!doctype html>
<html class="fixed" lang="${pageContext.response.locale.language}">

<head>
    <meta charset="UTF-8">
    <title><spring:message code="system.account.list.title.page"/></title>
    <jsp:include page="../include_page/head.jsp">
        <jsp:param name="selectLib" value="true"/>
    </jsp:include>
    <jsp:include page="../include_page/js_service.jsp">
        <jsp:param name="dateLib" value="true"/>
    </jsp:include>
    <script type="text/javascript"
            src="<c:url value='/assets/javascripts/settings-custom.js'/>"></script>
</head>

<spring:message code="label.user.active" var="active_special_merchant"/>
<spring:message code="label.user.inactive" var="inActive_special_merchant"/>
<sec:authorize access="hasAnyRole('ADMIN_OPERATION','SALESUPPORT', 'SALESUPPORT_MANAGER')"
               var="permisAction"/>

<body>
<section class="body">
    <jsp:include page="../include_page/header.jsp"/>

    <div class="inner-wrapper">
        <!-- start: sidebar -->
        <jsp:include page="../include_page/navigation.jsp">
            <jsp:param value="special_customer" name="nav"/>
        </jsp:include>
        <!-- end: sidebar -->
        <section role="main" class="content-body">
            <header class="page-header">
                <div class="row">
                    <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
                        <div class="page-header-left">
                            <ol class="breadcrumbs">
                                <li><a href="#"><i class="fa fa-home"></i></a></li>
                                <li><span class="nav-active"><spring:message
                                        code="system.account.list.navigate.setting.account"/></span>
                                </li>
                                <li><span class=""><spring:message
                                        code="menu.setting.wallet.account.management.list"/></span>
                                </li>
                            </ol>
                        </div>
                    </div>
                </div>
            </header>

            <jsp:include page="../include_page/message_new.jsp"/>

            <!-- start: page -->


            <div class="content-body-wrap">
                <div class="container-fluid">
                    <div class="form-inline">
                        <div class="pull-left h4 mb-md mt-md"><spring:message
                                code="setting.system.wallet.account.list.subnavigate"/></div>
                        <div class="fr form-responsive">
                            <sec:authorize
                                    access="hasAnyRole('ADMIN_OPERATION', 'SALESUPPORT_MANAGER')">
                                <a class="mb-xs mt-xs btn btn-success"
                                   href="${contextPath}/provider/special-account/manage/add"><i
                                        class="fa fa-plus"></i>&nbsp;<spring:message
                                        code="common.btn.Add"/></a>
                            </sec:authorize>
                        </div>
                    </div>

                    <section class="panel search_payment panel-default">
                        <div class="panel-body pt-none">
                            <spring:message code="account.search.placeholder"
                                            var="placeholder"/>
                            <form action="" method="GET" id="tbl-filter">
                                <input type="hidden" name="${_csrf.parameterName}"
                                       value="${_csrf.token}"/>
                                <div class="form-group ml-none mr-none">
                                    <div class="input-group input-group-icon">
                                        <span class="input-group-addon"><span class="icon"
                                                                              style="opacity: 0.4"><i
                                                class="fa fa-search-minus"></i></span></span>
                                        <input type="text" id="quickSearch" name="quickSearch"
                                               class="form-control" placeholder="${placeholder}"
                                               value="${param.quickSearch }"/>
                                    </div>
                                </div>

                                <div class="col-xs-12 col-lg-12 col-md-12 col-sm-12">
                                    <div class="row">
                                        <%--select user type--%>
                                        <div class="col-md-3 col-lg-3">
                                            <div class="form-group">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <label class="control-label nowrap"
                                                               for="isActive"
                                                               style="min-width: 100px">${active_special_merchant}</label>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <select data-plugin-selectTwo
                                                                class="form-control"
                                                                id="isActive"
                                                                name="isActive">
                                                            <option value=""><spring:message
                                                                    code="label.please.select"/></option>
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

                                        <%--select custom type--%>
                                        <div class="col-md-3 col-lg-3">
                                            <div class="form-group">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <label class="control-label nowrap"
                                                               for="customerType"
                                                               style="min-width: 100px"><spring:message
                                                                code="select.customerType"/> </label>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <select data-plugin-selectTwo
                                                                class="form-control"
                                                                id="customerType"
                                                                name="customerType">
                                                            <option value=""><spring:message
                                                                    code="label.please.select"/></option>
                                                            <option
                                                                    value="1" ${account_object.customerType eq 1 ? 'selected' : ''}>
                                                                CUSTOMER
                                                            </option>
                                                            <option
                                                                    value="3" ${account_object.customerType eq 3 ? 'selected' : ''}>
                                                                MERCHANT
                                                            </option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </div>

                                <div class="form-inline">
                                    <div class='pull-right form-responsive bt-plt'>

                                        <button type="button" class="btn btn-primary"
                                                onclick="drawTableAccountList()"><i
                                                class="fa fa-search"></i>&nbsp;<spring:message
                                                code="common.btn.search"/>
                                    </div>

                                </div>
                                <div class="clearfix"></div>

                            </form>

                            <section class="panel search_payment panel-default">
                                <div class="panel-body">
                                    <div class="clearfix"></div>
                                    <div class="pull-left mt-sm" style="line-height: 30px;">
                                    </div>
                                    <div class="clr"></div>

                                    <spring:message var="colStatus"
                                                    code="setting.account.tbl.col.status"/>
                                    <spring:message var="colId"
                                                    code="setting.account.tbl.col.account.id"/>
                                    <spring:message var="colCIF"
                                                    code="setting.account.tbl.col.cif"/>
                                    <spring:message var="colName"
                                                    code="setting.account.tbl.col.full.name"/>
                                    <spring:message var="colPhone"
                                                    code="setting.account.tbl.col.phone"/>
                                    <spring:message var="colCustomerType"
                                                    code="setting.account.tbl.col.customer.type"/>
                                    <spring:message var="colIsActive"
                                                    code="setting.account.tbl.col.isActive"/>
                                    <spring:message var="colCreateTime"
                                                    code="setting.account.tbl.col.created.at"/>
                                    <spring:message var="colAction"
                                                    code="setting.account.tbl.col.action"/>

                                    <spring:message var="actionEdit"
                                                    code="common.btn.edit"/>
                                    <spring:message var="actionDelete"
                                                    code="common.btn.delete"/>
                                    <spring:message var="actionChangeStatus"
                                                    code="account.dialog.change.status"/>
                                    <div class="container-fluid">
                                        <div class="table-responsive">
                                            <table class="table table-bordered table-responsive table-striped mb-none"
                                                   id="acount-list-table">
                                                <thead>
                                                <th>#</th>
                                                <th>${colId}</th>
                                                <th>${colCIF}</th>
                                                <th>${colName}</th>
                                                <th>${colPhone}</th>
                                                <th>${colCustomerType}</th>
                                                <th>${colStatus}</th>
                                                <th>${colAction}</th>
                                                </thead>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </section>
                        </div>
                    </section>
                </div>
            </div>

            <!-- Modal  -->
            <jsp:include page="../include_component/action_change_status_reason.jsp"/>
            <jsp:include page="../include_component/action_remove_special_customer.jsp"/>
            <!-- Modal  -->

            <!-- end: page -->
        </section>
        <jsp:include page="../include_page/footer.jsp"/>

    </div>
</section>
<jsp:include page="../include_page/js_footer.jsp"/>

<spring:message code="data.table.header.paging.showing" var="paging_showing"/>
<spring:message code="data.table.header.paging.to" var="paging_to"/>
<spring:message code="data.table.header.paging.of" var="paging_of"/>
<spring:message code="data.table.header.paging.entries" var="paging_entries"/>
<spring:message code="data.table.header.paging.previous" var="paging_previous"/>
<spring:message code="data.table.header.paging.next" var="paging_next"/>
<spring:message code="data.table.header.paging.records" var="paging_records"/>

<script>
  $(document).ready(function () {
    drawTableAccountList();
  });

  jQuery(window).on("load", function () {
    $('[data-toggle="popover"]').popover();
  });

  function drawTableAccountList() {
    var quickSearch = $('#quickSearch').val();
    var isActive = $('#isActive').val();
    var customerType = $('#customerType').val();

    $('#acount-list-table').dataTable({
      "paging": true,
      "serverSide": true,
      "iDisplayStart": 0,
      "pageLength": 20,
      "lengthMenu": [[10, 20, 50, -1], [10, 20, 50, "All"]],
      "searching": false,
      "columnDefs": [
        {"visible": false, "targets": 1}
      ],
      "language": {
        "sInfo": "${paging_showing} _START_ ${paging_to} _END_ ${paging_of} _TOTAL_ ${paging_entries}",
        "sLengthMenu": "_MENU_ ${paging_records}",
        "paginate": {
          "previous": "${paging_previous}",
          "next": "${paging_next}"
        }
      },
      dom: 'fltip',
      destroy: true,
      "ajax": {
        "url": ctx + "/ajax-controller/customer/find-customers",
        "type": "POST",
        "data": {
          quickSearch: quickSearch,
          isActive: isActive,
          customerType: customerType,
        },
        dataSrc: 'dataList'
      },
      "columns": [
        {
          "data": null,
          "render": function (data, type, full, meta) {
            var index = meta.settings.oAjaxData.start + meta.row + 1;

            return index;
          }
        },

        {
          "data": null,
          "render": function (data, type, full, meta) {
            var htmlCode = ""
                + '<div>' + data.id + '</div>'

            return htmlCode;
          }
        },

        {
          "data": null,
          "render": function (data, type, full, meta) {
            var htmlCode = ""
                + '<div class="customer-' + data.id + '">' + data.cif + '</div>'

            return htmlCode;
          }
        },

        {
          "data": null,
          "render": function (data, type, full, meta) {
            var displayName = data.displayName == null ? "" : data.displayName;
            var index = meta.settings.oAjaxData.start + meta.row + 1;
            var htmlCode = ""
                + "<div class=\"user-info-box\">"
                + " <div class=\"avt\">\n"
                + "    <img src=\"${contextPath}/assets/images/man.svg\"\n"
                + "         class=\"img-circle list-user-avatar\"\n"
                + "         data-id=\"" + index + "\"\n"
                + "         data-toggle=\"modal\">"
                + " </div>"
                + " <div class=\"user-info\">\n"
                + "    <p class=\"user-name\">\n"
                + "        <b>\n"
                + "            <a id=\"customer-link-" + index + "\"\n"
                + "               href=\"${contextPath}/provider/special-account/manage/details/"
                + data.id + "\">\n"
                + "<span class=\"first-name\">" + displayName + "</span>\n"
                + "            </a>\n"
                + "        </b>\n"
                + "    </p>\n"
                + "    <p>" + (data.email == null ? "" : data.email) + "</p>"
                + " </div>"
                + "</div>";

            return htmlCode;
          }
        },

        {"data": "phoneNumber"},

        {
          "data": null,
          "render": function (data, type, full, meta) {
            var customerType = data.customerType;
            switch (customerType) {
              case 1: {
                customerType = "CUSTOMER";
                break;
              }
              case 3: {
                customerType = "MERCHANT";
                break;
              }
              default :
                null
            }

            var htmlCode = ""
                + '<div>' + customerType + '</div>'
            return htmlCode;
          }
        },

        {
          "data": null,
          "render": function (data, type, full, meta) {
            var id = data.id;
            var isActive = data.isActive;
            console.log(isActive);
            var blackListReason = "";
            switch (isActive) {
              case true: {
                blackListReason = "${active_special_merchant}";
                break;
              }
              case false: {
                blackListReason = "${inActive_special_merchant}";
                break;
              }
            }

            var htmlCode = ""
                + "<div id=\"txn-blacklist-reason-" + id + "\" class=\""
                + (true == isActive ? "text-success" : "text-danger")
                + "\">" + blackListReason + "</div>\n"

            return htmlCode;
          }
        },

        {
          "data": null,
          "render": function (data, type, full, meta) {
            var id = data.id;
            var htmlCode = ""
                <c:if test="${permisAction}">
                + "<div style=\"display: inline-flex\">\n"
                + "    <input type=\"hidden\" id=\"user-" + id + "-blackListReason\" value=\""
                + data.isActive + "\">\n"
                + "    <label class=\"switch\" style=\"margin: 0 3px;\"\n"
                + "           data-toggle=\"popover\"\n"
                + "           data-trigger=\"hover\"\n"
                + "           data-placement=\"top\"\n"
                + "           title=\"\"\n"
                + "           data-content=\"${actionChangeStatus}\"\n"
                + "           for=\"chk-blacklist-status-" + data.id + "\">\n"
                + "        <input id=\"chk-blacklist-status-" + data.id + "\"\n"
                + "               type=\"checkbox\" " + (true == data.isActive ? 'checked' : '')
                + "\n"
                + "               onclick=\"return changeStatusAccount(" + id + ","
                + data.isActive + ")\">\n"
                + "        <span class=\"slider round\"></span>\n"
                + "    </label>\n"

                + "    <a href=\"${contextPath}/provider/special-account/manage/details/" + id
                + "\"\n"
                + "       data-toggle=\"popover\"\n"
                + "       data-trigger=\"hover\"\n"
                + "       data-placement=\"top\"\n"
                + "       title=\"\"\n"
                + "       data-content=\"${actionEdit}\"\n"
                + "           style=\"vertical-align: middle;\"><i\n"
                + "                class=\"fa fa-2x fa-pencil-square\"\n"
                + "                style=\"padding-left: 10px; color: DodgerBlue \"></i>\n"
                + "    </a>\n"

                + '<a onclick="removeSpecialCustomer(' + id + ')"\n'
                + '                           data-toggle="popover"\n'
                + '                           data-trigger="hover"\n'
                + '                           data-placement="top"\n'
                + '                           title=""\n'
                + '                           data-content="${actionDelete}"\n'
                + '                           style="vertical-align: middle;"><i\n'
                + '                            class="fa fa-2x fa-trash-o"\n'
                + '                            style="padding-left: 10px; color: red"></i>\n'
                + '                        </a>'

                + "</div>";
            </c:if>
            return htmlCode;
          }
        }
      ]
    });
  }
</script>
</body>
</html>
