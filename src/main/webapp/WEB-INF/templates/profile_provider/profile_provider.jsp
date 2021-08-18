<%@ taglib prefix="ewallet" uri="https://processing.function.template/service/jsp/jstl/functions" %>
<%@ page import="vn.mog.ewallet.web.controller.dashboard.beans.CardStatus" %>
<%@ page
    import="static vn.mog.ewallet.constant.SharedConstants.MENU_ITEM_SHOW_CARD_STORE_OFF_LINE" %>
<%@ page import="vn.mog.ewallet.web.controller.dashboard.beans.UpType" %>
<%@ page language="java" trimDirectiveWhitespaces="true" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="../include_page/taglibs.jsp" %>


<!doctype html>
<html class="fixed" lang="${pageContext.response.locale.language}">

<head>
  <!-- Basic -->
  <meta charset="UTF-8">
  <title><spring:message code="common.card.managerment"/></title>
  <jsp:include page="../include_page/head.jsp">
    <jsp:param name="selectLib" value="true"/>
  </jsp:include>
  <jsp:include page="../include_page/js_service.jsp">
    <jsp:param name="tableLib" value="true"/>
    <jsp:param name="dateLib" value="true"/>
  </jsp:include>
</head>

<body>
<section class="body">
  <c:set var="MENU_ITEM_SHOW_CARD_STORE_OFF_LINE" value="<%=MENU_ITEM_SHOW_CARD_STORE_OFF_LINE%>"/>

  <jsp:include page="../include_page/header.jsp"/>

  <div class="inner-wrapper">

    <!-- start: sidebar -->
    <jsp:include page="../include_page/navigation.jsp">
      <jsp:param value="profile_provider_n02" name="nav"/>
    </jsp:include>
    <!-- end: sidebar -->

    <section role="main" class="content-body">
      <header class="page-header">
        <div class="row">
          <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
            <div class="page-header-left">
              <ol class="breadcrumbs">
                <li><a href="#"><i class="fa fa-home"></i></a></li>
                <li><span><spring:message code="menu.left.card.store.special"/></span></li>
                <li><span class="nav-active"><spring:message code="label.profile.provider"/></span>
                </li>
              </ol>
            </div>
          </div>
        </div>
      </header>

      <jsp:include page="../include_page/message.jsp"/>

      <!-- start: page -->
      <div class="content-body-wrap">
        <%--<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 pl-none">--%>
        <%--<div class="page-header-left header-title">--%>
        <%--<spring:message code="label.profile.provider"/>--%>
        <%--</div>--%>
      </div>

      <%--<div class="tabs">--%>
      <%--<ul class="nav nav-tabs">--%>
      <%--<li class="active"><a href="#tab1" data-toggle="tab"><spring:message--%>
      <%--code="common.title.card.item"/></a></li>--%>
      <%--<li><sec:authorize access="hasAnyRole('ADMIN_OPERATION','FINANCESUPPORT_LEADER','FA_MANAGER','CUSTOMERCARE_MANAGER','CUSTOMERCARE')">--%>
      <%--<a href="<%=request.getContextPath() %>/provider/purchase-order/list"><spring:message--%>
      <%--code="common.purchase.order"/></a>--%>
      <%--</sec:authorize></li>--%>
      <%--</ul>--%>
      <div class="tab-content">
        <div id="tab1" class="tab-pane active">
          <form action="list" method="GET" id="tbl-filter">

            <div class="col-md-12 mb-none p-none" style="height: 36px;">
              <div class="form-group">
                <div class="col-md-4 col-sm-12 col-xs-12">
                  <label class="control-label"><spring:message
                      code="common.title.provider"/> </label>
                </div>
                <div class="col-md-8 col-sm-12 col-xs-12">
                  <c:set var="allTypePO" value=","/>
                  <c:forEach var="st" items="${paramValues.provider}">
                    <c:set var="allTypePO" value="${allTypePO}${st},"/>
                  </c:forEach>
                  <select data-plugin-selectTwo
                          class="form-control"
                          id="provider"
                          name="provider">
                    <option value=""><spring:message code="label.please.select"/></option>
                    <c:forEach var="item" items="${listProvider }">
                      <c:set var="typePO" value=",${item.code},"/>
                      <option ${fn:contains(allTypePO, typePO)?'selected':'' }
                          value="${item.code}">${item.name}</option>
                    </c:forEach>
                  </select>
                </div>
              </div>

            </div>

            <div class="clr"></div>
            <section class="panel search_payment panel-default">
              <div class="p-md">

                  <%--<jsp:include page="../include_component/date_range.jsp"/>--%>

                  <div class="pull-right">

                    <%--type PO  --%>

                    <%--<c:set var="allTypePO" value=","/>--%>
                    <%--<c:forEach var="st" items="${paramValues.provider}">--%>
                    <%--<c:set var="allTypePO" value="${allTypePO}${st},"/>--%>
                    <%--</c:forEach>--%>
                    <%--<select data-plugin-selectTwo--%>
                    <%--class="form-control"--%>
                    <%--id="provider"--%>
                    <%--name="provider">--%>
                    <%--<c:forEach var="item" items="${listProvider }">--%>
                    <%--<c:set var="typePO" value=",${item.code},"/>--%>
                    <%--<option ${fn:contains(allTypePO, typePO)?'selected':'' }--%>
                    <%--value="${item.code}">${item.name}</option>--%>
                    <%--</c:forEach>--%>
                    <%--</select>--%>

                    <%--end--%>

                    <%--<c:set var="allcardTypes" value=","/>--%>
                    <%--<c:forEach var="tc" items="${paramValues.cardTypes}">--%>
                    <%--<c:set var="allcardTypes" value="${allcardTypes}${tc},"/>--%>
                    <%--</c:forEach>--%>
                    <%--<select id="cardTypes" name="cardTypes"--%>
                    <%--class="form-control chart-filter hidden" multiple>--%>
                    <%--<c:forEach var="item" items="${cardTypes}">--%>
                    <%--<c:set var="types2" value=",${item.code},"/>--%>
                    <%--<option ${fn:contains(allcardTypes, types2)?'selected':'' }--%>
                    <%--value="${item.code}">${item.name}</option>--%>
                    <%--</c:forEach>--%>
                    <%--</select>--%>


                    <%--<c:set var="allValues" value=","/>--%>
                    <%--<c:forEach var="val" items="${paramValues.faceValues}">--%>
                    <%--<c:set var="allValues" value="${allValues}${val},"/>--%>
                    <%--</c:forEach>--%>
                    <%--<select class="form-control hidden" name="faceValues" multiple="multiple"--%>
                    <%--id="ms_amount">--%>
                    <%--<c:forEach var="item" items="${listAmount }">--%>
                    <%--<c:set var="value2" value=",${item.key},"/>--%>
                    <%--<option ${fn:contains(allValues, value2)?'selected':'' }--%>
                    <%--value="${item.key}">${item.value}</option>--%>
                    <%--</c:forEach>--%>
                    <%--</select>--%>

                    <%--<c:set var="allStatus" value=","/>--%>
                    <%--<c:forEach var="st" items="${paramValues.status}">--%>
                    <%--<c:set var="allStatus" value="${allStatus}${st},"/>--%>
                    <%--</c:forEach>--%>
                    <%--<c:set var="listStatus" value="<%= CardStatus.values() %>"/>--%>
                    <%--<select class="form-control hidden" name="status" multiple="multiple"--%>
                    <%--id="status">--%>
                    <%--<c:forEach var="item" items="${listStatus }">--%>
                    <%--<c:set var="status2" value=",${item.code},"/>--%>
                    <%--<c:if test="${item.name != 'NOTAVAILABLE' and item.name != 'NEAR_EXP'}">--%>
                    <%--<option ${fn:contains(allStatus, status2)?'selected':'' }--%>
                    <%--value="${item.code}">--%>
                    <%--<spring:message code="${item.getName()}"/>--%>
                    <%--</option>--%>
                    <%--</c:if>--%>
                    <%--</c:forEach>--%>
                    <%--</select>--%>


                    <%--<c:set var="allStages" value=","/>--%>
                    <%--<c:forEach var="stg" items="${paramValues.stages}">--%>
                    <%--<c:set var="allStages" value="${allStages}${stg},"/>--%>
                    <%--</c:forEach>--%>
                    <%--<select class="form-control hidden" name="stages" multiple="multiple"--%>
                    <%--id="stage">--%>
                    <%--<option ${fn:contains(allStages, 'ON')?'selected':'' } value="ON">--%>
                    <%--<spring:message code="stage.active"/></option>--%>
                    <%--<option ${fn:contains(allStages, 'OFF')?'selected':'' } value="OFF">--%>
                    <%--<spring:message code="stage.inactive"/></option>--%>
                    <%--</select>--%>


                    <button type="submit" class="btn btn-primary btn-sm"><i
                        class="fa fa-search"></i>&nbsp;<spring:message
                        code="common.btn.search"/></button>
                    <a href="?" class="btn btn-default nomal_color_bk bt-cancel"><spring:message
                        code="common.btn.cancel"/></a>
                  </div>
                </div>
              <div class="clearfix"></div>
            </section>
          </form>
          <div class="clearfix"></div>
          <section class="panel search_payment panel-default">
            <div class="panel-body" style="padding-top: 0">
              <%--<c:if test="${total > 0}">--%>
              <%--<h4 style="font-size: 13px;">--%>
              <%--<spring:message code="common.title.total.items"/>&nbsp; <span--%>
              <%--class="primary_color text-semibold">${ewallet:formatNumber(total)}</span> |--%>
              <%--<spring:message code="common.title.total.face.value"/>&nbsp;<span--%>
              <%--class="primary_color text-semibold">${ewallet:formatNumber(sumOfmoney)} VND </span>--%>
              <%--|--%>
              <%--<spring:message code="common.title.total.capital.value"/>&nbsp;<span--%>
              <%--class="primary_color text-semibold">${ewallet:formatNumber(sumOfcapital)} VND </span>--%>
              <%--</h4>--%>
              <%--</c:if>--%>

              <spring:message var="colStt" code="purchase.table.no"/>
              <spring:message var="colTypeOfService" code="label.type.of.service"/>
              <spring:message var="colProvider" code="purchase.table.provider"/>
              <spring:message var="colService" code="label.service"/>
              <spring:message var="colFaceValue" code="purchase.table.face.value"/>
              <spring:message var="colCapitalValue" code="purchase.table.capital.value"/>
              <spring:message var="colCreateDate" code="purchase.table.create.date"/>
              <spring:message var="colExpireDate" code="purchase.table.expire.date"/>
              <spring:message var="colExportedDate" code="purchase.table.exported.date"/>
              <spring:message var="colStatus" code="purchase.table.status"/>
              <spring:message var="colDisPrice" code="label.discount.entry.price"/>

              <display:table name="list" id="list"
                             requestURI="list"
                             pagesize="${pagesize}" partialList="true" size="total"
                             class="table table-bordered table-striped mb-none"
                             sort="list">
                <%@ include file="../include_page/display_table.jsp" %>

                <display:column title="${colStt}" headerClass="transhead fit_to_content"
                                class="transdata right">
                  <c:out value="${list_rowNum }"/>
                </display:column>
                <display:column
                    title="${ewallet:toUpperCase(colTypeOfService)}">
                  <a>${list.serviceType}</a>
                </display:column>
                <display:column title="${colProvider}" property="providerCode"/>
                <display:column title="${colService}" property="cardType"/>
                <display:column title="${colFaceValue}"
                                headerClass="col-number-header"
                                class="col-number-header">
                  ${ewallet:formatNumber(list.faceValue)}
                </display:column>

                <display:column title="${ewallet:toUpperCase(colDisPrice)}" headerClass="col-number-header"
                                class="col-number-header">${list.discountRate}</display:column>

                <%--<display:column title="${colCreateDate}" headerClass="col-number-header"--%>
                <%--class="col-number-header">--%>
                <%--<fmt:formatDate value="${list.creationDate}" pattern="HH:mm dd/MM/yyyy"/>--%>
                <%--</display:column>--%>

                <%--<display:column title="${colExpireDate}" headerClass="col-number-header"--%>
                <%--class="col-number-header">--%>
                <%--<fmt:formatDate value="${list.expiredDate}" pattern="HH:mm dd/MM/yyyy"/>--%>
                <%--</display:column>--%>

                <%--<display:column title="${colExportedDate}" property="exportedDate"--%>
                <%--format="{0,date,HH:mm dd/MM/yyyy}"/>--%>
                <%----%>
                <%--<display:column title="${colStatus}" style="min-width: 95px;">--%>
                <%--<c:if test="${list.status == 'SOLD'}">--%>
                <%--<label class="mb-xs mt-xs mr-xs btn btn-xs btn-danger"><spring:message--%>
                <%--code="card.status.sold"/></label>--%>
                <%--</c:if>--%>
                <%--<c:if test="${list.status == 'IN_STOCK'}">--%>
                <%--<c:if test="${list.stage == 'ON'}">--%>
                <%--<label class="mb-xs mt-xs mr-xs btn btn-xs btn-success"><spring:message--%>
                <%--code="card.status.available"/></label>--%>
                <%--</c:if>--%>
                <%--<c:if test="${list.stage == 'OFF'}">--%>
                <%--<label class="mb-xs mt-xs mr-xs btn btn-xs btn-warning"><spring:message--%>
                <%--code="card.status.notavailable"/></label>--%>
                <%--</c:if>--%>
                <%--</c:if>--%>
                <%--</display:column>--%>
              </display:table>
            </div>
          </section>
        </div>
      </div>
      <%--</div>--%>

  </div>
  <!-- end: page -->
</section>
<jsp:include page="../include_page/footer.jsp"/>
</div>
</section>
<jsp:include page="../include_page/js_footer.jsp"/>
<jsp:include page="../include_page/date_picker.jsp">
  <jsp:param name="isFullTime" value="true"/>
  <jsp:param name="isFilter" value="true"/>
</jsp:include>


<script type="text/javascript">
  <%--$('#provider').multiselect({--%>
  <%--includeSelectAllOption: true,--%>
  <%--selectAllValue: '',--%>
  <%--selectAllText: '<spring:message code="common.select.choose.all"/>',--%>
  <%--maxHeight: 400,--%>
  <%--dropUp: true,--%>
  <%--nonSelectedText: '<spring:message code="common.title.provider"/>',--%>
  <%--inheritClass: true,--%>
  <%--numberDisplayed: 1--%>
  <%--});--%>

  <%--$('#cardTypes').multiselect({--%>
  <%--includeSelectAllOption: true,--%>
  <%--selectAllValue: '',--%>
  <%--selectAllText: '<spring:message code="common.select.choose.all"/>',--%>
  <%--maxHeight: 400,--%>
  <%--dropUp: true,--%>
  <%--nonSelectedText: '<spring:message code="common.select.card.type"/>',--%>
  <%--inheritClass: true,--%>
  <%--numberDisplayed: 1--%>
  <%--});--%>

  <%--$('#ms_amount').multiselect({--%>
  <%--includeSelectAllOption: true,--%>
  <%--selectAllValue: '',--%>
  <%--selectAllText: '<spring:message code="common.select.choose.all"/>',--%>
  <%--maxHeight: 400,--%>
  <%--dropUp: true,--%>
  <%--nonSelectedText: '<spring:message code="common.select.face.value"/>',--%>
  <%--inheritClass: true,--%>
  <%--numberDisplayed: 1--%>
  <%--});--%>

  <%--$('#status').multiselect({--%>
  <%--includeSelectAllOption: true,--%>
  <%--selectAllValue: '',--%>
  <%--selectAllText: '<spring:message code="common.select.choose.all"/>',--%>
  <%--maxHeight: 400,--%>
  <%--dropUp: true,--%>
  <%--nonSelectedText: '<spring:message code="common.select.status"/>',--%>
  <%--inheritClass: true,--%>
  <%--numberDisplayed: 1--%>
  <%--});--%>

  <%--$('#stage').multiselect({--%>
  <%--includeSelectAllOption: true,--%>
  <%--selectAllValue: '',--%>
  <%--selectAllText: '<spring:message code="common.select.choose.all"/>',--%>
  <%--maxHeight: 400,--%>
  <%--dropUp: true,--%>
  <%--nonSelectedText: '<spring:message code="common.select.state"/>',--%>
  <%--inheritClass: true,--%>
  <%--numberDisplayed: 1--%>
  <%--});--%>

  $(document).ready(function () {
    $('table#list').dataTable({
      "paginate": false,
      "sort": true,
      "searching": false,
      "autoWidth": true
    });
  });
</script>
</body>
</html>


