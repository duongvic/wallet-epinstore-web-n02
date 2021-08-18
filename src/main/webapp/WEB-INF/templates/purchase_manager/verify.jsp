<%@ page language="java" trimDirectiveWhitespaces="true" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="../include_page/taglibs.jsp" %>


<!doctype html>
<html class="fixed" lang="${pageContext.response.locale.language}">

<head>
  <!-- Basic -->
  <meta charset="UTF-8">
  <title><spring:message code="dashboard.title"/></title>
  <jsp:include page="../include_page/head.jsp"/>
  <jsp:include page="../include_page/js.jsp">
    <jsp:param name="tableLib" value="true"/>
  </jsp:include>
</head>

<body>
<section class="body">

  <jsp:include page="../include_page/header.jsp"/>

  <div class="inner-wrapper">

    <!-- start: sidebar -->
    <jsp:include page="../include_page/navigation.jsp">
      <jsp:param value="purchase_order" name="nav"/>
    </jsp:include>
    <!-- end: sidebar -->

    <section role="main" class="content-body">
      <header class="page-header">
        <div class="row">
          <div class="pl-md ">
            <div class="page-header-left">
              <ol class="breadcrumbs">
                <li><a href="#"><i class="fa fa-home"></i></a></li>
                <li><span><spring:message code="header.card.store.special"/></span></li>
                <li><a href="list" id="hight-title" class="hight-title"><spring:message
                    code="common.purchase.order"/></a></li>
                <li><span class="nav-active"><spring:message code="common.btn.verify"/> </span></li>
              </ol>
            </div>
          </div>
        </div>
      </header>

      <jsp:include page="../include_page/message.jsp"/>
      <!-- start: page -->

      <div class="row content-body-wrap">
        <div class="col-md-12 col-lg-12 col-xl-12 quantrisanpham ">
          <div class="mb-md">
            <div class="wizard-tabs">
              <ul class="wizard-steps">
                <li class="col-xs-4 pl-none pr-none"><a class="text-center"><span
                    class="badge hidden-xs">1</span>&nbsp;<spring:message code="common.create.PO"/></a>
                </li>
                <li class="col-xs-4 pl-none pr-none"><a class="text-center"><span
                    class="badge hidden-xs">2</span>&nbsp;<spring:message
                    code="common.upload.file"/></a></li>
                <li class="col-xs-4 pl-none pr-none active"><a class="text-center"><span
                    class="badge hidden-xs">3</span>&nbsp;<spring:message code="common.btn.verify"/></a>
                </li>
              </ul>
            </div>

            <div class="tab-content">
              <div id="tab1" class="tab-pane active">
                <div class="row content-body-wrap">
                  <div class="col-md-12 col-lg-12 col-xl-12">

                    <section class="panel panel-default">
                      <div class="panel-title">
                        <h2 style="font-size: 26px;font-weight:bold"><spring:message
                            code="common.confirm.information"/></h2>
                      </div>
                      <div class="panel-title">
                        <div class="form-group" style="font-size:13px;">
                          <label class="col-md-1 control-label">*<spring:message
                              code="common.note"/></label>
                          <div class="col-md-4 tertiary_color">
                            <spring:message code="common.title.guild"/> <i
                              class="fa  fa-question-circle text-muted m-xs " data-toggle="popover"
                              data-trigger="hover" data-placement="top"
                              data-content='<spring:message code="common.title.step2.processing.verify.for.PO"/>   <br />
																					<spring:message code="common.title.if.declare.information.doesnt.match.enter.reason.reject"/><br />
																					<spring:message code="common.title.if.declare.information.matched.confirm"/>'
                              data-html="true" data-original-title="" title=""></i>
                          </div>
                        </div>
                        <fmt:formatNumber type="number" var="totalValueFile"
                                          value="${responsePO.totalValueFile }"/>
                        <fmt:formatNumber type="number" var="totalQuantityFile"
                                          value="${responsePO.totalQuantityFile }"/>
                        <c:set var="totalValCmp" value="bg-success"/>
                        <c:set var="totalAmtCmp" value="bg-success"/>
                        <c:if test="${responsePO.totalValueFile != responsePO.totalValueDB}">
                          <c:set var="totalValCmp" value="bg-warning"/>
                        </c:if>
                        <c:if test="${responsePO.totalQuantityFile != responsePO.totalQuantityDB}">
                          <c:set var="totalAmtCmp" value="bg-warning"/>
                        </c:if>
                        <fmt:formatNumber type="number" var="totalValueDB"
                                          value="${responsePO.totalValueDB }"/>
                        <fmt:formatNumber type="number" var="totalQuantityDB"
                                          value="${responsePO.totalQuantityDB }"/><br/>

                        <div class="table-responsive">
                          <table class="table table-bordered table-striped mb-none">
                            <thead>
                            <th><spring:message code="purchase.table.total.card.in.file"/></th>
                            <th><spring:message code="purchase.table.total.card.declared"/></th>
                            <th><spring:message code="purchase.table.total.value.in.file"/></th>
                            <th><spring:message code="purchase.table.total.value.declared"/></th>
                            </thead>
                            <tbody>
                            <td><b class="${totalAmtCmp }">&nbsp;${totalQuantityFile }&nbsp;</b>
                            </td>
                            <td><b class="${totalAmtCmp }">&nbsp;${totalQuantityDB }&nbsp;</b></td>
                            <td><b class="${totalValCmp }">&nbsp;${totalValueFile }&nbsp;</b></td>
                            <td><b class="${totalValCmp }">&nbsp;${totalValueDB }&nbsp;</b></td>
                            </tbody>
                          </table>
                        </div>
                        <ul class="panel-tools">
                          <%--<li><a class="icon minimise-tool"><i class="fa fa-minus"></i></a></li>
                          <li><a class="icon expand-tool"><i class="fa fa-expand"></i></a></li>--%>
                        </ul>
                      </div>
                      <div class="panel-body">
                        <div class="table-responsive">
                          <table class="table table-bordered table-striped mb-none">
                            <thead>
                            <tr>
                              <th><spring:message code="purchase.table.no"/></th>
                              <th><spring:message code="purchase.table.card.type"/></th>
                              <th class="text-right"><spring:message
                                  code="purchase.table.face.value"/></th>
                              <th class="text-right"><spring:message
                                  code="purchase.table.quantity.upload"/></th>
                              <th class="text-right"><spring:message
                                  code="purchase.table.quantity.declared"/></th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:set var="cmpRsClass" value="bg-success"/>
                            <c:forEach items="${compareResult }" var="rsList" varStatus="idx">
                              <c:if test="${rsList.match == false }">
                                <c:set var="cmpRsClass" value="bg-warning"/>
                              </c:if>
                              <tr>
                                <td>${idx.index+1 }</td>
                                <td>&nbsp;${rsList.file.cardType }&nbsp;</td>
                                <td class="text-right"><fmt:formatNumber type="number"
                                                                         var="fileValue"
                                                                         value="${rsList.file.faceValue }"/>${fileValue }</td>
                                <td class="text-right"><span
                                    class="${cmpRsClass }">&nbsp;<fmt:formatNumber type="number"
                                                                                   var="fileQty"
                                                                                   value="${rsList.file.quantity }"/>${fileQty }&nbsp;</span>
                                </td>
                                <td class="text-right"><span
                                    class="${cmpRsClass }">&nbsp;<fmt:formatNumber type="number"
                                                                                   var="declaredQty"
                                                                                   value="${rsList.declared.quantity }"/>${declaredQty }&nbsp;</span>
                                </td>
                                <c:set var="cmpRsClass" value="bg-success"/>
                              </tr>
                            </c:forEach>
                            </tbody>
                          </table>
                        </div>

                      </div>
                    </section>
                    <form name="exportExistfile" action="getFileExistCard" method="post">
                      <input type="hidden" name="poid" value="${poId }"/>
                      <input type="hidden" name="password" value="${password }"/>
                      <sec:csrfInput/>
                    </form>

                    <form name="process" method="post"
                          action="${pageContext.request.contextPath}/provider/purchase-order/verify/commit">
                      <c:if
                          test="${!responsePO.equal || (responsePO.existedPinQuantity + responsePO.existedSerialQuantity != 0)}">
                        <div class="form-group report_search_bt">
                          <div class="form-group">
                            <label class="col-md-3 control-label"><spring:message
                                code="common.note"/></label>
                            <div class="col-md-4">
                              <textarea name="note" class="form-control" rows="3"
                                        id="textareaDefault"></textarea>
                            </div>
                          </div>
                        </div>
                      </c:if>
                      <c:if
                          test="${responsePO.existedPinQuantity + responsePO.existedSerialQuantity != 0 }">

                        <div
                            class="alert_das appear-animation fadeInRightBig appear-animation-visible"
                            style="margin: 0;">
                          <div class="alert alert-danger">
                            <button type="button" class="close" data-dismiss="alert"
                                    aria-hidden="true">×
                            </button>
                            <strong><spring:message code="common.title.Notification"/></strong>
                            <h4 style="font-size: 13px;" class="mt-sm">
                              <spring:message
                                  code="common.title.the.number.of.serial.is.identical"/><b> ${responsePO.existedSerialQuantity } </b>
                              | <spring:message code="common.title.the.number.of.pin.is.identical"/><b> ${responsePO.existedPinQuantity } </b>
                              | Tải file : <a href="${responsePO.existedFile }"
                                              class="exist-file"><i class="fa fa-download"
                                                                    aria-hidden="true"></i>
                              <b>${responsePO.existedFileName }</b> </a>
                            </h4>
                          </div>
                        </div>
                      </c:if>

                      <div class="form-group show-data-special-merchant">
                        <label class="col-3 control-label"
                               for="listSpecialMerchant"><spring:message
                            code="po.select.special.customer"/></label>
                        <div class="col-9">
                                      <textarea name="listSpecialMerchant" class="form-control"
                                                disabled
                                                rows="3"
                                                id="listSpecialMerchant">${dataListSelectMerchant}</textarea>
                        </div>

                        <%--combobox list merchant--%>
                        <div class="hidden">
                          <c:set var="allSpecialCustomer" value=","/>
                          <c:forEach var="st" items="${specialCustomer}">
                            <c:set var="allSpecialCustomer"
                                   value="${allSpecialCustomer}${st},"/>
                          </c:forEach>
                          <select class="form-control multiple-select hidden"
                                  multiple="multiple" id="specialCustomer"
                                  name="specialCustomer">
                            <c:choose>
                              <c:when
                                  test="${not empty listSpecialCustomer && listSpecialCustomer.size() > 0 }">
                                <c:forEach var="item" items="${listSpecialCustomer}">
                                  <option
                                      value="${item.cif}" ${fn:contains(allSpecialCustomer, item.cif) ? 'selected' : ''}>${item.displayName}
                                    (${item.cif})
                                  </option>
                                </c:forEach>
                              </c:when>
                              <c:otherwise>
                                <option value="">N/A</option>
                              </c:otherwise>
                            </c:choose>
                          </select>
                        </div>
                        <%--end combobox list merchant--%>
                      </div>
                      <div class="alert alert-default mb-none mt-md p-sm">
                        <div class="checkbox-custom checkbox-success">
                          <input type="checkbox" name="ckaccess" id="checkboxExample3">
                          <label for="checkboxExample3"><spring:message
                              code="common.are.u.sure"/> </label>
                        </div>

                      </div>
                      <div class="form-group report_search_bt">

                        <input type="hidden" name="poid" value="${poId }"/>
                        <input type="hidden" name="poCode" value="${poCode }"/>
                        <input type="hidden" name="password" value="${password }"/>

                        <c:choose>
                          <c:when
                              test="${responsePO.equal && (responsePO.existedPinQuantity + responsePO.existedSerialQuantity == 0) }">
                            <button type="submit" class="fr submit_bt"
                                    data-loading-text="<i class='fa fa-spinner fa-spin '></i> <spring:message code="common.waitting.pl"/>">
                              <i class="fa fa-plus"></i>&nbsp;<spring:message
                                code="button.confirm"/></button>
                            <input type="hidden" name="action" value="CONFIRMED"/>
                          </c:when>
                          <c:otherwise>
                            <button type="submit" class="fr submit_bt btn-danger"
                                    data-loading-text="<i class='fa fa-spinner fa-spin '></i> <spring:message code="common.waitting.pl"/>"
                                    style="background:#d2322d;"><i
                                class="fa fa-ban"></i>&nbsp;<spring:message code="button.reject"/>
                            </button>
                            <input type="hidden" name="action" value="REJECTED"/>
                          </c:otherwise>
                        </c:choose>
                        <a href="${pageContext.request.contextPath}/provider/purchase-order/list"
                           class="nomal_color_bk fr"><i
                            class="fa fa-arrow-left"></i>&nbsp;<spring:message
                            code="common.btn.cancel"/></a>
                      </div>
                      <sec:csrfInput/>
                    </form>
                  </div>
                </div>
              </div>
              <div id="tab2" class="tab-pane"></div>
            </div>
          </div>
        </div>
      </div>

      <!-- end: page -->
    </section>
    <jsp:include page="../include_page/footer.jsp"/>
  </div>
</section>
<script type="text/javascript">

  $(document).ready(function () {
    $('.exist-file').click(function () {
      $('form[name=exportExistfile]').submit();
      return false;
    });

    $("form[name=process] button:submit").click(function () {
      if ($("form[name=process] input[name=action]").val() == 'REJECTED') {
        if ($("form[name=process] textarea[name=note]").val().length < 1) {
          $.MessageBox(
              {message: '<spring:message code="message.enter.the.reason.for.the.refusal"/> '});
          $("form[name=process] textarea[name=note]").focus();
          return false;
        }
      }
      var answer = $('form[name=process] input[name=ckaccess]').is(":checked");
      if (!answer) {
        $.MessageBox({message: '<spring:message code="message.pl.confirm.action"/> '});
        return false;
      }
      $("#mloading").modal('toggle');
    });

    /*lấy ds private customer*/
    $('#specialCustomer').multiselect({
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

    var specialCustomer = [];
    <c:forEach var="item1" items="${specialCustomer}">
    specialCustomer.push('${item1}');
    </c:forEach>
    if (specialCustomer != '' && specialCustomer.length > 0) {
      $('.multiple-select').find('option').each(
          function () {
            if ($.inArray($(this).val(), specialCustomer) > -1) {
              $('.multiple-select').multiselect('select', $(this).val(), true);
            } else {
              $('.multiple-select').multiselect('deselect', $(this).val());
            }
          }
      );
    }

    /*lấy ds private customer*/
    var dataListSelectMerchant = [];
    var specialCustomer = $('#specialCustomer option:selected');
    for (var i = 0; i < specialCustomer.length; ++i) {
      var item = specialCustomer[i].label;
      dataListSelectMerchant.push(item);
    }

    $('#listSpecialMerchant').val(dataListSelectMerchant);
  });
</script>
<jsp:include page="../include_page/js_footer.jsp"/>
</body>
</html>

