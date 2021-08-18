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
  <title><spring:message code="dashboard.title"/></title>
  <jsp:include page="../include_page/head.jsp"/>

  <jsp:include page="../include_page/js.jsp">
    <jsp:param name="tableLib" value="true"/>
  </jsp:include>
  <style type="text/css">
    .mt-8 {
      margin-top: 8px;
    }

    .cursor_pointer {
      cursor: pointer
    }
  </style>
</head>

<body>
<section class="body">
  <c:set var="MENU_ITEM_SHOW_CARD_STORE_OFF_LINE"
         value="<%=MENU_ITEM_SHOW_CARD_STORE_OFF_LINE%>"/>
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
                <li><span class="nav-active"><spring:message code="common.btn.createPO"/></span>
                </li>
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
              <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="background-color: white;">
                <div class="page-header-left header-title" id="titleDeclarePO">
                  <spring:message code="common.create.PO"/>
                </div>
              </div>
              <ul class="wizard-steps">
                <li class="col-xs-4 pl-none pr-none active"><a id="declare_po" href="#tab6"
                                                               class="text-center"
                                                               data-toggle="tab"><span
                    class="badge hidden-xs">1</span>&nbsp;<spring:message code="common.create.PO"/></a>
                </li>
                <li class="col-xs-4 pl-none pr-none"><a id="upload_po" href="#tab7"
                                                        class="text-center" data-toggle="tab"><span
                    class="badge hidden-xs">2</span>&nbsp;<spring:message
                    code="common.upload.file"/></a></li>
                <li class="col-xs-4 pl-none pr-none"><a class="text-center"><span
                    class="badge hidden-xs">3</span>&nbsp;<spring:message code="common.btn.verify"/></a>
                </li>
              </ul>
            </div>
            <div class="tab-content">
              <div id="tab6" class="tab-pane active">
                <section class="panel">
                  <div class="panel-body report_search_form pb-none">
                    <div class="row">
                      <form id="inputtel">
                        <div class="tab-content">
                          <section class="panel">
                            <div class="panel-body report_search_form">
                              <div class="form-group">
                                <label class="col-md-1 control-label">*<spring:message
                                    code="common.note"/></label>
                                <div class="col-md-4 tertiary_color">
                                  <spring:message code="common.title.guild"/> <i
                                    class="fa  fa-question-circle text-muted m-xs "
                                    data-toggle="popover"
                                    data-trigger="hover" data-placement="top"
                                    data-content='<spring:message code="step1.select.service.provider"/><br /> <spring:message code="step2.select.phone.card.type"/><br /> <spring:message code="step.3.fill.in.number.of.phone.card.per.face.value"/> <br /> <spring:message code="step4.click.insert.by.create.PO"/> <br /> <spring:message code="step5.click.confirm"/> <br /><spring:message code="step6.click.save.to.move.to.step.uploadfile"/> '
                                    data-html="true" data-original-title="" title=""></i>
                                </div>
                              </div>
                              <div class="title-bo-box">
                                <spring:message code="common.provider.information"/>
                              </div>
                              <div class="bo-box" id="bo-box">
                                <div class="form-group">
                                  <label class="col-md-3 control-label"><spring:message
                                      code="common.title.provider"/> </label>
                                  <div class="col-md-4">
                                    <select data-plugin-selectTwo name="provider" id="selProvider"
                                            class="form-control populate">
                                      <c:forEach var="item" items="${listProvider }">
                                        <option ${responsePO.poItem.provider == item ? 'selected' : '' }
                                            value="${item.code }">${item.name }</option>
                                      </c:forEach>
                                    </select>
                                  </div>
                                </div>
                              </div>
                              <!-- Card Line 01 -->
                              <div class="form-group telco m-auto text-center">
                                <div class="col-md-2">
                                  <label for="rd1" class="text-center cursor_pointer">
                                    <div class="sprite-card-viettel_100_40"></div>
                                    <br/>
                                    <input id="rd1" name="telco" value="VIETTEL" type="radio"
                                           class="mt-8" onclick="showGroup()"/>
                                  </label>
                                </div>
                                <div class="col-md-2">
                                  <label for="rd2" class="text-center cursor_pointer">
                                    <div class="sprite-card-mobifone_100_40"></div>
                                    <br/>
                                    <input id="rd2" name="telco" value="MOBIFONE" type="radio"
                                           class="mt-8" onclick="showGroup()"/>
                                  </label>
                                </div>
                                <div class="col-md-2">
                                  <label for="rd3" class="text-center cursor_pointer">
                                    <div class="sprite-card-vnphone_100_40"></div>
                                    <br/>
                                    <input id="rd3" name="telco" value="VINAPHONE" type="radio"
                                           class="mt-8" onclick="showGroup()"/>
                                  </label>
                                </div>
                                <div class="col-md-2">
                                  <label for="rd4" class="text-center cursor_pointer">
                                    <div class="sprite-card-vnmobile_100_40"></div>
                                    <br/>
                                    <input id="rd4" name="telco" value="VNMOBILE" type="radio"
                                           class="mt-8" onclick="showGroup()"/>
                                  </label>
                                </div>
                                <div class="col-md-2">
                                  <label for="rd5" class="text-center cursor_pointer">
                                    <div class="sprite-card-gmobile_100_40"></div>
                                    <br/>
                                    <input id="rd5" name="telco" value="GMOBILE" type="radio"
                                           class="mt-8" onclick="showGroup()"/>
                                  </label>
                                </div>
                              </div>
                              <!-- Card Line 02 -->
                              <div class="form-group telco m-auto text-center">
                                <div class="col-md-2">
                                  <label for="rd11" class="text-center cursor_pointer">
                                    <div class="sprite-card-garena_100_40"></div>
                                    <br/>
                                    <input id="rd11" name="telco" value="GARENA" type="radio"
                                           class="mt-8" onclick="showGroup()"/>
                                  </label>
                                </div>
                                <div class="col-md-2">
                                  <label for="rd12" class="text-center cursor_pointer">
                                    <div class="sprite-card-gate_100_40"></div>
                                    <br/>
                                    <input id="rd12" name="telco" value="GATE" type="radio"
                                           class="mt-8" onclick="showGroup()"/>
                                  </label>
                                </div>
                                <div class="col-md-2">
                                  <label for="rd13" class="text-center cursor_pointer">
                                    <div class="sprite-card-vcoin_100_40"></div>
                                    <br/>
                                    <input id="rd13" name="telco" value="VCOIN" type="radio"
                                           class="mt-8" onclick="showGroup()"/>
                                  </label>
                                </div>
                                <div class="col-md-2">
                                  <label for="rd14" class="text-center cursor_pointer">
                                    <div class="sprite-card-oncash_100_40"></div>
                                    <br/>
                                    <input id="rd14" name="telco" value="ONCASH" type="radio"
                                           class="mt-8" onclick="showGroup()"/>
                                  </label>
                                </div>
                                <div class="col-md-2">
                                  <label for="rd15" class="text-center">
                                    <div class="sprite-card-zing_100_40"></div>
                                    <br/>
                                    <input id="rd15" name="telco" value="ZING" type="radio"
                                           class="mt-8" onclick="showGroup()"/>
                                  </label>
                                </div>
                              </div>
                              <!-- Card Line 03 -->
                              <div class="form-group telco m-auto text-center">
                                <div class="col-md-2">
                                  <label for="rd21" class="text-center cursor_pointer">
                                    <div class="sprite-card-vinplay_100_40"></div>
                                    <br/>
                                    <input id="rd21" name="telco" value="VINPLAY" type="radio"
                                           class="mt-8" onclick="showGroup()"/>
                                  </label>
                                </div>
                                <div class="col-md-2">
                                  <label for="rd22" class="text-center cursor_pointer">
                                    <div class="sprite-card-mbPhoneTPT_100_40"></div>
                                    <br/>
                                    <input id="rd22" name="telco" value="DATA_MOBIFONE" type="radio"
                                           class="mt-8" onclick="showGroup()"/>
                                  </label>
                                </div>
                                <div class="col-md-2">
                                  <label for="rd23" class="text-center cursor_pointer">
                                    <div class="sprite-card-vnPhoneTPT_100_40"></div>
                                    <br/>
                                    <input id="rd23" name="telco" value="DATA_VINAPHONE"
                                           type="radio" class="mt-8" onclick="showGroup()"/>
                                  </label>
                                </div>
                                <div class="col-md-2">
                                  <label for="rd24" class="text-center cursor_pointer">
                                    <div class="sprite-card-viettel3G_100_40"></div>
                                    <br/>
                                    <input id="rd24" name="telco" value="DATA_VIETTEL" type="radio"
                                           class="mt-8" onclick="showGroup()"/>
                                  </label>
                                </div>
                                <div class="col-md-2">
                                  <label for="rd25" class="text-center cursor_pointer">
                                    <div class="sprite-card-scoi_100_40"></div>
                                    <br/>
                                    <input id="rd25" name="telco" value="SCOIN" type="radio"
                                           class="mt-8" onclick="showGroup()"/>
                                  </label>
                                </div>
                              </div>
                              <!-- Card Line 04 -->
                              <div class="form-group telco m-auto text-center">
                                <div class="col-md-2">
                                  <label for="rd26"
                                         class="text-center cursor_pointer">
                                    <div class="sprite-card-sohacoi_100_40"></div>
                                    <br/>
                                    <input id="rd26"
                                           name="telco"
                                           value="SOHA"
                                           type="radio"
                                           class="mt-8"
                                           onclick="showGroup()"/>
                                  </label>
                                </div>
                                <div class="col-md-2">
                                  <label for="rd27"
                                         class="text-center cursor_pointer">
                                    <div class="sprite-card-funcard_100_40"></div>
                                    <br/>
                                    <input id="rd27"
                                           name="telco"
                                           value="FUNCARD"
                                           type="radio"
                                           class="mt-8"
                                           onclick="showGroup()"/>
                                  </label>
                                </div>
                                <div class="col-md-2">
                                  <label for="rd28"
                                         class="text-center cursor_pointer">
                                    <div class="sprite-card-appota_100_40"></div>
                                    <br/>
                                    <input id="rd28"
                                           name="telco"
                                           value="APPOTA"
                                           type="radio"
                                           class="mt-8"
                                           onclick="showGroup()"/>
                                  </label>
                                </div>
                                <div class="col-md-2">
                                  <label for="rd29"
                                         class="text-center cursor_pointer">
                                    <div class="sprite-card-bit_100_40"></div>
                                    <br/>
                                    <input id="rd29"
                                           name="telco"
                                             value="BIT"
                                           type="radio"
                                           class="mt-8"
                                           onclick="showGroup()"/>
                                  </label>
                                </div>
                              </div>

                              <div style="margin-top: 2rem">
                                <!-- NHÓM 1 -->
                                <div id="idGroupDef" class="show-group-card">
                                  <div class="clearfix"></div>
                                  <div class="form-group textTelco">
                                    <label class="col-md-1 control-label"><span
                                        class="fr">10000</span></label>
                                    <div class="col-md-2">
                                      <input type="text" name="tc_am10"
                                             placeholder="<spring:message code="common.placeholder.quantity"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputtelco"
                                             data-telco="TELCO">
                                    </div>
                                    <div class="col-md-2">
                                      <input type="number" min="0" max="50"
                                             name="dtc_am10"
                                             placeholder="<spring:message code="common.placeholder.discount"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputdiscount"
                                             data-telco="TELCO">
                                    </div>

                                    <label class="col-md-1 control-label"><span
                                        class="fr">100000</span></label>
                                    <div class="col-md-2">
                                      <input type="text" name="tc_am100"
                                             placeholder="<spring:message code="common.title.quantity"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputtelco"
                                             data-telco="TELCO">
                                    </div>
                                    <div class="col-md-2">
                                      <input type="number" min="0" max="50"
                                             name="dtc_am100"
                                             placeholder="<spring:message code="common.placeholder.discount"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputdiscount"
                                             data-telco="TELCO">
                                    </div>
                                  </div>
                                  <div class="form-group textTelco">
                                    <label class="col-md-1 control-label"><span
                                        class="fr">20000</span></label>
                                    <div class="col-md-2">
                                      <input type="text" name="tc_am20"
                                             placeholder="<spring:message code="common.placeholder.quantity"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputtelco"
                                             data-telco="TELCO">
                                    </div>
                                    <div class="col-md-2">
                                      <input type="number" min="0" max="50"
                                             name="dtc_am20"
                                             placeholder="<spring:message code="common.placeholder.discount"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputdiscount"
                                             data-telco="TELCO">
                                    </div>
                                    <label class="col-md-1 control-label"><span
                                        class="fr">200000</span></label>
                                    <div class="col-md-2">
                                      <input type="text" name="tc_am200"
                                             placeholder="<spring:message code="common.placeholder.quantity"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputtelco"
                                             data-telco="TELCO">
                                    </div>
                                    <div class="col-md-2">
                                      <input type="number" min="0" max="50"
                                             name="dtc_am200"
                                             placeholder="<spring:message code="common.placeholder.discount"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputdiscount"
                                             data-telco="TELCO">
                                    </div>
                                  </div>
                                  <div class="form-group textTelco">
                                    <label class="col-md-1 control-label"><span
                                        class="fr">30000</span></label>
                                    <div class="col-md-2">
                                      <input type="text" name="tc_am30"
                                             placeholder="<spring:message code="common.placeholder.quantity"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputtelco"
                                             data-telco="TELCO">
                                    </div>
                                    <div class="col-md-2">
                                      <input type="number" min="0" max="50"
                                             name="dtc_am30"
                                             placeholder="<spring:message code="common.placeholder.discount"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputdiscount"
                                             data-telco="TELCO">
                                    </div>
                                    <label class="col-md-1 control-label"><span
                                        class="fr">300000</span></label>
                                    <div class="col-md-2">
                                      <input type="text" name="tc_am300"
                                             placeholder="<spring:message code="common.placeholder.quantity"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputtelco"
                                             data-telco="TELCO">
                                    </div>
                                    <div class="col-md-2">
                                      <input type="number" min="0" max="50"
                                             name="dtc_am300"
                                             placeholder="<spring:message code="common.placeholder.discount"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputdiscount"
                                             data-telco="TELCO">
                                    </div>
                                  </div>
                                  <div class="form-group textTelco">
                                    <label class="col-md-1 control-label"><span
                                        class="fr">50000</span></label>
                                    <div class="col-md-2">
                                      <input type="text" name="tc_am50"
                                             placeholder="<spring:message code="common.placeholder.quantity"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputtelco"
                                             data-telco="TELCO">
                                    </div>
                                    <div class="col-md-2">
                                      <input type="number" min="0" max="50"
                                             name="dtc_am50"
                                             placeholder="<spring:message code="common.placeholder.discount"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputdiscount"
                                             data-telco="TELCO">
                                    </div>
                                    <label class="col-md-1 control-label"><span
                                        class="fr">500000</span></label>
                                    <div class="col-md-2">
                                      <input type="text" name="tc_am500"
                                             placeholder="<spring:message code="common.placeholder.quantity"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputtelco"
                                             data-telco="TELCO">
                                    </div>
                                    <div class="col-md-2">
                                      <input type="number" min="0" max="50"
                                             name="dtc_am500"
                                             placeholder="<spring:message code="common.placeholder.discount"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputdiscount"
                                             data-telco="TELCO">
                                    </div>
                                  </div>
                                  <div class="form-group textTelco">
                                    <label class="col-md-1 control-label"><span
                                        class="fr">1000000</span></label>
                                    <div class="col-md-2">
                                      <input type="text" name="tc_am1000"
                                             placeholder="<spring:message code="common.placeholder.quantity"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputtelco"
                                             data-telco="TELCO">
                                    </div>
                                    <div class="col-md-2">
                                      <input type="number" min="0" max="50"
                                             name="dtc_am1000"
                                             placeholder="<spring:message code="common.placeholder.discount"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputdiscount"
                                             data-telco="TELCO">
                                    </div>

                                    <label class="col-md-1 control-label"><span
                                        class="fr">2000000</span></label>
                                    <div class="col-md-2">
                                      <input type="text" name="tc_am2000"
                                             placeholder="<spring:message code="common.placeholder.quantity"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputtelco"
                                             data-telco="TELCO">
                                    </div>
                                    <div class="col-md-2">
                                      <input type="number" min="0" max="50"
                                             name="dtc_am2000"
                                             placeholder="<spring:message code="common.placeholder.discount"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputdiscount"
                                             data-telco="TELCO">
                                    </div>
                                  </div>
                                </div>
                                <!-- end NHÓM 1 -->

                                <!-- NHÓM 2 -->
                                <div id="idGroup_DATAMOBIFONE" class="hidden-group-card">
                                  <div class="clearfix"></div>
                                  <div class="form-group textTelco">
                                    <label class="col-md-1 control-label"><span
                                        class="fr">10000</span></label>
                                    <div class="col-md-2">
                                      <input type="text" name="tc_am10"
                                             placeholder="<spring:message code="common.placeholder.quantity"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputtelco"
                                             data-telco="DATA_MOBIFONE">
                                    </div>
                                    <div class="col-md-2">
                                      <input type="number" min="0" max="50"
                                             name="dtc_am10" id="DATA_MOBIFONE_dtc_am10"
                                             placeholder="<spring:message code="common.placeholder.discount"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputdiscount"
                                             data-telco="DATA_MOBIFONE">
                                    </div>

                                    <label class="col-md-1 control-label">
                                      <span class="fr">20000</span>
                                    </label>
                                    <div class="col-md-2">
                                      <input type="text" name="tc_am20"
                                             placeholder="<spring:message code="common.title.quantity"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputtelco"
                                             data-telco="DATA_MOBIFONE">
                                    </div>
                                    <div class="col-md-2">
                                      <input type="number" min="0" max="50"
                                             name="dtc_am20" id="DATA_MOBIFONE_dtc_am20"
                                             placeholder="<spring:message code="common.placeholder.discount"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputdiscount"
                                             data-telco="DATA_MOBIFONE">
                                    </div>
                                  </div>
                                  <div class="form-group textTelco">
                                    <label class="col-md-1 control-label">
                                      <span class="fr">50000</span>
                                    </label>
                                    <div class="col-md-2">
                                      <input type="text" name="tc_am50"
                                             placeholder="<spring:message code="common.placeholder.quantity"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputtelco"
                                             data-telco="DATA_MOBIFONE">
                                    </div>
                                    <div class="col-md-2">
                                      <input type="number" min="0" max="50"
                                             name="dtc_am50" id="DATA_MOBIFONE_dtc_am50"
                                             placeholder="<spring:message code="common.placeholder.discount"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputdiscount"
                                             data-telco="DATA_MOBIFONE">
                                    </div>

                                    <label class="col-md-1 control-label">
                                      <span class="fr">200000</span>
                                    </label>
                                    <div class="col-md-2">
                                      <input type="text" name="tc_am200"
                                             placeholder="<spring:message code="common.placeholder.quantity"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputtelco"
                                             data-telco="DATA_MOBIFONE">
                                    </div>
                                    <div class="col-md-2">
                                      <input type="number" min="0" max="50"
                                             name="dtc_am200" id="DATA_MOBIFONE_dtc_am200"
                                             placeholder="<spring:message code="common.placeholder.discount"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputdiscount"
                                             data-telco="DATA_MOBIFONE">
                                    </div>
                                  </div>
                                  <div class="form-group textTelco">
                                    <label class="col-md-1 control-label">
                                      <span class="fr">500000</span>
                                    </label>

                                    <div class="col-md-2">
                                      <input type="text" name="tc_am500"
                                             placeholder="<spring:message code="common.placeholder.quantity"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputtelco"
                                             data-telco="DATA_MOBIFONE">
                                    </div>
                                    <div class="col-md-2">
                                      <input type="number" min="0" max="50"
                                             name="dtc_am500" id="DATA_MOBIFONE_dtc_am500"
                                             placeholder="<spring:message code="common.placeholder.discount"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputdiscount"
                                             data-telco="DATA_MOBIFONE">
                                    </div>

                                  </div>
                                </div>
                                <!-- end NHÓM 2 -->

                                <!-- NHÓM 3 -->
                                <div id="idGroup_DATAVINAPHONE" class="hidden-group-card">
                                  <div class="clearfix"></div>
                                  <div class="form-group textTelco">
                                    <label class="col-md-1 control-label">
                                      <span class="fr">20000</span>
                                    </label>
                                    <div class="col-md-2">
                                      <input type="text" name="tc_am20"
                                             placeholder="<spring:message code="common.placeholder.quantity"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputtelco"
                                             data-telco="DATA_VINAPHONE">
                                    </div>
                                    <div class="col-md-2">
                                      <input type="number" min="0" max="50"
                                             name="dtc_am20" id="DATA_VINAPHONE_dtc_am20"
                                             placeholder="<spring:message code="common.placeholder.discount"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputdiscount"
                                             data-telco="DATA_VINAPHONE">
                                    </div>

                                    <label class="col-md-1 control-label">
                                      <span class="fr">50000</span>
                                    </label>
                                    <div class="col-md-2">
                                      <input type="text" name="tc_am50"
                                             placeholder="<spring:message code="common.title.quantity"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputtelco"
                                             data-telco="DATA_VINAPHONE">
                                    </div>
                                    <div class="col-md-2">
                                      <input type="number" min="0" max="50"
                                             name="dtc_am50" id="DATA_VINAPHONE_dtc_am50"
                                             placeholder="<spring:message code="common.placeholder.discount"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputdiscount"
                                             data-telco="DATA_VINAPHONE">
                                    </div>
                                  </div>
                                  <div class="form-group textTelco">

                                    <label class="col-md-1 control-label">
                                      <span class="fr">100000</span>
                                    </label>
                                    <div class="col-md-2">
                                      <input type="text" name="tc_am100"
                                             placeholder="<spring:message code="common.placeholder.quantity"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputtelco"
                                             data-telco="DATA_VINAPHONE">
                                    </div>
                                    <div class="col-md-2">
                                      <input type="number" min="0" max="50"
                                             name="dtc_am100"
                                             id="DATA_VINAPHONE_dtc_am100"
                                             placeholder="<spring:message code="common.placeholder.discount"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputdiscount"
                                             data-telco="DATA_VINAPHONE">
                                    </div>
                                  </div>
                                </div>
                                <!-- end NHÓM 3 -->

                                <%--nhom 4--%>
                                <div id="idGroup_DATA_VIETTEL" class="hidden-group-card">
                                  <div class="clearfix"></div>
                                  <div class="form-group textTelco">
                                    <label class="col-md-1 control-label">
                                      <span class="fr">40000</span>
                                    </label>
                                    <div class="col-md-2">
                                      <input type="text" name="tc_am40"
                                             placeholder="<spring:message code="common.title.quantity"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputtelco"
                                             data-telco="DATA_VIETTEL">
                                    </div>
                                    <div class="col-md-2">
                                      <input type="number" min="0" max="50"
                                             name="dtc_am40" id="DATA_VIETTEL_dtc_am40"
                                             placeholder="<spring:message code="common.placeholder.discount"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputdiscount"
                                             data-telco="DATA_VIETTEL">
                                    </div>

                                    <label class="col-md-1 control-label">
                                      <span class="fr">70000</span>
                                    </label>
                                    <div class="col-md-2">
                                      <input type="text" name="tc_am70"
                                             placeholder="<spring:message code="common.placeholder.quantity"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputtelco"
                                             data-telco="DATA_VIETTEL">
                                    </div>
                                    <div class="col-md-2">
                                      <input type="number" min="0" max="50"
                                             name="dtc_am70" id="DATA_VIETTEL_dtc_am70"
                                             placeholder="<spring:message code="common.placeholder.discount"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputdiscount"
                                             data-telco="DATA_VIETTEL">
                                    </div>
                                  </div>

                                  <div class="form-group textTelco">
                                  <label class="col-md-1 control-label">
                                    <span class="fr">90000</span>
                                  </label>
                                  <div class="col-md-2">
                                    <input type="text" name="tc_am90"
                                           placeholder="<spring:message code="common.title.quantity"/>"
                                           autocomplete="off"
                                           class="form-control po-line inputtelco"
                                           data-telco="DATA_VIETTEL">
                                  </div>
                                  <div class="col-md-2">
                                    <input type="number" min="0" max="50"
                                           name="dtc_am90" id="DATA_VIETTEL_dtc_am90"
                                           placeholder="<spring:message code="common.placeholder.discount"/>"
                                           autocomplete="off"
                                           class="form-control po-line inputdiscount"
                                           data-telco="DATA_VIETTEL">
                                  </div>

                                  <label class="col-md-1 control-label">
                                    <span class="fr">125000</span>
                                  </label>
                                  <div class="col-md-2">
                                    <input type="text" name="tc_am125"
                                           placeholder="<spring:message code="common.placeholder.quantity"/>"
                                           autocomplete="off"
                                           class="form-control po-line inputtelco"
                                           data-telco="DATA_VIETTEL">
                                  </div>
                                  <div class="col-md-2">
                                    <input type="number" min="0" max="50"
                                           name="dtc_am125" id="DATA_VIETTEL_dtc_am125"
                                           placeholder="<spring:message code="common.placeholder.discount"/>"
                                           autocomplete="off"
                                           class="form-control po-line inputdiscount"
                                           data-telco="DATA_VIETTEL">
                                  </div>
                                </div>
                                  <div class="form-group textTelco">
                                    <label class="col-md-1 control-label">
                                      <span class="fr">200000</span>
                                    </label>
                                    <div class="col-md-2">
                                      <input type="text" name="tc_am200"
                                             placeholder="<spring:message code="common.placeholder.quantity"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputtelco"
                                             data-telco="DATA_VIETTEL">
                                    </div>
                                    <div class="col-md-2">
                                      <input type="number" min="0" max="50"
                                             name="dtc_am200" id="DATA_VIETTEL_dtc_am200"
                                             placeholder="<spring:message code="common.placeholder.discount"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputdiscount"
                                             data-telco="DATA_VIETTEL">
                                    </div>
                                  </div>
                                </div>
                                <%--end nhom 4--%>

                                <!-- NHÓM 5 SCOIN -->
                                <div id="idGroup_SCOIN"
                                     class="hidden-group-card">
                                  <div class="clearfix"></div>
                                  <div class="form-group textTelco">
                                    <label class="col-md-1 control-label"><span
                                        class="fr">10000</span></label>
                                    <div class="col-md-2">
                                      <input type="text"
                                             name="tc_am10"
                                             placeholder="<spring:message code="common.placeholder.quantity"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputtelco"
                                             data-telco="SCOIN">
                                    </div>
                                    <div class="col-md-2">
                                      <input type="number"
                                             min="0"
                                             max="50"
                                             name="dtc_am10" id="SCOIN_dtc_am10"
                                             placeholder="<spring:message code="common.placeholder.discount"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputdiscount"
                                             data-telco="SCOIN">
                                    </div>

                                    <label class="col-md-1 control-label"><span
                                        class="fr">20000</span></label>
                                    <div class="col-md-2">
                                      <input type="text"
                                             name="tc_am20"
                                             placeholder="<spring:message code="common.title.quantity"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputtelco"
                                             data-telco="SCOIN">
                                    </div>
                                    <div class="col-md-2">
                                      <input type="number"
                                             min="0"
                                             max="50"
                                             name="dtc_am20" id="SCOIN_dtc_am20"
                                             placeholder="<spring:message code="common.placeholder.discount"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputdiscount"
                                             data-telco="SCOIN">
                                    </div>
                                  </div>
                                  <div class="form-group textTelco">
                                    <label class="col-md-1 control-label"><span
                                        class="fr">50000</span></label>
                                    <div class="col-md-2">
                                      <input type="text"
                                             name="tc_am50"
                                             placeholder="<spring:message code="common.placeholder.quantity"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputtelco"
                                             data-telco="SCOIN">
                                    </div>
                                    <div class="col-md-2">
                                      <input type="number"
                                             min="0"
                                             max="50"
                                             name="dtc_am50" id="SCOIN_dtc_am50"
                                             placeholder="<spring:message code="common.placeholder.discount"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputdiscount"
                                             data-telco="SCOIN">
                                    </div>
                                    <label class="col-md-1 control-label"><span
                                        class="fr">100000</span></label>
                                    <div class="col-md-2">
                                      <input type="text"
                                             name="tc_am100"
                                             placeholder="<spring:message code="common.placeholder.quantity"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputtelco"
                                             data-telco="SCOIN">
                                    </div>
                                    <div class="col-md-2">
                                      <input type="number"
                                             min="0"
                                             max="50"
                                             name="dtc_am100" id="SCOIN_dtc_am100"
                                             placeholder="<spring:message code="common.placeholder.discount"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputdiscount"
                                             data-telco="SCOIN">
                                    </div>
                                  </div>
                                  <div class="form-group textTelco">
                                    <label class="col-md-1 control-label"><span
                                        class="fr">200000</span></label>
                                    <div class="col-md-2">
                                      <input type="text"
                                             name="tc_am200"
                                             placeholder="<spring:message code="common.placeholder.quantity"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputtelco"
                                             data-telco="SCOIN">
                                    </div>
                                    <div class="col-md-2">
                                      <input type="number"
                                             min="0"
                                             max="50"
                                             name="dtc_am200" id="SCOIN_dtc_am200"
                                             placeholder="<spring:message code="common.placeholder.discount"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputdiscount"
                                             data-telco="SCOIN">
                                    </div>
                                    <label class="col-md-1 control-label"><span
                                        class="fr">500000</span></label>
                                    <div class="col-md-2">
                                      <input type="text"
                                             name="tc_am500"
                                             placeholder="<spring:message code="common.placeholder.quantity"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputtelco"
                                             data-telco="SCOIN">
                                    </div>
                                    <div class="col-md-2">
                                      <input type="number"
                                             min="0"
                                             max="50"
                                             name="dtc_am500" id="SCOIN_dtc_am500"
                                             placeholder="<spring:message code="common.placeholder.discount"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputdiscount"
                                             data-telco="SCOIN">
                                    </div>
                                  </div>
                                  <div class="form-group textTelco">
                                    <label class="col-md-1 control-label"><span
                                        class="fr">1000000</span></label>
                                    <div class="col-md-2">
                                      <input type="text"
                                             name="tc_am1000"
                                             placeholder="<spring:message code="common.placeholder.quantity"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputtelco"
                                             data-telco="SCOIN">
                                    </div>
                                    <div class="col-md-2">
                                      <input type="number"
                                             min="0"
                                             max="50"
                                             name="dtc_am1000" id="SCOIN_dtc_am1000"
                                             placeholder="<spring:message code="common.placeholder.discount"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputdiscount"
                                             data-telco="SCOIN">
                                    </div>

                                    <label class="col-md-1 control-label"><span
                                        class="fr">2000000</span></label>
                                    <div class="col-md-2">
                                      <input type="text"
                                             name="tc_am2000"
                                             placeholder="<spring:message code="common.placeholder.quantity"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputtelco"
                                             data-telco="SCOIN">
                                    </div>
                                    <div class="col-md-2">
                                      <input type="number"
                                             min="0"
                                             max="50"
                                             name="dtc_am2000" id="SCOIN_dtc_am2000"
                                             placeholder="<spring:message code="common.placeholder.discount"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputdiscount"
                                             data-telco="SCOIN">
                                    </div>
                                  </div>
                                  <div class="form-group textTelco">
                                    <label class="col-md-1 control-label"><span
                                        class="fr">5000000</span></label>
                                    <div class="col-md-2">
                                      <input type="text"
                                             name="tc_am5000"
                                             placeholder="<spring:message code="common.placeholder.quantity"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputtelco"
                                             data-telco="SCOIN">
                                    </div>
                                    <div class="col-md-2">
                                      <input type="number"
                                             min="0"
                                             max="50"
                                             name="dtc_am5000" id="SCOIN_dtc_am5000"
                                             placeholder="<spring:message code="common.placeholder.discount"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputdiscount"
                                             data-telco="SCOIN">
                                    </div>
                                  </div>
                                </div>
                                <!-- end NHÓM 5 SCOIN -->

                                <!-- NHÓM 6 SOHACOIN -->
                                <div id="idGroup_SOHACOIN"
                                     class="hidden-group-card">
                                  <div class="clearfix"></div>
                                  <div class="form-group textTelco">
                                    <label class="col-md-1 control-label"><span
                                        class="fr">10000</span></label>
                                    <div class="col-md-2">
                                      <input type="text"
                                             name="tc_am10"
                                             placeholder="<spring:message code="common.placeholder.quantity"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputtelco"
                                             data-telco="SOHA">
                                    </div>
                                    <div class="col-md-2">
                                      <input type="number"
                                             min="0"
                                             max="50"
                                             name="dtc_am10" id="SOHA_dtc_am10"
                                             placeholder="<spring:message code="common.placeholder.discount"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputdiscount"
                                             data-telco="SOHA">
                                    </div>

                                    <label class="col-md-1 control-label"><span
                                        class="fr">20000</span></label>
                                    <div class="col-md-2">
                                      <input type="text"
                                             name="tc_am20"
                                             placeholder="<spring:message code="common.title.quantity"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputtelco"
                                             data-telco="SOHA">
                                    </div>
                                    <div class="col-md-2">
                                      <input type="number"
                                             min="0"
                                             max="50"
                                             name="dtc_am20" id="SOHA_dtc_am20"
                                             placeholder="<spring:message code="common.placeholder.discount"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputdiscount"
                                             data-telco="SOHA">
                                    </div>
                                  </div>
                                  <div class="form-group textTelco">
                                    <label class="col-md-1 control-label"><span
                                        class="fr">50000</span></label>
                                    <div class="col-md-2">
                                      <input type="text"
                                             name="tc_am50"
                                             placeholder="<spring:message code="common.placeholder.quantity"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputtelco"
                                             data-telco="SOHA">
                                    </div>
                                    <div class="col-md-2">
                                      <input type="number"
                                             min="0"
                                             max="50"
                                             name="dtc_am50" id="SOHA_dtc_am50"
                                             placeholder="<spring:message code="common.placeholder.discount"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputdiscount"
                                             data-telco="SOHA">
                                    </div>
                                    <label class="col-md-1 control-label"><span
                                        class="fr">100000</span></label>
                                    <div class="col-md-2">
                                      <input type="text"
                                             name="tc_am100"
                                             placeholder="<spring:message code="common.placeholder.quantity"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputtelco"
                                             data-telco="SOHA">
                                    </div>
                                    <div class="col-md-2">
                                      <input type="number"
                                             min="0"
                                             max="50"
                                             name="dtc_am100" id="SOHA_dtc_am100"
                                             placeholder="<spring:message code="common.placeholder.discount"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputdiscount"
                                             data-telco="SOHA">
                                    </div>
                                  </div>
                                  <div class="form-group textTelco">
                                    <label class="col-md-1 control-label"><span
                                        class="fr">200000</span></label>
                                    <div class="col-md-2">
                                      <input type="text"
                                             name="tc_am200"
                                             placeholder="<spring:message code="common.placeholder.quantity"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputtelco"
                                             data-telco="SOHA">
                                    </div>
                                    <div class="col-md-2">
                                      <input type="number"
                                             min="0"
                                             max="50"
                                             name="dtc_am200" id="SOHA_dtc_am200"
                                             placeholder="<spring:message code="common.placeholder.discount"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputdiscount"
                                             data-telco="SOHA">
                                    </div>
                                    <label class="col-md-1 control-label"><span
                                        class="fr">300000</span></label>
                                    <div class="col-md-2">
                                      <input type="text"
                                             name="tc_am300"
                                             placeholder="<spring:message code="common.placeholder.quantity"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputtelco"
                                             data-telco="SOHA">
                                    </div>
                                    <div class="col-md-2">
                                      <input type="number"
                                             min="0"
                                             max="50"
                                             name="dtc_am300" id="SOHA_dtc_am300"
                                             placeholder="<spring:message code="common.placeholder.discount"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputdiscount"
                                             data-telco="SOHA">
                                    </div>
                                  </div>
                                  <div class="form-group textTelco">
                                    <label class="col-md-1 control-label"><span
                                        class="fr">500000</span></label>
                                    <div class="col-md-2">
                                      <input type="text"
                                             name="tc_am500"
                                             placeholder="<spring:message code="common.placeholder.quantity"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputtelco"
                                             data-telco="SOHA">
                                    </div>
                                    <div class="col-md-2">
                                      <input type="number"
                                             min="0"
                                             max="50"
                                             name="dtc_am500" id="SOHA_dtc_am500"
                                             placeholder="<spring:message code="common.placeholder.discount"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputdiscount"
                                             data-telco="SOHA">
                                    </div>
                                    <label class="col-md-1 control-label"><span
                                        class="fr">1000000</span></label>
                                    <div class="col-md-2">
                                      <input type="text"
                                             name="tc_am1000"
                                             placeholder="<spring:message code="common.placeholder.quantity"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputtelco"
                                             data-telco="SOHA">
                                    </div>
                                    <div class="col-md-2">
                                      <input type="number"
                                             min="0"
                                             max="50"
                                             name="dtc_am1000" id="SOHA_dtc_am1000"
                                             placeholder="<spring:message code="common.placeholder.discount"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputdiscount"
                                             data-telco="SOHA">
                                    </div>
                                  </div>
                                  <div class="form-group textTelco">
                                    <label class="col-md-1 control-label"><span
                                        class="fr">2000000</span></label>
                                    <div class="col-md-2">
                                      <input type="text"
                                             name="tc_am2000"
                                             placeholder="<spring:message code="common.placeholder.quantity"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputtelco"
                                             data-telco="SOHA">
                                    </div>
                                    <div class="col-md-2">
                                      <input type="number"
                                             min="0"
                                             max="50"
                                             name="dtc_am2000" id="SOHA_dtc_am2000"
                                             placeholder="<spring:message code="common.placeholder.discount"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputdiscount"
                                             data-telco="SOHA">
                                    </div>

                                    <label class="col-md-1 control-label"><span
                                        class="fr">5000000</span></label>
                                    <div class="col-md-2">
                                      <input type="text"
                                             name="tc_am5000"
                                             placeholder="<spring:message code="common.placeholder.quantity"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputtelco"
                                             data-telco="SOHA">
                                    </div>
                                    <div class="col-md-2">
                                      <input type="number"
                                             min="0"
                                             max="50"
                                             name="dtc_am5000" id="SOHA_dtc_am5000"
                                             placeholder="<spring:message code="common.placeholder.discount"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputdiscount"
                                             data-telco="SOHA">
                                    </div>
                                  </div>
                                </div>
                                <!-- end NHÓM 6 SOHACOIN -->

                                <!-- NHÓM 7 FUNCARD -->
                                <div id="idGroup_FUNCARD"
                                     class="hidden-group-card">
                                  <div class="clearfix"></div>
                                  <div class="form-group textTelco">
                                    <label class="col-md-1 control-label"><span
                                        class="fr">10000</span></label>
                                    <div class="col-md-2">
                                      <input type="text"
                                             name="tc_am10"
                                             placeholder="<spring:message code="common.placeholder.quantity"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputtelco"
                                             data-telco="FUNCARD">
                                    </div>
                                    <div class="col-md-2">
                                      <input type="number"
                                             min="0"
                                             max="50"
                                             name="dtc_am10" id="FUNCARD_dtc_am10"
                                             placeholder="<spring:message code="common.placeholder.discount"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputdiscount"
                                             data-telco="FUNCARD">
                                    </div>

                                    <label class="col-md-1 control-label"><span
                                        class="fr">20000</span></label>
                                    <div class="col-md-2">
                                      <input type="text"
                                             name="tc_am20"
                                             placeholder="<spring:message code="common.title.quantity"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputtelco"
                                             data-telco="FUNCARD">
                                    </div>
                                    <div class="col-md-2">
                                      <input type="number"
                                             min="0"
                                             max="50"
                                             name="dtc_am20" id="FUNCARD_dtc_am20"
                                             placeholder="<spring:message code="common.placeholder.discount"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputdiscount"
                                             data-telco="FUNCARD">
                                    </div>
                                  </div>
                                  <div class="form-group textTelco">
                                    <label class="col-md-1 control-label"><span
                                        class="fr">50000</span></label>
                                    <div class="col-md-2">
                                      <input type="text"
                                             name="tc_am50"
                                             placeholder="<spring:message code="common.placeholder.quantity"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputtelco"
                                             data-telco="FUNCARD">
                                    </div>
                                    <div class="col-md-2">
                                      <input type="number"
                                             min="0"
                                             max="50"
                                             name="dtc_am50" id="FUNCARD_dtc_am50"
                                             placeholder="<spring:message code="common.placeholder.discount"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputdiscount"
                                             data-telco="FUNCARD">
                                    </div>
                                    <label class="col-md-1 control-label"><span
                                        class="fr">100000</span></label>
                                    <div class="col-md-2">
                                      <input type="text"
                                             name="tc_am100"
                                             placeholder="<spring:message code="common.placeholder.quantity"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputtelco"
                                             data-telco="FUNCARD">
                                    </div>
                                    <div class="col-md-2">
                                      <input type="number"
                                             min="0"
                                             max="50"
                                             name="dtc_am100" id="FUNCARD_dtc_am100"
                                             placeholder="<spring:message code="common.placeholder.discount"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputdiscount"
                                             data-telco="FUNCARD">
                                    </div>
                                  </div>
                                  <div class="form-group textTelco">
                                    <label class="col-md-1 control-label"><span
                                        class="fr">200000</span></label>
                                    <div class="col-md-2">
                                      <input type="text"
                                             name="tc_am200"
                                             placeholder="<spring:message code="common.placeholder.quantity"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputtelco"
                                             data-telco="FUNCARD">
                                    </div>
                                    <div class="col-md-2">
                                      <input type="number"
                                             min="0"
                                             max="50"
                                             name="dtc_am200" id="FUNCARD_dtc_am200"
                                             placeholder="<spring:message code="common.placeholder.discount"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputdiscount"
                                             data-telco="FUNCARD">
                                    </div>

                                    <label class="col-md-1 control-label"><span
                                        class="fr">500000</span></label>
                                    <div class="col-md-2">
                                      <input type="text"
                                             name="tc_am500"
                                             placeholder="<spring:message code="common.placeholder.quantity"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputtelco"
                                             data-telco="FUNCARD">
                                    </div>
                                    <div class="col-md-2">
                                      <input type="number"
                                             min="0"
                                             max="50"
                                             name="dtc_am500" id="FUNCARD_dtc_am500"
                                             placeholder="<spring:message code="common.placeholder.discount"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputdiscount"
                                             data-telco="FUNCARD">
                                    </div>
                                  </div>
                                  <div class="form-group textTelco">
                                    <label class="col-md-1 control-label"><span
                                        class="fr">1000000</span></label>
                                    <div class="col-md-2">
                                      <input type="text"
                                             name="tc_am1000"
                                             placeholder="<spring:message code="common.placeholder.quantity"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputtelco"
                                             data-telco="FUNCARD">
                                    </div>
                                    <div class="col-md-2">
                                      <input type="number"
                                             min="0"
                                             max="50"
                                             name="dtc_am1000" id="FUNCARD_dtc_am1000"
                                             placeholder="<spring:message code="common.placeholder.discount"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputdiscount"
                                             data-telco="FUNCARD">
                                    </div>

                                    <label class="col-md-1 control-label"><span
                                        class="fr">2000000</span></label>
                                    <div class="col-md-2">
                                      <input type="text"
                                             name="tc_am2000"
                                             placeholder="<spring:message code="common.placeholder.quantity"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputtelco"
                                             data-telco="FUNCARD">
                                    </div>
                                    <div class="col-md-2">
                                      <input type="number"
                                             min="0"
                                             max="50"
                                             name="dtc_am2000" id="FUNCARD_dtc_am2000"
                                             placeholder="<spring:message code="common.placeholder.discount"/>"
                                             autocomplete="off"
                                             class="form-control po-line inputdiscount"
                                             data-telco="FUNCARD">
                                    </div>
                                  </div>
                                </div>
                                <!-- end NHÓM 7 FUNCARD -->
                              </div>

                              <div class="row content-body-wrap">
                                <div class="col-md-12 col-lg-12 col-xl-12">
                                  <div class="panel-body edit_profile">
                                    <div class="form-group report_search_bt">
                                      <a href="#" class="fr add-tel-po">
                                        <i class="fa fa-plus"></i>&nbsp;<spring:message
                                          code="common.btn.Add"/>
                                      </a>
                                    </div>
                                  </div>
                                </div>
                              </div>


                              <!-- action btn-add-po click -->
                              <script type="text/javascript">
                                $(document).ready(function () {
                                  $('form[name=telco] input[name=provider]').val(
                                      $('select[name=provider]').val());
                                  $("div.report_search_form span.fr").each(function () {
                                    val = $(this).html();
                                    $(this).html(formatNumberSeparator(val, "${locale}"));
                                  });

                                  function getValueFromName(name) {
                                    if (name === 'tc_am10') return '10000';
                                    else if (name === 'tc_am20') return '20000';
                                    else if (name === 'tc_am30') return '30000';
                                    else if (name === 'tc_am40') return '40000';
                                    else if (name === 'tc_am50') return '50000';
                                    else if (name === 'tc_am70') return '70000';
                                    else if (name === 'tc_am90') return '90000';
                                    else if (name === 'tc_am100') return '100000';
                                    else if (name === 'tc_am200') return '200000';
                                    else if (name === 'tc_am300') return '300000';
                                    else if (name === 'tc_am500') return '500000';
                                    else if (name === 'tc_am1000') return '1000000';
                                    else if (name === 'tc_am2000') return '2000000';
                                    else if (name === 'tc_am5000') return '5000000';
                                    else if (name === 'tc_am1') return '1000';
                                    else if (name === 'tc_am2') return '2000';
                                    else if (name === 'tc_am3') return '3000';
                                    else if (name === 'tc_am5') return '5000';
                                    else if (name === 'tc_am14') return '14000';
                                    else if (name === 'tc_am28') return '28000';
                                    else if (name === 'tc_am42') return '42000';
                                    else if (name === 'tc_am56') return '56000';
                                    else if (name === 'tc_am84') return '84000';
                                    else if (name === 'tc_am70') return '70000';
                                    else if (name === 'tc_am120') return '120000';
                                    else if (name === 'tc_am125') return '125000';
                                    else if (name === 'tc_am150') return '150000';
                                  }

                                  function getNameFromValue(value) {
                                    if (value === '10000') return 'tc_am10';
                                    else if (value === '20000') return 'tc_am20';
                                    else if (value === '30000') return 'tc_am30';
                                    else if (value === '40000') return 'tc_am40';
                                    else if (value === '50000') return 'tc_am50';
                                    else if (value === '70000') return 'tc_am70';
                                    else if (value === '90000') return 'tc_am90';
                                    else if (value === '100000') return 'tc_am100';
                                    else if (value === '200000') return 'tc_am200';
                                    else if (value === '300000') return 'tc_am300';
                                    else if (value === '500000') return 'tc_am500';
                                    else if (value === '1000000') return 'tc_am1000';
                                    else if (value === '2000000') return 'tc_am2000';
                                    else if (value === '5000000') return 'tc_am5000';
                                    else if (value === '1000') return 'tc_am1';
                                    else if (value === '2000') return 'tc_am2';
                                    else if (value === '3000') return 'tc_am3';
                                    else if (value === '5000') return 'tc_am5';
                                    else if (value === '14000') return 'tc_am14';
                                    else if (value === '28000') return 'tc_am28';
                                    else if (value === '42000') return 'tc_am42';
                                    else if (value === '56000') return 'tc_am56';
                                    else if (value === '84000') return 'tc_am84';
                                    else if (value === '70000') return 'tc_am70';
                                    else if (value === '120000') return 'tc_am120';
                                    else if (value === '125000') return 'tc_am125';
                                    else if (value === '150000') return 'tc_am150';
                                  }

                                  $('input.inputtelco').focus(function () {
                                    if ($('.telco input[name=telco]:checked').length < 1) {
                                      $.MessageBox(
                                          {message: "<spring:message code="message.choose.a.provider.pl"/> "});
                                    }
                                  });

                                  $('.add-tel-po').click(function () {
                                    if ($('#inputtel').valid()) {
                                      if ($('.telco input[name=telco]:checked').length > 0) {
                                        var telco = $('.telco input[name=telco]:checked').val();
                                        var i = $(
                                            '.po-detail-line table tbody tr:last td:first').text();
                                        if (i == null || i === '') i = 0;
                                        var poLine = "";
                                        var strAction = '<td class="action_icon center"><a href="javascript:;"><i class="fa fa-times"></i></a></td>';
                                        var bDiscount = true;
                                        $('.inputtelco').each(function (index, value) {
                                          var quantity = $(this).val().trim();
                                          var name = $(this).attr('name');
                                          var typeCard = $(this).data('telco');
                                          var value = getValueFromName(name);
                                          if (quantity !== '0' && quantity !== '') {
                                            var discount = (telco === typeCard) ? $("input[id="
                                                + typeCard + "_d" + name + "]").val()
                                                : $("input[name=d" + name + "]").val();
                                            if (discount != null && discount !== '') {
                                              $('tr.' + telco + '-' + value).remove();
                                              var capitalValue = Math.ceil(quantity * value * (1
                                                  - discount / 100));
                                              i++;
                                              poLine += '<tr class="' + telco + '-' + value + '">';
                                              poLine += '<td class="stt">' + i + '</td>' +
                                                  '<td>' + telco.toLocaleString('en-US')
                                                  + '<input type="hidden" name="telco_' + i
                                                  + '" value="' + telco + '" /></td>' +
                                                  '<td class="text-right">' + formatNumberSeparator(
                                                      value, "${locale}")
                                                  + '<input type="hidden" name="value_' + i
                                                  + '" value="' + value + '" /></td>' +
                                                  '<td class="text-right">' + formatNumberSeparator(
                                                      quantity, "${locale}")
                                                  + '<input type="hidden" name="quantity_' + i
                                                  + '" value="' + quantity + '" /></td>' +
                                                  '<td class="text-right">' + discount
                                                  + '<input type="hidden" name="discount_' + i
                                                  + '" value="' + discount + '" /></td>' +
                                                  '<td class="text-right">' + formatNumberSeparator(
                                                      capitalValue, "${locale}") + '</td>' +
                                                  strAction;
                                              poLine += '</tr>';
                                              $('.quantity_'.concat(i)).val(quantity);
                                              $('.discount_'.concat(i)).val(discount);
                                            } else {
                                              bDiscount = false;
                                            }
                                          }
                                        });
                                        if (!bDiscount) $.MessageBox(
                                            {message: "<spring:message code="message.pl.input.discount.rate"/> "});
                                        $('.po-detail-line table tbody').append(poLine);
                                        renameTable();
                                      }
                                      else {
                                        $.MessageBox(
                                            {message: "<spring:message code="message.choose.provider" />"});
                                      }
                                      return false;
                                    }
                                  });

                                  //select box nha cung cap po-next-step
                                  $('select[name=provider]').change(function () {
                                    $('form[name=telco] input[name=provider]').val(
                                        $('select[name=provider]').val());
                                    renameTable();
                                    if ($('.telco input[name=telco]:checked').length > 0) {
                                      $("div.textTelco input").val('');
                                      var telco = $('.telco input[name=telco]:checked').val();
                                      var provider = $('select[name=provider]').val();
                                      $.post('findProviderProfiles', {provider: provider},
                                          function (data) {
                                            if (data != null && data.status.code === 0) {
                                              var profiles = data.providerProfiles;
                                              if (profiles != null && profiles[0] != null) {
                                                var discountRates = profiles[0].discountRates;
                                                var discountRate = null;
                                                if (discountRates[telco] != null) {
                                                  discountRate = discountRates[telco];
                                                }
                                                for (name in discountRate) {
                                                  $('input[name=d' + getNameFromValue(name)
                                                      + ']').val(discountRate[name]);
                                                }
                                              }
                                            }
                                          });
                                    }
                                  });
                                  $(document).on('click', 'td.action_icon a', function () {
                                    $(this).closest('tr').remove();
                                    renameTable();
                                  });

                                  function renameTable() {
                                    var istt = 0;
                                    var totalQuatity = 0;
                                    var totalMoney = 0;
                                    var totalCapital = 0;
                                    $('.po-detail-line table tbody tr').each(
                                        function (index, value) {
                                          istt = index + 1;
                                          $(value).find('td.stt').html(istt);
                                          $(value).find('input[name*=value_]').attr('name', 'value_'
                                              + istt);
                                          $(value).find('input[name*=telco_]').attr('name', 'telco_'
                                              + istt);
                                          $(value).find('input[name*=quantity_]').attr(
                                              'name', 'quantity_' + istt);
                                          $(value).find('input[name*=discount_]').attr(
                                              'name', 'discount_' + istt);
                                          var quantity = parseInt(
                                              $(value).find('input[name*=quantity_]').val());
                                          var money = parseInt(
                                              $(value).find('input[name*=value_]').val())
                                              * quantity;
                                          var discount = parseFloat(
                                              $(value).find('input[name*=discount_]').val());
                                          var capitalValue = Math.ceil(money * (1 - discount
                                              / 100));
                                          totalCapital += capitalValue;
                                          totalQuatity += parseInt(
                                              $(value).find('input[name*=quantity_]').val());
                                          totalMoney += money;
                                        });
                                    if (totalQuatity > 150000)
                                      $.MessageBox(
                                          {message: 'Cảnh báo : Số lượng 1 phiếu nhập ko được vượt quá 150,000 !'});
                                    $("b.b-quantity").html(
                                        formatNumberSeparator(totalQuatity, "${locale}"));
                                    $("b.b-money").html(
                                        formatNumberSeparator(totalMoney, "${locale}"));
                                    $("b.b-capital").html(
                                        formatNumberSeparator(totalCapital, "${locale}"));
                                    var d = new Date();
                                    var month = d.getMonth() + 1;
                                    var textMoney = totalMoney / 1000;
                                    var hours24 = (d.getHours() > 9) ? d.getHours() : '0'
                                        + d.getHours();
                                    var minutes24 = (d.getMinutes() > 9) ? d.getMinutes() : '0'
                                        + d.getMinutes();
                                    var dates30 = (d.getDate() > 9) ? d.getDate() : '0'
                                        + d.getDate();
                                    var yearYY = d.getFullYear() - 2000;
                                    var pocode = $('select[name=provider]').val() + '-' + yearYY
                                        + month + dates30 + hours24 + minutes24 + '-' + totalQuatity
                                        + '-' + textMoney;
                                    $("b.b-pocode").html(pocode);
                                    $("input[name=poCode]").val(pocode);
                                    $('form[name=telco] input[name=totalTelco]').val(istt);
                                    return istt;
                                  }

                                  //choose loai the
                                  $('input[name=telco]').click(function () {
                                    $("div.textTelco input").val('');
                                    var telco = $(this).val();
                                    var provider = $('select[name=provider]').val();
                                    $.post('findProviderProfiles', {provider: provider},
                                        function (data) {
                                          if (data != null && data.status.code === 0) {
                                            var profiles = data.providerProfiles;
                                            if (profiles != null && profiles[0] != null) {
                                              var discountRates = profiles[0].discountRates;
                                              var discountRate = null;
                                              if (discountRates[telco] != null) {
                                                discountRate = discountRates[telco];
                                              }
                                              for (name in discountRate) {
                                                $('input[name=d' + getNameFromValue(name)
                                                    + ']').val(discountRate[name]);
                                              }
                                            }
                                          }
                                        });
                                  });
                                  $(".textTelco input[type=number]").keypress(function () {
                                    if ($(this).val().length > 3) {
                                      return false;
                                    }
                                  });
                                  $('form[name="telco"]').submit(function () {
                                    /*if(!$('#checkboxExample3').is(':checked')){
                                     $.MessageBox({message: "Chưa xác nhận lập phiếu!"})
                                     return false;
                                     }*/
                                  });
                                });
                              </script>
                              <!-- /action btn-add-po click -->
                            </div>
                          </section>
                        </div>
                        <sec:csrfInput/>
                      </form>
                      <form name="telco"
                            action="${pageContext.request.contextPath}/provider/purchase-order/add"
                            method="post" enctype="multipart/form-data">
                        <input type="hidden" name="totalTelco"
                               value="${responsePO.poDetailItem.size() }"/>
                        <input type="hidden" name="pathFile"
                               value="${responsePO.poItem.filePath }"/>
                        <input type="hidden" name="reImportation" id="reImportation" value="0"/>
                        <input type="hidden" name="checkBoxSpecialCard"
                               id="hidden_checkBoxSpecialCard" value="0"/>
                        <input type="hidden" name="poCode" value=""/>

                        <div class="col-md-12 col-lg-12 col-xl-12">
                          <div class="tab-content pl-none pr-none">
                            <div id="tab1" class="tab-pane active">

                              <section class="panel panel-default po-detail-line">

                                <h4 style="font-size: 13px;" class="mt-sm">
                                  <b hidden class="b-pocode"></b>
                                  <spring:message code="common.title.total.face.value"/>&nbsp;<span
                                    class="primary_color text-semibold"><b class="b-money">0</b><b>&nbsp;VND</b></span>&nbsp;|
                                  <spring:message code="common.quantity"/>&nbsp; <span
                                    class="primary_color text-semibold"><b class="b-quantity">0</b></span>
                                  |
                                  <spring:message
                                      code="common.title.total.capital.value"/>&nbsp;<span
                                    class="primary_color text-semibold"><b
                                    class="b-capital">0</b><b>&nbsp;VND</b></span>
                                </h4>


                                <div class="panel-body" id="panel-declare">
                                  <div class="table-responsive">
                                    <table class="table table-bordered table-striped mb-none">
                                      <thead>
                                      <tr>
                                        <th><spring:message code="purchase.table.no"/></th>
                                        <th style="width:10%"><spring:message
                                            code="purchase.table.card.type"/></th>
                                        <th class="text-right"><spring:message
                                            code="purchase.table.face.value"/></th>
                                        <th class="text-right"><spring:message
                                            code="purchase.table.quantity"/></th>
                                        <th class="text-right"><spring:message
                                            code="purchase.table.discount"/></th>
                                        <th class="text-right"><spring:message
                                            code="purchase.table.capital.value"/></th>
                                        <th class="center"><spring:message
                                            code="purchase.table.action"/></th>
                                      </tr>
                                      </thead>
                                      <tbody>
                                      <c:forEach var="item" items="${responsePO.poDetailItem }"
                                                 varStatus="status">
                                        <input type="hidden" name="telco_${status.index +1}"
                                               value="${item.cardType }"/>
                                        <input type="hidden" name="value_${status.index +1}"
                                               value="${item.faceValue }"/>
                                        <input type="hidden" name="quantity_${status.index +1}"
                                               value="${item.quantity }"/>
                                        <tr class="${item.cardType }">
                                          <td class="stt">${status.index +1}</td>
                                          <td>${item.cardType }</td>
                                          <td><fmt:formatNumber type="number" var="faceValue"
                                                                value="${item.faceValue }"/>${faceValue }</td>
                                          <td>${item.quantity }</td>
                                          <td class="action_icon"><a href="javascript:;"><i
                                              class="fa fa-times"></i></a></td>
                                        </tr>
                                      </c:forEach>
                                      </tbody>
                                    </table>
                                  </div>
                                </div>

                                <%--tab 2--%>
                                <div class="panel-body edit_profile" id="panel-upload"
                                     style="display: none;">

                                  <div class="form-group">
                                    <label class="col-md-1 control-label">*<spring:message
                                        code="common.note"/></label>
                                    <div class="col-md-4 tertiary_color">
                                      <spring:message code="common.title.guild"/>
                                      <i class="fa  fa-question-circle text-muted m-xs "
                                         data-toggle="popover"
                                         data-trigger="hover"
                                         data-placement="top"
                                         data-content='<spring:message code="common.title.step1.choose.file.format.file"/>.<br />
																								<spring:message code="common.title.step2.fill.the.content.in.more.information"/><br />
																								<spring:message code="common.title.step3.click.confirm.to.create.receipt"/><br />
																								<spring:message code="common.title.step4.click.confirm.to.moving.step.verify"/>'
                                         data-html="true" data-original-title="" title=""></i>
                                    </div>
                                  </div>
                                  <div class="form-group mb-none">
                                    <label class="col-md-3 control-label"><spring:message
                                        code="common.title.file"/> </label>
                                    <div class="col-md-6">
                                      <input type="file" name="file" id="file-2"
                                             class="inputfile inputfile-2"
                                             data-multiple-caption="{count} files selected"
                                             multiple/>
                                      <label for="file-2"><i class="fa fa-upload"
                                                             aria-hidden="true"></i><span><spring:message
                                          code="common.btn.choose.file"/> </span></label>
                                      <p><strong class="secondary_color"><5mb </strong>(*.xls,*.xlsx,*.txt,*.dat,*.csv)
                                      </p>
                                    </div>
                                  </div>
                                  <!-- div show file -->
                                  <div class="form-group">
                                    <div class="col-md-3"></div>
                                    <div class="col-md-6 fileshow"></div>
                                  </div>
                                  <jsp:include page="dowloadTemplete.jsp"/>

                                  <div class="form-group">
                                    <label class="col-md-3 control-label"
                                           for="textareaDefault"><spring:message
                                        code="common.reason"/></label>
                                    <div class="col-md-4">
                                      <textarea name="note" class="form-control" rows="3"
                                                id="textareaDefault"></textarea>
                                    </div>
                                  </div>

                                  <div class="form-group show-data-special-merchant">
                                    <label class="col-md-3 control-label"
                                           for="listSpecialMerchant"><spring:message
                                        code="po.select.special.customer"/></label>
                                    <div class="col-md-4">
                                      <textarea name="listSpecialMerchant" class="form-control" disabled
                                                rows="3"
                                                id="listSpecialMerchant">${dataListSelectMerchant}</textarea>
                                    </div>
                                  </div>

                                  <div class="alert alert-default mb-none mt-md p-sm">
                                    <div class="checkbox-custom checkbox-success">
                                      <input type="checkbox" name="ckaccess" id="checkboxExample3">
                                      <label for="checkboxExample3"><spring:message
                                          code="common.confirm.to.upload.file"/></label>
                                    </div>
                                  </div>
                                  <div class="form-group report_search_bt pb-none">
                                    <button type="submit" class="fr mr-none submit_bt">
                                      <spring:message code="common.btn.submit"/>&nbsp;<i
                                        class="fa fa-arrow-right"></i></button>
                                    <button type="button" id="stepprevious"
                                            class="fr mr-sm submit_bt nomal_color_bk"><i
                                        class="fa fa-arrow-left"></i>&nbsp;<spring:message
                                        code="common.btn.back"/></button>
                                  </div>

                                  <script>
                                    $(document).ready(function () {
                                      $('form').submit(function () {
                                        if (!$('#checkboxExample3').is(':checked')) {
                                          $.MessageBox(
                                              {message: "<spring:message code="common.unconfirmed.upload.file"/>"});
                                          return false;
                                        }
                                      });
                                      $('form input:file').change(function (click) {
                                        var files = $(this)[0].files;
                                        var exts = ['txt', 'xls', 'xlsx', 'dat', 'csv'];
                                        var extsExcel = ['xls', 'xlsx'];
                                        var checkExt = true;
                                        var iExcel = 0;
                                        if (files.length > 0) {
                                          for (var i = 0; i < files.length; i++) {
                                            if (files[i].name.length < 71) {
                                              var get_ext = files[i].name.split('.');
                                              // reverse name to check extension
                                              get_ext = get_ext.reverse();
                                              // check file type is valid as given in 'exts' array
                                              if ($.inArray(get_ext[0].toLowerCase(), exts) < 0) {
                                                checkExt = false;
                                              }
                                              if ($.inArray(get_ext[0].toLowerCase(), extsExcel)
                                                  > -1) {
                                                iExcel++;
                                              }
                                            } else {
                                              $.MessageBox(
                                                  {message: '<spring:message code="message.file.name.can.not.be.longer.than.70.characters"/>'});
                                              $(this).val('');
                                            }
                                          }
                                          if (!checkExt) {
                                            $.MessageBox(
                                                {message: '<spring:message code="common.upload.file.not.format"/>'});
                                            $(this).val('');
                                          } else {
                                            if (iExcel > 1) {
                                              $.MessageBox(
                                                  {message: '<spring:message code="common.only.1.execl.file.uploaded"/>'});
                                              $(this).val('');
                                            }
                                          }
                                        }
                                      });
                                      var inputs = document.querySelectorAll('.inputfile');
                                      Array.prototype.forEach.call(inputs, function (input) {
                                        var label = input.nextElementSibling,
                                            labelVal = label.innerHTML;
                                        input.addEventListener('change', function (e) {
                                          $('div.fileshow').html('');
                                          var fileName = '';
                                          if (this.files && this.files.length > 1)
                                            fileName = (this.getAttribute('data-multiple-caption')
                                                || '').replace('{count}', this.files.length);
                                          else
                                            fileName = e.target.value.split('\\').pop();
                                          if (fileName)
                                            label.querySelector('span').innerHTML = fileName;
                                          else
                                            label.innerHTML = labelVal;
                                          if (this.files && this.files.length > 0) {
                                            $.each(e.target.files, function (idx, elm) {
                                              var size = elm.size / 1024;
                                              $('div.fileshow').append('<p class="primary_color">'
                                                  + elm.name + ' - size : ' + size + 'KB</p>')
                                            });
                                          }
                                        });
                                      });
                                    });
                                  </script>
                                </div>
                                <%--end tab 2--%>

                              </section>
                            </div>
                          </div>

                          <%--fix comment check reImport card  divReloadCardStore hidden--%>
                          <c:if test="${'true' eq MENU_ITEM_SHOW_CARD_STORE_OFF_LINE}">
                            <div class="alert alert-default mb-none mt-md p-sm divReloadCardStore">
                              <div class="checkbox-custom checkbox-success">
                                <input type="checkbox" name="ckReloadCardStore"
                                       id="ckReloadCardStore">
                                <label for="ckReloadCardStore"><spring:message
                                    code="common.title.confirm.reEnter.CardStore"/></label>
                              </div>
                            </div>
                          </c:if>

                          <div class="form-group alert alert-default mb-none mt-md p-sm divShowGroupChkSpecialCard">
                            <div class="col-md-3 divCheckBoxSpecialCard">
                              <div class="checkbox-custom checkbox-success">
                                <input type="checkbox" name="ckSpecialCard" id="ckSpecialCard">
                                <label for="ckSpecialCard"><spring:message
                                    code="po.special.card"/></label>
                              </div>
                            </div>

                            <div class="col-md-4 show-customer-special">
                              <c:set var="allSpecialCustomer" value=","/>
                              <c:forEach var="st" items="${paramValues.specialCustomer}">
                                <c:set var="allSpecialCustomer"
                                       value="${allSpecialCustomer}${st},"/>
                              </c:forEach>
                              <select class="form-control multiple-select hidden"
                                       <%--multiple = "multiple"--%> id="specialCustomer"
                                      name="specialCustomer">
                                <option value = "" ><spring:message code="po.select.special.customer"/></option>
                                <c:choose>
                                  <c:when
                                      test="${not empty listSpecialCustomer && listSpecialCustomer.size() > 0 }">
                                    <c:forEach var="item" items="${listSpecialCustomer}">
                                      <option value="${item.cif}" ${fn:contains(allSpecialCustomer, item.cif) ? 'selected' : ''}>${item.displayName} (${item.cif})</option>
                                    </c:forEach>
                                  </c:when>
                                  <c:otherwise>
                                    <option value="">N/A</option>
                                  </c:otherwise>
                                </c:choose>
                              </select>
                            </div>
                          </div>

                          <div class="row content-body-wrap">
                            <div class="col-md-12 col-lg-12 col-xl-12">
                              <div class="panel-body edit_profile">
                                <input type="hidden" name="id" value="${param.id }"/>
                                <input type="hidden" name="provider"/>
                                <a class="mt-md btn btn-success fr po-next-step" id="stepnext"
                                   href="#"><spring:message code="common.btn.next"/>&nbsp;<i
                                    class="fa fa-arrow-right"></i></a>
                              </div>
                            </div>
                          </div>
                        </div>
                        <sec:csrfInput/>
                      </form>
                    </div>
                  </div>
                </section>
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
<spring:message code="popup.button.yes" var="btYes"/>
<spring:message code="select.choose.all" var="sel_all"/>
<script>
  $(document).ready(function () {
    $("input[type='number']").prop({disabled: true});

    $('.show-customer-special').hide();

    $('#ckReloadCardStore').click(function () {
      var telco = "";
      if ($('.telco input[name=telco]:checked').length > 0) {
        telco = $('.telco input[name=telco]:checked').val();
      }
      if ($('#inputtel').valid()) {
        if ($('input[name=ckReloadCardStore]:checked').length > 0) {
          $.MessageBox({
            buttonDone: {
              btYes: {
                text: "${btYes}",
                class: "custom_button",
                keyCode: 13
              }
            },
            buttonFail: '<spring:message code="popup.button.cancel"/>',
            buttonsOrder: "fail done",
            message: '<spring:message code="popup.message.confirm.reEnter.Card"/>'
          }).done(function () {
            $('#reImportation').val('1');
          }).fail(function () {
            $('#reImportation').val('0');
            $('input[name=ckReloadCardStore]:checked').attr('checked', false);
          });
        } else {
          $('#reImportation').val('0');
        }
      }
    });

    $("#stepnext").click(function () {
      var confirm = true;
      var i = $('.po-detail-line table tbody tr:last td:first').text();

      //valide reImport
      var reImport = $('input[name=ckReloadCardStore]:checked').length > 0 ? ($(
          '#selProvider').val() === 'ZOTA') : true;

      if (i == null || i === '') confirm = false;
      if (confirm && reImport) {
        $('#titleDeclarePO').val('Upload File');
        showStep2();
      } else {
        if (!reImport) {
          $.MessageBox({message: '<spring:message code="message.declare.reimport.invalide"/>'});
        } else {
          $.MessageBox(
              {message: '<spring:message code="message.declare.the.information.BF.moving.to.the.next.step"/>'});
        }

      }
      return false;
    });

    $('#declare_po').click(function () {
      $('#titleDeclarePO').val('Declare Perchase Order');
      showStep1();
      return false;
    });

    $("#stepprevious").click(function () {
      showStep1();
      $('#titleDeclarePO').val('Declare Perchase Order');
      return false;
    });

    $('#upload_po').click(function () {
      var confirm = true;
      var i = $('.po-detail-line table tbody tr:last td:first').text();
      if (i == null || i === '') confirm = false;
      if (confirm) {
        $('#titleDeclarePO').val('Upload File');
        showStep2();
      }
      else {
        $.MessageBox(
            {message: '<spring:message code="message.declare.the.information.BF.moving.to.the.next.step"/>'});
      }
      return false;
    });

    function showStep2() {
      /*lấy ds private customer*/
      var dataListSelectMerchant = [];
      var specialCustomer = $('#specialCustomer option:selected');
      for (var i = 0; i < specialCustomer.length; ++i) {
        var itemValue = specialCustomer[i].value;
        var itemLabel = specialCustomer[i].label;
        if(itemValue !== ""){
          dataListSelectMerchant.push(itemLabel);
        }
      }

      $('#listSpecialMerchant').val(dataListSelectMerchant);

      if($('#hidden_checkBoxSpecialCard').val() =='1'){
        $('.show-data-special-merchant').show();
      }else{
        $('.show-data-special-merchant').hide();
      }
      /*end lấy ds private customer*/

      //valide lô thẻ riêng cho customer special
      var lstSpecialMerchant = $('#listSpecialMerchant').val();
      var chkLoTheRieng = $('#hidden_checkBoxSpecialCard').val()
      if (chkLoTheRieng == '1' && (lstSpecialMerchant == undefined || lstSpecialMerchant == 'null'
              || lstSpecialMerchant == '' || lstSpecialMerchant =='N/A')) {
        $.MessageBox({message: '<spring:message code="message.create.you.must.choose.a.special.merchant"/>'});
      }
      else {
        $('#panel-upload').show();
        $('#declare_po').parent().removeClass("active");
        $('#upload_po').parent().addClass("active");
        $("#stepnext").hide();
        $('#inputtel').hide();
        $('#panel-declare').hide();
        $('.divReloadCardStore').hide();
        $('.divShowGroupChkSpecialCard').hide();
        $('.divCheckBoxSpecialCard').hide();
        $('.show-customer-special').hide();
      }

    }

    function showStep1() {
      $('#panel-upload').hide();
      $('#declare_po').parent().addClass("active");
      $('#upload_po').parent().removeClass("active");
      $("#stepnext").show();
      $('#inputtel').show();
      $('#panel-declare').show();
      $('.divReloadCardStore').show();
      $('.divCheckBoxSpecialCard').show();
      $('.divShowGroupChkSpecialCard').show();

      if($('#hidden_checkBoxSpecialCard').val() =='1'){
//        $('.divShowGroupChkSpecialCard').show();
        $('.show-customer-special').show();
      }else{
//        $('.divShowGroupChkSpecialCard').hide();
        $('.show-customer-special').hide();
      }

    }

    $('.show-customer-special').hide();

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
  });

  $('input[name=ckSpecialCard]').change(function () {
    if ($(this).is(':checked')) {
      // Checkbox is checked.

      var dataSpecialCustomer = [], specialCustomer;
      <c:forEach var="item1" items="${listSpecialCustomer}">
      specialCustomer = ['${item1.displayName}-(${item1.cif})'];
      dataSpecialCustomer.push(specialCustomer);
      </c:forEach>

      if (dataSpecialCustomer != '' && dataSpecialCustomer.length > 0) {
        $('.multiple-select').find('option').each(
            function () {
              if ($.inArray($(this).val(), dataSpecialCustomer) > -1) {
                $('.multiple-select').multiselect('select', $(this).val(), true);
              } else {
                $('.multiple-select').multiselect('deselect', $(this).val());
              }
            }
        );
        $('input[name=ckSpecialCard]:checked').attr('checked', true);
        $('#hidden_checkBoxSpecialCard').val('1');
        $('.show-customer-special').show();
      }else{
        $('input[name=ckSpecialCard]:checked').attr('checked', false);
        $('#hidden_checkBoxSpecialCard').val('0');
        $('.show-customer-special').hide();
        $.MessageBox({message: 'Không có KH đặc biệt không chọn được lô thẻ riêng'});
      }
    } else {
      // Checkbox is not checked..
      $('input[name=ckSpecialCard]:checked').attr('checked', false);
      $('#hidden_checkBoxSpecialCard').val('0');
      $('.show-customer-special').hide();
    }
  });

  function showGroup() {
    var telco = $('.telco input[name=telco]:checked').val();
    //DATA_MOBIFONE
    if (telco !== undefined && telco === 'DATA_MOBIFONE') {
      jQuery('#idGroup_DATAMOBIFONE').addClass('show-group-card');
      jQuery('#idGroup_DATAMOBIFONE').removeClass('hidden-group-card');

      jQuery('#idGroupDef').addClass('hidden-group-card');
      jQuery('#idGroupDef').removeClass('show-group-card');

      jQuery('#idGroup_DATAVINAPHONE').addClass('hidden-group-card');
      jQuery('#idGroup_DATAVINAPHONE').removeClass('show-group-card');

      jQuery('#idGroup_DATA_VIETTEL').addClass('hidden-group-card');
      jQuery('#idGroup_DATA_VIETTEL').removeClass('show-group-card');

      jQuery('#idGroup_SCOIN').addClass('hidden-group-card');
      jQuery('#idGroup_SCOIN').removeClass('show-group-card');

      jQuery('#idGroup_SOHACOIN').addClass('hidden-group-card');
      jQuery('#idGroup_SOHACOIN').removeClass('show-group-card');

      jQuery('#idGroup_FUNCARD').addClass('hidden-group-card');
      jQuery('#idGroup_FUNCARD').removeClass('show-group-card');

    }
    /*data vinaphone*/
    else if (telco !== undefined && telco === 'DATA_VINAPHONE') {
      jQuery('#idGroup_DATAVINAPHONE').addClass('show-group-card');
      jQuery('#idGroup_DATAVINAPHONE').removeClass('hidden-group-card');

      jQuery('#idGroup_DATAMOBIFONE').addClass('hidden-group-card');
      jQuery('#idGroup_DATAMOBIFONE').removeClass('show-group-card');

      jQuery('#idGroupDef').addClass('hidden-group-card');
      jQuery('#idGroupDef').removeClass('show-group-card');

      jQuery('#idGroup_DATA_VIETTEL').addClass('hidden-group-card');
      jQuery('#idGroup_DATA_VIETTEL').removeClass('show-group-card');

      jQuery('#idGroup_SCOIN').addClass('hidden-group-card');
      jQuery('#idGroup_SCOIN').removeClass('show-group-card');

      jQuery('#idGroup_SOHACOIN').addClass('hidden-group-card');
      jQuery('#idGroup_SOHACOIN').removeClass('show-group-card');

      jQuery('#idGroup_FUNCARD').addClass('hidden-group-card');
      jQuery('#idGroup_FUNCARD').removeClass('show-group-card');
    }
    /*viettel3G*/
    else if (telco !== undefined && telco === 'DATA_VIETTEL') {

      jQuery('#idGroup_DATA_VIETTEL').addClass('show-group-card');
      jQuery('#idGroup_DATA_VIETTEL').removeClass('hidden-group-card');

      jQuery('#idGroup_DATAVINAPHONE').addClass('hidden-group-card');
      jQuery('#idGroup_DATAVINAPHONE').removeClass('show-group-card');

      jQuery('#idGroup_DATAMOBIFONE').addClass('hidden-group-card');
      jQuery('#idGroup_DATAMOBIFONE').removeClass('show-group-card');

      jQuery('#idGroupDef').addClass('hidden-group-card');
      jQuery('#idGroupDef').removeClass('show-group-card');

      jQuery('#idGroup_SCOIN').addClass('hidden-group-card');
      jQuery('#idGroup_SCOIN').removeClass('show-group-card');

      jQuery('#idGroup_SOHACOIN').addClass('hidden-group-card');
      jQuery('#idGroup_SOHACOIN').removeClass('show-group-card');

      jQuery('#idGroup_FUNCARD').addClass('hidden-group-card');
      jQuery('#idGroup_FUNCARD').removeClass('show-group-card');
    }
    /*scoi*/
    else if (telco !== undefined && telco === 'SCOIN') {
      jQuery('#idGroup_SCOIN').addClass('show-group-card');
      jQuery('#idGroup_SCOIN').removeClass('hidden-group-card');

      jQuery('#idGroup_DATA_VIETTEL').addClass('hidden-group-card');
      jQuery('#idGroup_DATA_VIETTEL').removeClass('show-group-card');

      jQuery('#idGroup_DATAVINAPHONE').addClass('hidden-group-card');
      jQuery('#idGroup_DATAVINAPHONE').removeClass('show-group-card');

      jQuery('#idGroup_DATAMOBIFONE').addClass('hidden-group-card');
      jQuery('#idGroup_DATAMOBIFONE').removeClass('show-group-card');

      jQuery('#idGroupDef').addClass('hidden-group-card');
      jQuery('#idGroupDef').removeClass('show-group-card');

      jQuery('#idGroup_SOHACOIN').addClass('hidden-group-card');
      jQuery('#idGroup_SOHACOIN').removeClass('show-group-card');

      jQuery('#idGroup_FUNCARD').addClass('hidden-group-card');
      jQuery('#idGroup_FUNCARD').removeClass('show-group-card');
    }
    /*soha*/
    else if (telco !== undefined && telco === 'SOHA') {
      jQuery('#idGroup_SOHACOIN').addClass('show-group-card');
      jQuery('#idGroup_SOHACOIN').removeClass('hidden-group-card');

      jQuery('#idGroup_DATA_VIETTEL').addClass('hidden-group-card');
      jQuery('#idGroup_DATA_VIETTEL').removeClass('show-group-card');

      jQuery('#idGroup_DATAVINAPHONE').addClass('hidden-group-card');
      jQuery('#idGroup_DATAVINAPHONE').removeClass('show-group-card');

      jQuery('#idGroup_DATAMOBIFONE').addClass('hidden-group-card');
      jQuery('#idGroup_DATAMOBIFONE').removeClass('show-group-card');

      jQuery('#idGroupDef').addClass('hidden-group-card');
      jQuery('#idGroupDef').removeClass('show-group-card');

      jQuery('#idGroup_SCOIN').addClass('hidden-group-card');
      jQuery('#idGroup_SCOIN').removeClass('show-group-card');

      jQuery('#idGroup_FUNCARD').addClass('hidden-group-card');
      jQuery('#idGroup_FUNCARD').removeClass('show-group-card');
    }
    /*fundcard*/
    else if (telco !== undefined && telco === 'FUNCARD') {
      jQuery('#idGroup_FUNCARD').addClass('show-group-card');
      jQuery('#idGroup_FUNCARD').removeClass('hidden-group-card');

      jQuery('#idGroup_DATA_VIETTEL').addClass('hidden-group-card');
      jQuery('#idGroup_DATA_VIETTEL').removeClass('show-group-card');

      jQuery('#idGroup_DATAVINAPHONE').addClass('hidden-group-card');
      jQuery('#idGroup_DATAVINAPHONE').removeClass('show-group-card');

      jQuery('#idGroup_DATAMOBIFONE').addClass('hidden-group-card');
      jQuery('#idGroup_DATAMOBIFONE').removeClass('show-group-card');

      jQuery('#idGroupDef').addClass('hidden-group-card');
      jQuery('#idGroupDef').removeClass('show-group-card');

      jQuery('#idGroup_SCOIN').addClass('hidden-group-card');
      jQuery('#idGroup_SCOIN').removeClass('show-group-card');

      jQuery('#idGroup_SOHACOIN').addClass('hidden-group-card');
      jQuery('#idGroup_SOHACOIN').removeClass('show-group-card');
    }
    else if (telco === undefined || telco !== 'DATA_MOBIFONE' || telco !== 'DATA_VINAPHONE' || telco
        !== 'DATA_VIETTEL' || telco !== 'SCOIN' || telco !== 'SOHA' || telco !== 'FUNCARD') {
      jQuery('#idGroupDef').addClass('show-group-card');
      jQuery('#idGroupDef').removeClass('hidden-group-card');

      jQuery('#idGroup_DATAMOBIFONE').addClass('hidden-group-card');
      jQuery('#idGroup_DATAMOBIFONE').removeClass('show-group-card');

      jQuery('#idGroup_DATAVINAPHONE').addClass('hidden-group-card');
      jQuery('#idGroup_DATAVINAPHONE').removeClass('show-group-card');

      jQuery('#idGroup_DATA_VIETTEL').addClass('hidden-group-card');
      jQuery('#idGroup_DATA_VIETTEL').removeClass('show-group-card');

      jQuery('#idGroup_SCOIN').addClass('hidden-group-card');
      jQuery('#idGroup_SCOIN').removeClass('show-group-card');

      jQuery('#idGroup_SOHACOIN').addClass('hidden-group-card');
      jQuery('#idGroup_SOHACOIN').removeClass('show-group-card');

      jQuery('#idGroup_FUNCARD').addClass('hidden-group-card');
      jQuery('#idGroup_FUNCARD').removeClass('show-group-card');
    }
  }
</script>
<jsp:include page="../include_page/js_footer.jsp"/>
<script type="text/javascript"
        src="<c:url value='/assets/development/static/js/card-store.js'/>"></script>
</body>
</html>









