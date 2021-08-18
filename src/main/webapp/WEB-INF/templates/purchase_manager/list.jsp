<%@ page import="vn.mog.ewallet.web.controller.dashboard.beans.CardStatus" %>
<%@ page import="vn.mog.ewallet.web.controller.po.beans.WorkflowState" %>
<%@ page import="vn.mog.ewallet.web.controller.dashboard.beans.UpType" %>
<%@ page
    import="static vn.mog.ewallet.constant.SharedConstants.MENU_ITEM_SHOW_CARD_STORE_OFF_LINE" %>
<%@ page language="java" trimDirectiveWhitespaces="true" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="../include_page/taglibs.jsp" %>


<!doctype html>
<html class="fixed" lang="${pageContext.response.locale.language}">
<c:set var="locale" value="${pageContext.response.locale}"/>

<head>
  <!-- Basic -->
  <meta charset="UTF-8">
  <title><spring:message code="purchase.order.list.title.page"/></title>
  <jsp:include page="../include_page/head.jsp">
    <jsp:param name="dateLib" value="true"/>
    <jsp:param name="switchLib" value="true"/>
  </jsp:include>
  <style type="text/css">
    .col-stage {
      min-width: 120px !important;
    }
  </style>
  <jsp:include page="../include_page/js.jsp">
    <jsp:param name="tableLib" value="true"/>
    <jsp:param name="dateLib" value="true"/>
    <jsp:param name="switchLib" value="true"/>
  </jsp:include>
</head>

<body>
<section class="body">
  <c:set var="MENU_ITEM_SHOW_CARD_STORE_OFF_LINE" value="<%=MENU_ITEM_SHOW_CARD_STORE_OFF_LINE%>"/>

  <jsp:include page="../include_page/header.jsp"/>

  <div class="inner-wrapper">

    <!-- start: sidebar -->
    <jsp:include page="../include_page/navigation.jsp">
      <jsp:param value="purchase_order" name="nav"/>
    </jsp:include>
    <!-- end: sidebar -->

    <section role="main" class="content-body">
      <%--head content--%>
      <header class="page-header">
        <div class="row">
          <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
            <div class="page-header-left">
              <ol class="breadcrumbs">
                <li><a href="#"><i class="fa fa-home"></i></a></li>
                <li><span><spring:message code="header.card.store.special"/></span></li>
                <li><span class="nav-active"><spring:message code="common.purchase.order"/></span>
                </li>
              </ol>
            </div>
          </div>
        </div>
      </header>
      <%--End head content--%>

      <jsp:include page="../include_page/message.jsp"/>

      <!-- start: page -->

      <div class="content-body-wrap">

        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 pl-none">
          <div class="page-header-left header-title"><spring:message
              code="common.purchase.order"/></div>

          <div class="fr form-responsive">
            <sec:authorize access="hasAnyRole('ADMIN_OPERATION','SALESUPPORT', 'SALESUPPORT_MANAGER' )">
              <a href="add" class="btn mb-xs mt-xs btn-success"><i
                  class="fa fa-plus"></i>&nbsp;<spring:message code="common.btn.createPO"/></a>
            </sec:authorize>
          </div>
        </div>

        <div class="tabs">
          <ul class="nav nav-tabs">
            <li><a href="<%=request.getContextPath()%>/provider/card-manager/list"><spring:message
                code="common.title.card.item"/></a></li>
            <li class="active"><a href="#tab2" data-toggle="tab"><spring:message
                code="common.purchase.order"/></a></li>
          </ul>

          <div class="tab-content">
            <div id="tab1" class="tab-pane active">
              <section class="panel search_payment panel-default">
                <div class="panel-body">
                  <form action="" method="GET" id="tbl-filter">
                    <div class="col-md-12 mb-none p-none" style="height: 36px;top: -15px;">
                      <div class="input-group" style="width: 100%">
                        <input type="text" id="search" name="id" class="form-control"
                               style="height: 36px"
                               placeholder="<spring:message code="common.title.quick.search.by.PO"/> "
                               value="${param.id }"/>
                      </div>
                    </div>
                    <div class="clr"></div>

                    <div class="form-inline">
                      <jsp:include page="../include_component/date_range.jsp"/>

                      <div class="pull-right form-responsive bt-plt">
                        <select id="specialCard" name="specialCard" class="form-control specialCard">
                          <option value=""><spring:message code="common.select.special.card"/></option>
                          <option value="0" ${'0' eq specialCard ? 'selected' : ''}><spring:message code="common.special.card.general"/></option>
                          <option value="1" ${'1' eq specialCard ? 'selected' : ''}><spring:message code="common.special.card.private"/></option>
                        </select>

                        <select id="specialCustomer" name="specialCustomer" class="form-control  specialCustomer" multiple="multiple" disabled='disabled'>
                          <c:set var="string1" value="("/>
                          <c:set var="string2" value=")"/>
                          <c:forEach var="item" items="${specialCustomers}">
                            <c:set var="selected" value=""/>
                            <c:forEach var="speCusomter" items="${paramValues.specialCustomer }">
                              <c:if test="${speCusomter eq item.cif }">
                                <c:set var="selected" value="selected"/>
                              </c:if>
                            </c:forEach>
                            <option ${selected } value="${item.cif }">${string1.concat(item.phoneNumber).concat(string2).concat(' ').concat(item.displayName)}</option>
                          </c:forEach>

                        </select>

                        <%--type PO  --%>
                        <%-- <c:if test="${'true' eq MENU_ITEM_SHOW_CARD_STORE_OFF_LINE}">
                           <c:set var="allTypePO" value=","/>
                           <c:forEach var="st" items="${paramValues.poTypes}">
                             <c:set var="allTypePO" value="${allTypePO}${st},"/>
                           </c:forEach>
                           <c:set var="listUpType" value="<%= UpType.values() %>"/>
                           <select class="form-control hidden" name="poTypes" multiple="multiple" id="poType">
                             <c:forEach var="item" items="${listUpType }">
                               <c:set var="typePO" value=",${item.code},"/>
                               <option ${fn:contains(allTypePO, typePO)?'selected':'' } value="${item.code}">
                                 <spring:message code="${item.getName()}"/>
                               </option>
                             </c:forEach>
                           </select>
                         </c:if>--%>
                        <%--end--%>

                        <select class="form-control" name="provider" multiple="multiple"
                                id="provider">
                          <c:forEach var="item" items="${listProvider }">
                            <c:set var="selected" value=""/>
                            <c:forEach var="prvd" items="${paramValues.provider }">
                              <c:if test="${prvd eq item.code }">
                                <c:set var="selected" value="selected"/>
                              </c:if>
                            </c:forEach>
                            <option ${selected } value="${item.code }">${item.name }</option>
                          </c:forEach>
                        </select>
                        <script type="text/javascript">
                          $('#provider').multiselect({
                            /*enableFiltering: true,*/
                            includeSelectAllOption: true,
                            selectAllValue: '',
                            selectAllText: '<spring:message code="common.select.choose.all"/>',
                            maxHeight: 400,
                            dropUp: true,
                            nonSelectedText: '<spring:message code="common.select.provider"/>',
                            inheritClass: true,
                            numberDisplayed: 1
                          });
                        </script>

                        <c:set var="listWorkflow" value="<%= WorkflowState.values() %>"/>
                        <select class="form-control" name="workflowState" multiple="multiple"
                                id="workflowState">
                          <c:forEach var="item" items="${listWorkflow }">
                            <c:set var="selected" value=""/>
                            <c:forEach var="wfs" items="${paramValues.workflowState }">
                              <c:if test="${wfs eq item.value()}">
                                <c:set var="selected" value="selected"/>
                              </c:if>
                            </c:forEach>
                            <option ${selected } value="${item.value() }">
                              <spring:message code="${item.displayText()}"/>
                            </option>
                          </c:forEach>
                        </select>
                        <script type="text/javascript">
                          $('#workflowState').multiselect({
                            /*enableFiltering: true,*/
                            includeSelectAllOption: true,
                            selectAllValue: '',
                            selectAllText: '<spring:message code="common.select.choose.all"/>',
                            maxHeight: 400,
                            dropUp: true,
                            nonSelectedText: '<spring:message code="common.select.state.PO"/>',
                            inheritClass: true,
                            numberDisplayed: 1
                          });
                        </script>

                        <c:set var="NEAR_EXP" value="<%=CardStatus.NEAR_EXP.code%>"/>
                        <c:set var="listStatus" value="<%= CardStatus.values()%>"/>
                        <select class="form-control" name="status" multiple="multiple"
                                id="sl-status">
                          <c:forEach var="item" items="${listStatus }">
                            <c:if test="${item.code ne NEAR_EXP}">
                              <c:set var="selected" value=""/>
                              <c:forEach var="ss" items="${paramValues.status }">
                                <c:if test="${ss eq item.code }">
                                  <c:set var="selected" value="selected"/>
                                </c:if>
                              </c:forEach>
                              <option ${selected } value="${item.code}">
                                <spring:message code="${item.getName()}"/>
                              </option>
                            </c:if>
                          </c:forEach>
                        </select>
                        <script type="text/javascript">
                          $('#sl-status').multiselect({
                            /*enableFiltering: true,*/
                            includeSelectAllOption: true,
                            selectAllValue: '',
                            selectAllText: '<spring:message code="common.select.choose.all"/>',
                            maxHeight: 400,
                            dropUp: true,
                            nonSelectedText: '<spring:message code="common.select.status"/>',
                            inheritClass: true,
                            numberDisplayed: 1
                          });
                        </script>
                        <button type="submit" class="btn btn-primary btn-sm"><i
                            class="fa fa-search"></i>&nbsp;<spring:message
                            code="common.btn.search"/></button>
                        <a href="?" class="btn btn-default nomal_color_bk bt-cancel"><spring:message
                            code="common.btn.cancel"/> </a>
                      </div>
                    </div>
                  </form>
                  <div class="clearfix"></div>

                  <c:if test="${total > 0}">
                    <h4 style="font-size: 13px;" class="mt-sm">
                      <spring:message code="common.title.total.card"/>&nbsp;<span
                        class="primary_color text-semibold">${ewallet:formatNumber(totalOfCards)}</span>
                      |
                      <spring:message code="common.title.total.face.value"/>&nbsp;<span
                        class="primary_color text-semibold">${ewallet:formatNumber(totalOfMoney)} VND </span>
                      |
                      <spring:message code="common.title.total.capital.value"/>&nbsp;<span
                        class="primary_color text-semibold">${ewallet:formatNumber(totalOfCapital)} VND </span>
                    </h4>
                  </c:if>

                  <sec:authorize access="hasAnyRole('ADMIN_OPERATION', 'SALESUPPORT','SALESUPPORT_MANAGER')"
                                 var="permisDeclarPo"/>
                  <sec:authorize
                      access="hasAnyRole('ADMIN_OPERATION','SALESUPPORT_MANAGER', 'FINANCE','FINANCESUPPORT_LEADER','FA_MANAGER')"
                      var="permisVerifyPo"/>
                  <sec:authorize access="hasAnyRole('ADMIN_OPERATION','SALESUPPORT_MANAGER', 'FINANCESUPPORT_LEADER','FA_MANAGER')"
                                 var="perActivePo"/>


                  <spring:message var="colStt" code="purchase.table.no"/>
                  <spring:message var="colCode" code="purchase.table.code"/>
                  <spring:message var="colTypeWarehouse" code="purchase.table.type.warehouse"/>
                  <spring:message var="colTypePO" code="purchase.table.type.PO"/>
                  <spring:message var="colPO" code="purchase.table.PO"/>
                  <spring:message var="colProvider" code="purchase.table.provider"/>
                  <spring:message var="colQuantity" code="purchase.table.col.quantity"/>
                  <spring:message var="colFaceValue" code="purchase.table.face.value"/>
                  <spring:message var="colCapitalValue" code="purchase.table.capital.value"/>
                  <spring:message var="colStage" code="purchase.table.stage"/>
                  <spring:message var="colCreateDate" code="purchase.table.create.date"/>
                  <spring:message var="colStatus" code="purchase.table.status"/>
                  <spring:message var="colAction" code="purchase.table.action"/>

                  <display:table name="list" id="list"
                                 requestURI="list"
                                 pagesize="${pagesize}" partialList="true" size="total"
                                 class="table table-bordered table-striped mb-none"
                                 sort="list">
                    <%@ include file="../include_page/display_table.jsp" %>

                    <display:column title="${colStt}" headerClass="transhead fit_to_content"
                                    class="transdata right">
                      <span id="row${list.id}" class="rowid">
                        <c:out value="${offset + list_rowNum }"/>
                        <fmt:formatDate var="creationDate" value="${list.creationDate}"
                                        pattern="HH:mm dd-MM-yyyy"/>
                      </span>
                    </display:column>

                    <display:column title="${colCode}" property="poCode"/>
                    <%-- <c:if test="${'true' eq MENU_ITEM_SHOW_CARD_STORE_OFF_LINE}">
                       <display:column title="${colTypePO}">
                         <spring:message code="${list.displayTextUpType(list.upType)}"/>
                       </display:column>
                     </c:if>--%>
                    <display:column title="${colTypeWarehouse}">
                      <c:if test="${list.isPrivate eq false}">
                        <spring:message code="common.special.card.general"></spring:message>
                      </c:if>
                      <c:if test="${list.isPrivate eq true}">
                        <spring:message code="common.special.card.private"></spring:message>
                      </c:if>
                    </display:column>

                    <display:column title="${colProvider}"><a>${list.provider}</a></display:column>
                    <display:column title="${colFaceValue}" headerClass="col-number-header"
                                    class="col-number-header">${ewallet:formatNumber(list.totalValue)}</display:column>
                    <display:column title="${colQuantity}" headerClass="col-number-header"
                                    class="col-number-header">${ewallet:formatNumber(list.totalQuantity)}</display:column>
                    <display:column title="${colCapitalValue}" headerClass="col-number-header"
                                    class="col-number-header">${ewallet:formatNumber(list.capitalValue)}</display:column>
                    <display:column title="${colStage}" headerClass="col-stage center"
                                    class="center">
                      <c:if test="${list.workflowState == 'INIT'}">

                        <c:choose>
                          <c:when test="${permisDeclarPo}">
                            <c:choose>
                              <c:when test="${fn:length(list.specialCustomerList) gt 0}">
                                <c:set var="specialCustomerName" value=" | "/>
                                <c:forEach items="${list.specialCustomerList}" var="specialCustomer">
                                    <div class="hidden">
                                        ${specialCustomerName = specialCustomerName.concat(specialCustomer.cif).concat("-").concat(specialCustomer.displayName).concat(" | ")}
                                    </div>
                                </c:forEach>
                              </c:when>
                              <c:otherwise>
                                <c:set var="specialCustomerName" value=""/>
                                <div class="hidden">
                                    ${specialCustomerName}
                                </div>
                              </c:otherwise>
                            </c:choose>

                            <a href="#" title="<spring:message code="common.title.declared.PO"/>"
                               data-toggle="modal" data-target="#ready-verify" class="link-verify"
                               workflow="${list.workflowState }"
                               poid="${list.id }" provider="${list.provider }"
                               card-am="${list.totalValue }"
                               total-am="${list.totalQuantity }" time="${creationDate }"
                               files="${list.filePath }" note="${list.note }"
                               status="${list.status }" pocode="${list.poCode }"
                               special-customer="${specialCustomerName}"
                               is-private = "${list.isPrivate}">
                              <i class="fa fa-warning warning_status"></i>
                            </a>
                          </c:when>
                          <c:otherwise>
                            <a href="#" class="not-role"
                               title="<spring:message code="common.title.declared.PO"/>"><i
                                class="fa fa-warning warning_status"></i></a>
                          </c:otherwise>
                        </c:choose>
                        <a class="status_number">1</a>
                        <a class="status_number">2</a>
                        <a class="status_number">3</a>
                        <a class="status_number">4</a>
                      </c:if>

                      <c:if test="${list.workflowState == 'REJECTED'}">
                        <a title="<spring:message code="common.title.approved"/>"><i
                            class="fa fa-check check_status"></i></a>
                        <c:choose>
                          <c:when test="${permisDeclarPo}">
                            <c:choose>
                              <c:when test="${fn:length(list.specialCustomerList) gt 0 }">
                                <c:set var="specialCustomerName1" value=" | "/>
                                <c:forEach items="${list.specialCustomerList}" var="specialCustomer1">
                                  <div class="hidden">
                                      ${specialCustomerName1 = specialCustomerName1.concat(specialCustomer1.cif).concat("-").concat(specialCustomer1.displayName).concat(" | ")}
                                  </div>
                                </c:forEach>
                              </c:when>
                              <c:otherwise>
                                <c:set var="specialCustomerName1" value=""/>
                                <div class="hidden">
                                    ${specialCustomerName1}
                                </div>
                              </c:otherwise>
                            </c:choose>
                            <a href="#"
                               title="<spring:message code="common.rejected.pl.edit.the.declaration.of.information.or.suggest.a.revision"/>"
                               data-toggle="modal" data-target="#ready-verify" class="link-verify"
                               workflow="${list.workflowState }"
                               poid="${list.id }" provider="${list.provider }"
                               card-am="${list.totalValue }"
                               total-am="${list.totalQuantity }" time="${creationDate }"
                               files="${list.filePath }" note="${list.note }"
                               status="${list.status }" pocode="${list.poCode }"
                               special-customer="${specialCustomerName1}"
                               is-private = "${list.isPrivate}">
                              <i class="fa fa-times reject_status"></i>

                            </a>
                          </c:when>
                          <c:otherwise>
                            <a href="#"
                               title="<spring:message code="common.rejected.pl.edit.the.declaration.of.information.or.suggest.a.revision"/>"
                               class="not-role"><i class="fa fa-warning reject_status"></i></a>
                          </c:otherwise>
                        </c:choose>

                        <a class="status_number">2</a>
                        <a class="status_number">3</a>
                        <a class="status_number">4</a>
                      </c:if>

                      <c:if test="${list.workflowState == 'READY_TO_VERIFY'}">
                        <a title="<spring:message code="common.title.approved"/>"><i
                            class="fa fa-check check_status"></i></a>
                        <a class="status_number" title="">1</a>

                        <c:choose>
                          <c:when test="${permisVerifyPo}">
                            <a href="verify?id=${list.id}&poCode=${list.poCode}"
                               title="<spring:message code="purchase.list.table.col.stage.waiting.approval"/>"><i
                                class="fa fa-warning warning_status"></i></a>
                          </c:when>
                          <c:otherwise>
                            <a href="#"
                               title="<spring:message code="purchase.list.table.col.stage.waiting.approval"/>"
                               class="not-role"><i class="fa fa-warning warning_status"></i></a>
                          </c:otherwise>
                        </c:choose>

                        <a class="status_number">3</a>
                        <a class="status_number">4</a>
                      </c:if>

                      <c:if test="${list.workflowState == 'CONFIRMED'}">
                        <a title="<spring:message code="common.title.approved"/>"><i
                            class="fa fa-check check_status"></i></a>
                        <a class="status_number">1</a>
                        <a title="<spring:message code="common.title.uploaded"/> "><i
                            class="fa fa-check check_status"></i></a>
                        <a class="status_number">3</a>
                        <a title="đã xác nhận"><i class="fa fa-check check_status"></i></a>
                      </c:if>
                    </display:column>

                    <display:column title="${colCreateDate}">
                      ${creationDate }
                    </display:column>

                    <display:column title="${colStatus}" headerClass="center" class="sw center">
                      <c:choose>
                        <c:when test="${perActivePo}">
                          <c:choose>
                          <c:when test="${fn:length(list.specialCustomerList) gt 0 }">
                            <c:set var="specialCustomerName2" value=" | "/>
                            <c:forEach items="${list.specialCustomerList}" var="specialCustomer2">
                              <div class="hidden">
                                  ${specialCustomerName2 = specialCustomerName2.concat(specialCustomer2.cif).concat("-").concat(specialCustomer2.displayName).concat(" | ")}
                              </div>
                            </c:forEach>
                          </c:when>
                          <c:otherwise>
                            <c:set var="specialCustomerName2" value=""/>
                            <div class="hidden">
                                ${specialCustomerName2}
                            </div>
                          </c:otherwise>
                        </c:choose>

                          <c:choose>
                            <c:when test="${list.status == 'INACTIVE'}">
                              <div class="switch switch-sm switch-success">
                                <input type="checkbox" name="switch" value="${list.id }"
                                       id="ck_${list.id }"/>
                                <a href="#" data-toggle="modal" data-target="#status"
                                   class="switchery-mask"
                                   poid="${list.id }" provider="${list.provider }"
                                   card-am="${list.totalValue }"
                                   total-am="${list.totalQuantity }" time="${creationDate }"
                                   note="${list.note }"
                                   status="${list.status }" pocode="${list.poCode }"
                                   files="${list.filePath }"
                                   special-customer="${specialCustomerName2}"
                                   is-private = "${list.isPrivate}">
                                </a>
                              </div>
                            </c:when>
                            <c:when test="${list.status == 'ACTIVE'}">
                              <div class="switch switch-sm switch-success">
                                <input type="checkbox" name="switch" checked value="${list.id }"
                                       id="ck_${list.id }"/>
                                <a href="#" data-toggle="modal" data-target="#status"
                                   class="switchery-mask"
                                   poid="${list.id }" provider="${list.provider }"
                                   card-am="${list.totalValue }"
                                   total-am="${list.totalQuantity }" time="${creationDate }"
                                   note="${list.note }"
                                   status="${list.status }" pocode="${list.poCode }"
                                   files="${list.filePath }"
                                   special-customer="${specialCustomerName2}"
                                   is-private = "${list.isPrivate}">
                                </a>
                              </div>
                            </c:when>
                            <c:otherwise>
                              <div class="switch switch-sm switch-success">
                                <input type="checkbox" name="switch" disabled value="${list.id }"
                                       id="ck_${list.id }"/>
                                <a href="javascript:;"></a>
                              </div>
                            </c:otherwise>
                          </c:choose>
                        </c:when>
                        <c:otherwise>
                          <c:choose>
                            <c:when test="${list.status == 'ACTIVE'}">
                              <div class="switch switch-sm switch-success">
                                <input type="checkbox" name="switch" checked disabled
                                       value="${list.id }" id="ck_${list.id }"/>
                                <a href="javascript:;"></a>
                              </div>
                            </c:when>
                            <c:otherwise>
                              <div class="switch switch-sm switch-success">
                                <input type="checkbox" name="switch" disabled value="${list.id }"
                                       id="ck_${list.id }"/>
                                <a href="javascript:;"></a>
                              </div>
                            </c:otherwise>
                          </c:choose>
                        </c:otherwise>
                      </c:choose>
                    </display:column>

                    <display:column title="${colAction}" class="action_icon center"
                                    headerClass="center">
                      <c:if
                          test="${list.workflowState == 'CONFIRMED' || list.workflowState == 'READY_TO_VERIFY'}">
                        <a href="#" class="not-role"
                           title="<spring:message code="common.title.edit"/>"> <i
                            class="fa fa-pencil-square-o"></i> </a>
                      </c:if>
                      <c:if
                          test="${list.workflowState != 'CONFIRMED' && list.workflowState != 'READY_TO_VERIFY'}">
                        <sec:authorize access="hasAnyRole('ADMIN_OPERATION', 'SALESUPPORT','SALESUPPORT_MANAGER')"
                                       var="perEditPo"/>
                        <c:choose>
                          <c:when test="${perEditPo}">
                            <a href="edit?id=${list.id }"
                               title="<spring:message code="common.title.edit"/>"><i
                                class="fa fa-pencil-square-o"></i></a>
                          </c:when>
                          <c:otherwise>
                            <a href="#" class="not-role"
                               title="<spring:message code="common.title.edit"/>"><i
                                class="fa fa-pencil-square-o"></i></a>
                          </c:otherwise>
                        </c:choose>
                      </c:if>

                      <c:choose>
                        <c:when test="${fn:length(list.specialCustomerList) gt 0 }">
                          <c:set var="specialCustomerName3" value=" | "/>
                          <c:forEach items="${list.specialCustomerList}" var="specialCustomer3">
                            <div class="hidden">
                                ${specialCustomerName3 = specialCustomerName3.concat(specialCustomer3.cif).concat("-").concat(specialCustomer3.displayName).concat(" | ")}
                            </div>
                          </c:forEach>
                        </c:when>
                        <c:otherwise>
                          <c:set var="specialCustomerName3" value=""/>
                          <div class="hidden">
                              ${specialCustomerName3}
                          </div>
                        </c:otherwise>
                      </c:choose>
                      <a href="#" title="<spring:message code="common.title.detail"/>"
                         class="detail-link"
                         data-toggle="modal" data-target="#detail"
                         poid="${list.id }"
                         special-customer="${specialCustomerName3}"
                         is-private = "${list.isPrivate}">
                        <i class="fa fa-info-circle"></i>
                      </a>

                      <c:if test="${list.status == 'INACTIVE'}">
                        <a href="#" title="tranfer"
                           class="transfer-po" data-toggle="modal" data-target="#transfer"
                           poid="${list.id }" provider="${list.provider }"
                           card-am="${list.totalValue }"
                           total-am="${list.totalQuantity }" time="${creationDate }"
                           note="${list.note }"
                           status="${list.status }" pocode="${list.poCode }"
                           files="${list.filePath }"
                           special-customer="${list.specialCustomerCifList }"
                           is-private = "${list.isPrivate}">
                          <i class="fa fa-retweet" style="color: #2582c4"></i>
                        </a>

                      </c:if>
                    </display:column>
                  </display:table>
                </div>
              </section>
            </div>
            <div id="tab2" class="tab-pane"></div>
          </div>
        </div>

      </div>
      <!-- end: page -->
    </section>
    <jsp:include page="../include_page/footer.jsp"/>
  </div>
</section>
<jsp:include page="purchase_active.jsp"/>
<jsp:include page="purchase_verify.jsp"/>
<jsp:include page="purchase_detail.jsp"/>
<jsp:include page="purchase_transfer.jsp"/>


<jsp:include page="../include_page/js_footer.jsp"/>
<jsp:include page="../include_page/date_picker.jsp">
  <jsp:param name="isFullTime" value="false"/>
  <jsp:param name="isFilter" value="true"/>
</jsp:include>

<script type="text/javascript">

  $('#poType').multiselect({
    includeSelectAllOption: true,
    selectAllValue: '',
    selectAllText: '<spring:message code="common.select.choose.all"/>',
    maxHeight: 400,
    dropUp: true,
    nonSelectedText: '<spring:message code="common.select.type.PO"/>',
    inheritClass: true,
    numberDisplayed: 1
  });

  $('.specialCustomer').multiselect({
    enableFiltering: true,
    includeSelectAllOption: false,
    selectAllValue: '',
    selectAllText: '<spring:message code="common.select.choose.all"/>',
    maxHeight: 400,
    dropUp: true,
    nonSelectedText: '<spring:message code="common.select.special.customer"/>',
    inheritClass: false,
    numberDisplayed: 1,
    buttonContainer: '<div class="btn-group" id="specialCustomer" />'
  });

  $('#specialCustomer1').multiselect({
    enableFiltering: true,
    includeSelectAllOption: true,
    selectAllValue: '',
    selectAllText: '<spring:message code="select.choose.all"/>',
    maxHeight: 150,
    dropUp: true,
    nonSelectedText: '<spring:message code="po.select.special.customer"/>',
    inheritClass: true,
    numberDisplayed: 10
  });

  $(document).ready(function () {
    $('input[name=ckSpecialCard]').attr('checked', false);
    var specialCard = $('#specialCard').val();
    if(specialCard==='1'){
      $('#specialCustomer').prop('disabled', false);
      $('div#specialCustomer button[type=button]').prop('disabled', false).removeClass('disabled');
    }else{
      $('#specialCustomer').prop('disabled', true);
      $('div#specialCustomer button[type=button]').prop('disabled', true).addClass('disabled');
    }


    $('#specialCard').on('change', function() {
      if (this.value === '1') {
        $('#specialCustomer').prop('disabled', false);
        $('div#specialCustomer button[type=button]').prop('disabled', false).removeClass('disabled');
      } else {
        $('#specialCustomer').prop('disabled', true);
        $('div#specialCustomer button[type=button]').prop('disabled', true).addClass('disabled');
      }
    });

    $('table#list').dataTable({
      "paginate": false,
      "sort": true,
      "searching": false,
      "autoWidth": true
    });

    $('.switch input[name=switch]').each(function () {
      var item = document.querySelector('#' + $(this).attr('id'));
      var color = '#64bd63';
      var switchery = new Switchery(item, {color: color, size: 'small'});
      if ($(this).disabled)
        switchery.disable();
    });
    $('a.switchery-mask').click(function () {
      ResetAll('status');
      $('form[name=status] input[name=poid]').val($(this).attr("poid"));
      $('form[name=status] .po-number').html($(this).attr("pocode"));
      $('form[name=status] .provider').html($(this).attr("provider"));
      $('form[name=status] .card-am').html(formatNumberSeparator($(this).attr("card-am"), ''));
      $('form[name=status] .total-am').html(formatNumberSeparator($(this).attr("total-am"), ''));
      $('form[name=status] .time').html($(this).attr("time"));
      $('form[name=status] .special-customer').html($(this).attr("special-customer"));
      $('form[name=status] .is-private').html($(this).attr("is-private"));

      $('input[name=poCode]').val($(this).attr("pocode"));
      var status = $(this).attr("status");
      if (status == 'INACTIVE') {
        $('form[name=status] .btnInactive').hide();
        $('form[name=status] .btnActive').show();
        $('form[name=status] input[name=action]').val('ACTIVE');
      } else if (status == 'ACTIVE') {
        $('form[name=status] .btnActive').hide();
        $('form[name=status] .btnInactive').show();
        $('form[name=status] input[name=action]').val('INACTIVE');
      } else {
        $('form[name=status] input[name=action]').val('');
      }
      var note = ($(this).attr("note")).split("<=");
      note.forEach(function (value) {
        if (value != null && value != 'null')
          $('form[name=status] .note').append('<p class="primary_color">' + value + '</p>');
      });
      var files = $(this).attr("files");
      if (files != null && files.length > 0) {
        var listFile = files.split(':');
        listFile.forEach(function (value) {
          if (value.length > 0)
            $('form[name=status] .files').append('<p class="primary_color note">' + value + '</p>');
        });
      } else {
        $('form[name=status] .files').append('<p class="primary_color note">Chưa có file!</p>');
      }
    });
    $('a.link-verify').click(function () {
      ResetAll('ready-verify');
      $('form[name=ready-verify] input[name=poid]').val($(this).attr("poid"));
      $('form[name=ready-verify] input[name=action]').val($(this).attr("workflow"));
      $('form[name=ready-verify] .po-number').html($(this).attr("pocode"));
      $('form[name=ready-verify] .provider').html($(this).attr("provider"));
      $('form[name=ready-verify] .card-am').html(
          formatNumberSeparator($(this).attr("card-am"), ''));
      $('form[name=ready-verify] .total-am').html(
          formatNumberSeparator($(this).attr("total-am"), ''));
      $('form[name=ready-verify] .time').html($(this).attr("time"));
      $('form[name=ready-verify] .special-customer').html($(this).attr("special-customer"));
      $('form[name=ready-verify] .is-private').html($(this).attr("is-private"));

      var note = ($(this).attr("note")).split("<=");
      note.forEach(function (value) {
        if (value != null && value != 'null')
          $('form[name=ready-verify] .note').append('<p class="primary_color">' + value + '</p>');
      });
      var files = $(this).attr("files");
      if (files.length > 0) {
        var listFile = files.split(':');
        listFile.forEach(function (value) {
          if (value.length > 0)
            $('form[name=ready-verify] .files').append('<p class="primary_color note">' + value
                + '</p>');
        });
      } else {
        $('form[name=ready-verify] .files').append(
            '<p class="primary_color note"><spring:message code="common.title.no.file"/> </p>');
      }
    });
    $('a.detail-link').click(function () {
      ResetAll('detail');
      $('form[name=detail] input[name=poid]').val($(this).attr("poid"));
      $('form[name=detail] .special-customer').html($(this).attr("special-customer"));
      $('form[name=detail] .is-private').html($(this).attr("is-private"));
      $.post($('form[name=detail]').attr('action'),
          $('form[name=detail]').serialize(), function (json) {
            if (json.status.code == 0) {
              var poItem = json.purchaseOrder;
              var date = new Date(poItem.creationDate);
              var capitalValue = poItem.capitalValue;
              if (capitalValue == null || capitalValue == '') capitalValue = poItem.totalValue
                  * poItem.totalQuantity;
              var creationDate = date.getHours() + ":" + date.getMinutes() + " " + date.getDate()
                  + '/' + (date.getMonth() + 1) + '/' + date.getFullYear();
              $('form[name=detail] .po-number').html(poItem.poCode);
              $('form[name=detail] .provider').html(poItem.provider);
              $('form[name=detail] .card-am').html(
                  formatNumberSeparator(poItem.totalValue.toLocaleString('de-DE'), ''));
              $('form[name=detail] .total-am').html(
                  formatNumberSeparator(poItem.totalQuantity.toLocaleString('de-DE'), ''));
              $('form[name=detail] .total-cc').html(
                  formatNumberSeparator(capitalValue.toLocaleString('de-DE'), ''));
              $('form[name=detail] .time').html(creationDate);
              $('form[name=detail] .status').html(poItem.status);

              if (poItem.note != null && poItem.note.trim().length > 0) {
                var note = (poItem.note).split("<=");
                note.forEach(function (value) {
                  if (value != null && value != 'null')
                    $('form[name=detail] .note').append('<p class="primary_color">' + value
                        + '</p>');
                });
              }
              var files = poItem.filePath;
              if (files != null && files.length > 0) {
                var listFile = files.split(':');
                listFile.forEach(function (value) {
                  if (value.length > 0)
                    $('form[name=detail] .files').append('<p class="primary_color note">' + value
                        + '</p>');
                });
              } else {
                $('form[name=detail] .files').append(
                    '<p class="primary_color note"><spring:message code="common.title.no.file"/> </p>');
              }
              var poDetailItem = json.purchaseOrder.purchaseOrderDetails;
              var tbody = $('table.datatable-default tbody');
              tbody.html('');
              var i = 1;
              for (var item in poDetailItem) {
                var discountRate = poDetailItem[item].discountRate;
                if (discountRate == null || discountRate == '') discountRate = 0;
                var capitalValue = poDetailItem[item].faceValue * poDetailItem[item].quantity * (1
                    - discountRate / 100);
                var tr = '<tr>'
                    + '<td>' + i + '</td>'
                    + '<td>' + poDetailItem[item].cardType + '</td>'
                    + '<td class="text-right">' + poDetailItem[item].faceValue.toLocaleString(
                        'de-DE') + '</td>'
                    + '<td class="text-right">' + poDetailItem[item].quantity.toLocaleString(
                        'de-DE') + '</td>'
                    + '<td class="text-right">' + discountRate + '</td>'
                    + '<td class="text-right">' + capitalValue.toLocaleString('de-DE')
                    + '</td></tr>';
                tbody.append(tr);
                i++;
              }
            }
            else {
              $.MessageBox({message: json.status.code.value});
            }
          });
    });

    $('a.transfer-po').click(function () {
      ResetAll('transfer');
      $('form[name=transfer] input[name=poid]').val($(this).attr("poid"));
      $('form[name=transfer] .po-number').html($(this).attr("pocode"));
      $('form[name=transfer] .provider').html($(this).attr("provider"));
      $('form[name=transfer] .card-am').html(formatNumberSeparator($(this).attr("card-am"), ''));
      $('form[name=transfer] .total-am').html(formatNumberSeparator($(this).attr("total-am"), ''));
      $('form[name=transfer] .time').html($(this).attr("time"));
      $('form[name=transfer] .special-customer').html($(this).attr("special-customer"));
      $('form[name=transfer] .is-private').html($(this).attr("is-private"));
      $('input[name=poCode]').val($(this).attr("pocode"));

      var note = ($(this).attr("note")).split("<=");
      note.forEach(function (value) {
        if (value != null && value != 'null')
          $('form[name=transfer] .note').append('<p class="primary_color">' + value + '</p>');
      });
      var files = $(this).attr("files");
      if (files != null && files.length > 0) {
        var listFile = files.split(':');
        listFile.forEach(function (value) {
          if (value.length > 0)
            $('form[name=transfer] .files').append('<p class="primary_color note">' + value + '</p>');
        });
      } else {
        $('form[name=transfer] .files').append('<p class="primary_color note">Chưa có file!</p>');
      }
    });

    function ResetAll(formName) {
      $('form[name=' + formName + '] input[name=poid]').val('');
      $('form[name=' + formName + '] .provider').html('');
      $('form[name=' + formName + '] .card-am').html('');
      $('form[name=' + formName + '] .total-am').html('');
      $('form[name=' + formName + '] .total-cc').html('');
      $('form[name=' + formName + '] .time').html('');
      $('form[name=' + formName + '] .note').html('');
      $('form[name=' + formName + '] .po-number').html('');
      $('form[name=' + formName + '] textarea[name=note]').val('');
      $('form[name=' + formName + '] .status').html('');
      $('form[name=' + formName + '] input:checkbox').prop('checked', false);
      $('form[name=' + formName + '] .files').html('');
      $('form[name=' + formName + '] .special-customer').html('');
      $('form[name=' + formName + '] .is-private').html('');

      $('.show-customer-special-1').hide();
      $('#specialCustomer1').find('option').each(
          function () {
            $('#specialCustomer1').multiselect('deselect', $(this).val());
          }
      );
    }

    $('form[name=status] button:submit').click(function () {
      if ($(this).hasClass('btnInactive')) {
        if ($('form[name=status] textarea[name=note]').val().length < 1) {
          $.MessageBox({message: '<spring:message code="message.fill.in.the.reason"/> '});
          return false;
        }
      }
      if ($('form[name=status] input[name=ckaccess]').is(":checked")) {
        return true;
      } else {
        $.MessageBox(
            {message: '<spring:message code="message.click.agree.if.you.want.to.change"/> '});
        return false;
      }
    });
    $('form[name=status]').submit(function () {
      var poid = $('form[name=status] input[name=poid]').val();
      $(".btnStatus").button('loading');
      $.post($(this).attr('action'), $(this).serialize(), function (json) {
        $.MessageBox({message: json.message}).done(function () {
          if (json.code == 0) {
            $(".switchery-mask[poid=" + poid + "]").attr('status',
                $('form[name=status] input[name=action]').val());
            $(".switchery-mask[poid=" + poid + "]").closest('.switch').find(
                'span.switchery').click();
            location.reload();
            $('#status').modal('toggle');
          }
          setTimeout(function () {
            $(".btnStatus").button('reset');
          }, 1000);
        });
      });
      return false;
    });

    $('form[name=ready-verify]').submit(function () {
      var answer = $('form[name=ready-verify] input[name=ckaccess]').is(":checked");
      if (answer) {
        $(".btnReady").button('loading');
        var poid = $('form[name=ready-verify] input[name=poid]').val();
        $.post($(this).attr('action'), $(this).serialize(), function (json) {
          $.MessageBox({message: json.message});
          if (json.code == 0) {
            location.reload();
          }
          setTimeout(function () {
            $(".btnReady").button('reset');
          }, 1000);
        });
      } else {
        $.MessageBox({message: '<spring:message code="message.confirm.the.approval.proposal"/> '});
      }
      return false;
    });
  });


  $('form[name = transfer] input[name=ckSpecialCard]').change(function () {
    if ($(this).is(':checked')) {
      // Checkbox is checked.
      var dataSpecialCustomer = []/*, specialCustomer*/;
      <c:forEach var="item1" items="${listSpecialCustomer}">
      dataSpecialCustomer.push('${item1.displayName}-(${item1.cif})');
      </c:forEach>
      if (dataSpecialCustomer != '' && dataSpecialCustomer.length > 0) {
        $('form[name = transfer] input[name = ckSpecialCard]:checked').attr('checked', true);
        $('form[name = transfer] input#hidden_checkBoxSpecialCard').val('1');
        $('.show-customer-special-1').show();
        $('#ckGeneralStore:checked').attr('checked', false);
      }else{
        $('form[name = transfer] input[name = ckSpecialCard]:checked').attr('checked', false);
        $('form[name = transfer] input#hidden_checkBoxSpecialCard').val('0');
        $('.show-customer-special-1').hide();
        $('#ckGeneralStore:checked').attr('checked', true);
        $.MessageBox({message: 'Không có KH đặc biệt không chọn được lô thẻ riêng'});
      }
    } else {
      // Checkbox is not checked..
      $('form[name = transfer] input#hidden_checkBoxSpecialCard').val('');
      $('.show-customer-special-1').hide();
    }
  });

  $('form[name = transfer] input[name = ckGeneralStore]').change(function () {
    if ($(this).is(':checked')) {
      $('form[name = transfer] input[name = ckSpecialCard]:checked').attr('checked', false);
      $('form[name = transfer] input#hidden_checkBoxSpecialCard').val('0');
      $('.show-customer-special-1').hide();
    }
    else {
      $('form[name = transfer] input#hidden_checkBoxSpecialCard').val('');
    }
  });

  $('form[name=transfer] button:submit').click(function () {

    var specialCustomer = $('#specialCustomer1').val();
    if ($('form[name=transfer] input[name=ckSpecialCard]').is(":checked") && specialCustomer == null) {
      $.MessageBox(
          {message: '<spring:message code="common.message.not.selected.customer"/>'});
      return false;
    }

    if (!($('form[name=transfer] input[name=ckSpecialCard]').is(':checked') || $(
            'form[name=transfer] input[name=ckGeneralStore]').is(':checked'))) {
      $.MessageBox(
          {message: '<spring:message code="common.message.not.selected.mode"/>'});
      return false;
    }

    if ($('form[name=transfer] input[name=ckaccess]').is(":checked")) {
      return true;
    } else {
      $.MessageBox(
          {message: '<spring:message code="message.click.agree.if.you.want.to.change"/> '});
      return false;
    }
  });

  $('form[name=transfer]').submit(function () {
    $(".btnTransfer").button('loading');
    $.post($(this).attr('action'), $(this).serialize(), function (json) {
      $.MessageBox({message: json.message}).done(function () {
        if (json.code == 0) {
          $('#reset-commission-fee-modal').modal('toggle');
          location.reload();
        }
        setTimeout(function () {
          $(".btnTransfer").button('reset');
        }, 1000);
      });
    });
    return false;
  });
</script>
<script type="text/javascript"
        src="<c:url value='/assets/development/static/js/card-store.js'/>"></script>
</body>

</html>

