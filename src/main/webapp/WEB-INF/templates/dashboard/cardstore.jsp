<%@ page language="java" trimDirectiveWhitespaces="true" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="../include_page/taglibs.jsp" %>


<!doctype html>
<html class="fixed" lang="${pageContext.response.locale.language}">

<head>
    <!-- Basic -->
    <meta charset="UTF-8">
    <title><spring:message code="dashboard.title"/></title>
    <jsp:include page="../include_page/head.jsp">
        <jsp:param name="dateLib" value="true"/>
    </jsp:include>
    <style>
        .colorInputted {
            background-color: #2582C4;
        }

        .colorSold {
            background-color: #818996;
        }

        .colorActive {
            background-color: #67A22C;
        }

        .colorDeactive {
            background-color: #D2EBC3;
        }

        .colorNearExpired {
            background-color: #F0A800;
        }

        .colorExpired {
            background-color: #E3364A;
        }

        .item {
            -webkit-box-flex: 1;
            flex: 1;
            width: 16.66%;
            padding: 0;
        }

        .rowTable {
            display: flex;
            margin-left: 3px;
            margin-right: 3px;
        }

        .guildCard {
            color: white !important;
        }

        .oddRow {
            background-color: #f9f9f9 !important;
        }

        .evenRow {
            background-color: white !important;
        }

        .levelOneWarning {
            background-color: #fbdec0 !important;
        }

        .levelTwoWarning {
            background-color: #F0A800 !important;
        }

        .levelThreeWarning {
            background-color: #E3364A !important;
        }

        #applyCSS > * {
            float: left;
        }

        div.square {
            width: 20px;
            height: 20px;
        }

        .panel-title {
            padding-left: 5px !important;
            padding-right: 6px !important;
        }

        .tableCard > thead > tr > th, .tableCard > tbody > tr > th, .tableCard > tfoot > tr > th, .tableCard > thead > tr > td, .tableCard > tbody > tr > td, .tableCard > tfoot > tr > td {
            padding-left: 5px !important;
            padding-right: 6px !important;
        }

        a.lighWarning:active {
            color: #38b449;
        }

        a.lighWarning:hover {
            cursor: pointer;
        }
    </style>
    <jsp:include page="../include_page/js.jsp">
        <jsp:param name="tableLib" value="true"/>
        <jsp:param name="dateLib" value="true"/>
    </jsp:include>

    <script type="text/javascript"
            src="<c:url value="/assets/development/static/js/google.charts.js"/>"></script>
</head>

<body>
<section class="body">

    <jsp:include page="../include_page/header.jsp"/>

    <div class="inner-wrapper">

        <!-- start: sidebar -->
        <jsp:include page="../include_page/navigation.jsp">
            <jsp:param value="store_monitoring" name="nav"/>
        </jsp:include>
        <!-- end: sidebar -->

        <section role="main" class="content-body">
            <header class="page-header">
                <div class="row">
                    <div class="col-xs-12">
                        <div class="page-header-left">
                            <ol class="breadcrumbs">
                                <li><a href="#"><i class="fa fa-home"></i></a></li>
                                <li><span><spring:message code="header.card.store.special"/></span></li>
                                <li><span class="nav-active"><spring:message
                                        code="common.title.store.monitoring"/></span></li>
                            </ol>
                        </div>
                    </div>
                </div>
            </header>

            <div class="content-body-wrap">
                <section class="panel panel-default su_chart">
                    <div class="h4 mb-md">
                        <div class="page-header-left header-title">
                            <spring:message code="common.title.store.monitoring"/>
                        </div>
                    </div>

                    <div class="panel-body">
                        <div class="summarylist" style="width: 100%;">
                            <div class="col-xs-12 col-md-12 col-lg-12">
                                <div class="area_chart panel_mar mt-none" style="border-top: none">
                                    <div class="d-flex justify-content-between">
                                        <jsp:include page="../include_component/date_range.jsp"/>
                                        <div class="text-right">
                                            <c:if test="${isSale ne true}">
                                                <select id="provider"
                                                        class="form-control chart-filter hidden"
                                                        multiple>
                                                    <option value=""><spring:message
                                                            code="common.select.provider"/></option>
                                                    <c:forEach var="provider"
                                                               items="${cardProviders}">
                                                        <option value="${provider.code}">${provider.name}</option>
                                                    </c:forEach>
                                                </select>
                                            </c:if>
                                            <select id="cardType"
                                                    class="form-control chart-filter hidden"
                                                    multiple>
                                                <option value=""><spring:message
                                                        code="common.select.card.type"/></option>
                                                <c:forEach var="cardType" items="${cardTypes}">
                                                    <option value="${cardType.code}">${cardType.name}</option>
                                                </c:forEach>
                                            </select>

                                            <select id="faceValue"
                                                    class="form-control chart-filter hidden"
                                                    multiple>
                                                <option value=""><spring:message
                                                        code="common.select.card.value"/></option>
                                                <option value="10000">10.000</option>
                                                <option value="20000">20.000</option>
                                                <option value="30000">30.000</option>
                                                <option value="40000">40.000</option>
                                                <option value="50000">50.000</option>
                                                <option value="70000">70.000</option>
                                                <option value="70000">90.000</option>
                                                <option value="100000">100.000</option>
                                                <option value="125000">125.000</option>
                                                <option value="200000">200.000</option>
                                                <option value="300000">300.000</option>
                                                <option value="500000">500.000</option>
                                                <option value="1000000">1.000.000</option>
                                                <option value="2000000">2.000.000</option>
                                            </select>
                                            <c:if test="${isSale ne true}">
                                                <select id="specialCard"
                                                        class="form-control chart-filter specialCard">
                                                    <option value=""><spring:message
                                                            code="common.select.special.card"/></option>
                                                    <option value="0" ${'0' eq specialCard ? 'selected' : ''}>
                                                        <spring:message
                                                                code="common.special.card.general"/></option>
                                                    <option value="1" ${'1' eq specialCard ? 'selected' : ''}>
                                                        <spring:message
                                                                code="common.special.card.private"/></option>
                                                </select>

                                                <select id="specialCustomer"
                                                        class="form-control chart-filter specialCustomer"
                                                        disabled>
                                                    <option value=""><spring:message
                                                            code="common.select.special.customer"/></option>
                                                    <c:forEach var="item"
                                                               items="${specialCustomers}">
                                                        <option value="${item.cif}" ${item.cif eq specialCustomer ? 'selected' : ''}>${item.displayName}</option>
                                                    </c:forEach>
                                                </select>
                                            </c:if>
                                            <button type="button" name="statistic" id="statistic"
                                                    class="btn btn-primary btn-sm"><i
                                                    class="fa fa-search"></i>&nbsp;<spring:message
                                                    code="common.btn.search"/></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="panel-body">
                        <div class="container-fluid">
                            <spring:message var="colQuantity" code="purchase.table.quantity"/>
                            <spring:message var="colTotalValue" code="purchase.table.total.value"/>
                            <spring:message var="colTotalCapital"
                                            code="purchase.table.total.capital"/>
                            <c:if test="${!isSale}">
                                <div class="row rowTable table-responsive">
                                    <table class="table table-bordered">
                                        <thead>
                                        <tr>
                                            <th colspan="2"
                                                style="background-color: #2582C4 !important;">
                                                <spring:message code="common.title.input.card"/>
                                                <i class="fa  fa-question-circle text-muted m-xs guildCard"
                                                   data-toggle="popover"
                                                   data-trigger="hover"
                                                   data-placement="top"
                                                   data-content='<spring:message code="common.card.number.imported.to.card.store"/> '
                                                   data-html="true" data-original-title=""
                                                   title=""></i>
                                            </th>
                                            <th colspan="2"
                                                style="background-color: #818996 !important;">
                                                <spring:message code="common.title.sold.card"/>
                                                <i class="fa  fa-question-circle text-muted m-xs guildCard"
                                                   data-toggle="popover"
                                                   data-trigger="hover"
                                                   data-placement="top"
                                                   data-content='<spring:message code="common.title.the.cards.exported.for.sperific.merchant"/> '
                                                   data-html="true"
                                                   data-original-title="" title=""></i>
                                            </th>
                                            <th colspan="2"
                                                style="background-color: #67A22C !important;">
                                                <spring:message code="common.title.active.card"/>
                                                <i class="fa  fa-question-circle text-muted m-xs guildCard"
                                                   data-toggle="popover"
                                                   data-trigger="hover"
                                                   data-placement="top"
                                                   data-content='<spring:message code="common.title.the.cards.imported.and.actived.ready.for.use"/> '
                                                   data-html="true" data-original-title=""
                                                   title=""></i>
                                            </th>
                                            <th colspan="2"
                                                style="background-color: #D2EBC3 !important;">
                                                <spring:message code="common.title.inactive.card"/>
                                                <i class="fa  fa-question-circle text-muted m-xs guildCard"
                                                   data-toggle="popover"
                                                   data-trigger="hover"
                                                   data-placement="top"
                                                   data-content='<spring:message code="common.title.the.cards.imported.and.inactive.of.use" />'
                                                   data-html="true" data-original-title=""
                                                   title=""></i>
                                            </th>
                                            <th colspan="2"
                                                style="background-color: #F0A800 !important;">
                                                <spring:message code="common.warning.expired.card"/>
                                                <i class="fa  fa-question-circle text-muted m-xs guildCard"
                                                   data-toggle="popover"
                                                   data-trigger="hover"
                                                   data-placement="top"
                                                   data-content='Số thẻ chưa được bán, nhưng gần đến ngày hết hạn (cách ${nearExpDays} NGÀY so với ngày hết hạn).'
                                                   data-html="true"
                                                   data-original-title=""
                                                   title=""></i>
                                            </th>
                                            <th colspan="2"
                                                style="background-color: #E3364A !important;">
                                                <spring:message code="common.title.expired.card"/>
                                                <i class="fa  fa-question-circle text-muted m-xs guildCard"
                                                   data-toggle="popover"
                                                   data-trigger="hover"
                                                   data-placement="top"
                                                   data-content='<spring:message code="common.title.the.cards.unsold.but.it.expired" />'
                                                   data-html="true"
                                                   data-original-title=""
                                                   title=""></i>
                                            </th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <tr>
                                            <td colspan="2"
                                                style="background-color:#2582C4 !important; ">${colQuantity}<span
                                                    class="pull-right"
                                                    id="cardInputtedNumber"></span>
                                            </td>
                                            <td colspan="2"
                                                style="background-color:#818996 !important; ">${colQuantity}<span
                                                    class="pull-right" id="cardSoldNumber"></span>
                                            </td>
                                            <td colspan="2"
                                                style="background-color:#67A22C !important; ">${colQuantity}<span
                                                    class="pull-right"
                                                    id="cardActivateNumber"></span>
                                            </td>
                                            <td colspan="2"
                                                style="background-color:#D2EBC3 !important; ">${colQuantity}<span
                                                    class="pull-right"
                                                    id="cardDeactivateNumber"></span>
                                            </td>
                                            <td colspan="2"
                                                style="background-color:#F0A800 !important; ">${colQuantity}<span
                                                    class="pull-right"
                                                    id="cardPreExpiredNumber"></span>
                                            </td>
                                            <td colspan="2"
                                                style="background-color:#E3364A !important; ">${colQuantity}<span
                                                    class="pull-right"
                                                    id="cardExpiredNumber"></span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2"
                                                style="background-color:#2582C4 !important; ">${colTotalValue}<span
                                                    class="pull-right"
                                                    id="cardInputtedValue"></span>
                                            </td>
                                            <td colspan="2"
                                                style="background-color:#818996 !important; ">${colTotalValue}<span
                                                    class="pull-right" id="cardSoldValue"></span>
                                            </td>
                                            <td colspan="2"
                                                style="background-color:#67A22C !important; ">${colTotalValue}<span
                                                    class="pull-right"
                                                    id="cardActivateValue"></span>
                                            </td>
                                            <td colspan="2"
                                                style="background-color:#D2EBC3 !important; ">${colTotalValue}<span
                                                    class="pull-right"
                                                    id="cardDeactivateValue"></span>
                                            </td>
                                            <td colspan="2"
                                                style="background-color:#F0A800 !important; ">${colTotalValue}<span
                                                    class="pull-right"
                                                    id="cardPreExpiredValue"></span>
                                            </td>
                                            <td colspan="2"
                                                style="background-color:#E3364A !important; ">${colTotalValue}<span
                                                    class="pull-right" id="cardExpiredValue"></span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2"
                                                style="background-color:#2582C4 !important; ">${colTotalCapital}<span
                                                    class="pull-right"
                                                    id="cardInputtedCapital"></span>
                                            </td>
                                            <td colspan="2"
                                                style="background-color:#818996 !important; ">${colTotalCapital}<span
                                                    class="pull-right" id="cardSoldCapital"></span>
                                            </td>
                                            <td colspan="2"
                                                style="background-color:#67A22C !important; ">${colTotalCapital}<span
                                                    class="pull-right"
                                                    id="cardActivateCapital"></span>
                                            </td>
                                            <td colspan="2"
                                                style="background-color:#D2EBC3 !important; ">${colTotalCapital}<span
                                                    class="pull-right"
                                                    id="cardDeactivateCapital"></span></td>
                                            <td colspan="2"
                                                style="background-color:#F0A800 !important; ">${colTotalCapital}<span
                                                    class="pull-right"
                                                    id="cardPreExpiredCapital"></span></td>
                                            <td colspan="2"
                                                style="background-color:#E3364A !important; ">${colTotalCapital}<span
                                                    class="pull-right"
                                                    id="cardExpiredCapital"></span>
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </c:if>

                            <div class="row" id="row-draw-pie-chard">
                                <div class="col-md-6">
                                    <i class="fa  fa-question-circle text-muted m-xs "
                                       data-toggle="popover" data-trigger="hover"
                                       data-placement="top"
                                       data-content='<spring:message code="common.title.card.item.density" />'
                                       data-html="true" data-original-title="" title=""></i>
                                    <div id="numberCards-pie-chart"
                                         style="height: 350px;"></div>
                                </div>
                                <div class="col-md-6">
                                    <i class="fa  fa-question-circle text-muted m-xs "
                                       data-toggle="popover" data-trigger="hover"
                                       data-placement="top"
                                       data-content='<spring:message code="common.title.value.density"/>'
                                       data-html="true" data-original-title="" title=""></i>
                                    <div id="faceValue-pie-chart" style="height: 350px;"></div>
                                </div>
                            </div>


                            <div class="row">
                                <div class="col-md-12" id="applyCSS">
                                    <div><spring:message
                                            code="common.title.level.card.warning.do.not.enough.card"/>&nbsp;<spring:message
                                            code="cardstore.lbl.warning.levelone"/>&nbsp;
                                    </div>
                                    <div class="square levelOneWarning"><img/></div>
                                    <i class="fa  fa-question-circle text-muted m-xs "
                                       data-toggle="popover" data-trigger="hover"
                                       data-placement="top"
                                       data-content='<spring:message code="common.title.level.1.low" />'
                                       data-html="true" data-original-title="" title=""></i>
                                    <div>&nbsp;|&nbsp;<spring:message
                                            code="cardstore.lbl.warning.leveltwo"/>&nbsp;
                                    </div>
                                    <div class="square levelTwoWarning"><img/></div>
                                    <i class="fa  fa-question-circle text-muted m-xs "
                                       data-toggle="popover" data-trigger="hover"
                                       data-placement="top"
                                       data-content='<spring:message code="common.title.level.2.medium" />'
                                       data-html="true" data-original-title="" title=""></i>
                                    <div>&nbsp;|&nbsp;<spring:message
                                            code="cardstore.lbl.warning.levelthree"/>&nbsp;
                                    </div>
                                    <div class="square levelThreeWarning"><img/></div>
                                    <i class="fa  fa-question-circle text-muted m-xs "
                                       data-toggle="popover" data-trigger="hover"
                                       data-placement="top"
                                       data-content='<spring:message code="common.title.level.3.serious" />'
                                       data-html="true" data-original-title="" title=""></i>
                                </div>
                            </div>

                            <div class="h-divider"></div>

                            <div class="row">
                                <div class="col-md-12">
                                    <div class="row">
                                        <div class="panel-title"
                                             style="float: left;margin-left: 10px;"><spring:message
                                                code="cardstore.lbl.telcogame"/></div>
                                        <div id="sumaryCard"
                                             style="float: left;padding: 15px 15px 15px 0;">
                                        </div>
                                    </div>

                                    <div class="row" id="scrollCard"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
            </div>
            <!-- div data card -->

            <spring:message var="colFaceValue" code="purchase.table.face.value"/>
            <spring:message var="colInputCard" code="purchase.table.input.card"/>
            <spring:message var="colSoldCard" code="purchase.table.sold.card"/>
            <spring:message var="colActiveCard" code="purchase.table.active.card"/>
            <spring:message var="colInactiveCard" code="purchase.table.inactive.card"/>
            <spring:message var="colWarningExpiredCard" code="purchase.table.warning.expired.card"/>
            <spring:message var="colExpiredCard" code="purchase.table.expire.card"/>
            <spring:message var="colTotal" code="purchase.table.total"/>
            <div class="col-md-12" id="divCard" style="display: none">
                <section class="panel">
                    <header class="panel-heading" style="padding: 0;height: 32px;">
                        <h2 class="panel-title titleCard" id="titleCard">VIETTEL</h2>
                    </header>
                    <div class="panel-body" style="display: block;padding-top: 0;">
                        <div class="table-responsive">
                            <table class="table mb-none table-bordered">
                                <thead>
                                <tr>
                                    <th style="text-align:right">${colFaceValue}</th>
                                    <th style="text-align:right">${colInputCard}</th>
                                    <th style="text-align:right">${colSoldCard}</th>
                                    <th style="text-align:right">${colActiveCard}</th>
                                    <th style="text-align:right">${colInactiveCard}</th>
                                    <th style="text-align:right">${colWarningExpiredCard}</th>
                                    <th style="text-align:right">${colExpiredCard}</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr class="oddRow" id="rowOne">
                                    <td align="right">10.000</td>
                                    <td align="right"><span id="cardInputted10">0</span></td>
                                    <td align="right"><span id="cardSold10">0</span></td>
                                    <td align="right"><span id="cardActivate10">0</span></td>
                                    <td align="right"><span id="cardDeactivate10">0</span></td>
                                    <td align="right"><span id="cardPreExpired10">0</span></td>
                                    <td align="right"><span id="cardExpired10">0</span></td>
                                </tr>
                                <tr class="evenRow" id="rowTwo">
                                    <td align="right">20.000</td>
                                    <td align="right"><span id="cardInputted20">0</span></td>
                                    <td align="right"><span id="cardSold20">0</span></td>
                                    <td align="right"><span id="cardActivate20">0</span></td>
                                    <td align="right"><span id="cardDeactivate20">0</span></td>
                                    <td align="right"><span id="cardPreExpired20">0</span></td>
                                    <td align="right"><span id="cardExpired20">0</span></td>
                                </tr>
                                <tr class="oddRow" id="rowThree">
                                    <td align="right">30.000</td>
                                    <td align="right"><span id="cardInputted30">0</span></td>
                                    <td align="right"><span id="cardSold30">0</span></td>
                                    <td align="right"><span id="cardActivate30">0</span></td>
                                    <td align="right"><span id="cardDeactivate30">0</span></td>
                                    <td align="right"><span id="cardPreExpired30">0</span></td>
                                    <td align="right"><span id="cardExpired30">0</span></td>
                                </tr>

                                <tr class="evenRow" id="row40">
                                    <td align="right">40.000</td>
                                    <td align="right"><span id="cardInputted40">0</span></td>
                                    <td align="right"><span id="cardSold40">0</span></td>
                                    <td align="right"><span id="cardActivate40">0</span></td>
                                    <td align="right"><span id="cardDeactivate40">0</span></td>
                                    <td align="right"><span id="cardPreExpired40">0</span></td>
                                    <td align="right"><span id="cardExpired40">0</span></td>
                                </tr>

                                <tr class="oddRow" id="rowFour">
                                    <td align="right">50.000</td>
                                    <td align="right"><span id="cardInputted50">0</span></td>
                                    <td align="right"><span id="cardSold50">0</span></td>
                                    <td align="right"><span id="cardActivate50">0</span></td>
                                    <td align="right"><span id="cardDeactivate50">0</span></td>
                                    <td align="right"><span id="cardPreExpired50">0</span></td>
                                    <td align="right"><span id="cardExpired50">0</span></td>
                                </tr>
                                <tr class="evenRow" id="row70">
                                    <td align="right">70.000</td>
                                    <td align="right"><span id="cardInputted70">0</span></td>
                                    <td align="right"><span id="cardSold70">0</span></td>
                                    <td align="right"><span id="cardActivate70">0</span></td>
                                    <td align="right"><span id="cardDeactivate70">0</span></td>
                                    <td align="right"><span id="cardPreExpired70">0</span></td>
                                    <td align="right"><span id="cardExpired70">0</span></td>
                                </tr>

                                <tr class="oddRow" id="row90">
                                    <td align="right">90.000</td>
                                    <td align="right"><span id="cardInputted90">0</span></td>
                                    <td align="right"><span id="cardSold90">0</span></td>
                                    <td align="right"><span id="cardActivate90">0</span></td>
                                    <td align="right"><span id="cardDeactivate90">0</span></td>
                                    <td align="right"><span id="cardPreExpired90">0</span></td>
                                    <td align="right"><span id="cardExpired90">0</span></td>
                                </tr>

                                <tr class="evenRow" id="rowFive">
                                    <td align="right">100.000</td>
                                    <td align="right"><span id="cardInputted100">0</span></td>
                                    <td align="right"><span id="cardSold100">0</span></td>
                                    <td align="right"><span id="cardActivate100">0</span></td>
                                    <td align="right"><span id="cardDeactivate100">0</span></td>
                                    <td align="right"><span id="cardPreExpired100">0</span></td>
                                    <td align="right"><span id="cardExpired100">0</span></td>
                                </tr>

                                <tr class="oddRow" id="row125">
                                    <td align="right">125.000</td>
                                    <td align="right"><span id="cardInputted125">0</span></td>
                                    <td align="right"><span id="cardSold125">0</span></td>
                                    <td align="right"><span id="cardActivate125">0</span></td>
                                    <td align="right"><span id="cardDeactivate125">0</span></td>
                                    <td align="right"><span id="cardPreExpired125">0</span></td>
                                    <td align="right"><span id="cardExpired125">0</span></td>
                                </tr>

                                <tr class="evenRow" id="rowSix">
                                    <td align="right">200.000</td>
                                    <td align="right"><span id="cardInputted200">0</span></td>
                                    <td align="right"><span id="cardSold200">0</span></td>
                                    <td align="right"><span id="cardActivate200">0</span></td>
                                    <td align="right"><span id="cardDeactivate200">0</span></td>
                                    <td align="right"><span id="cardPreExpired200">0</span></td>
                                    <td align="right"><span id="cardExpired200">0</span></td>
                                </tr>
                                <tr class="oddRow" id="rowSeven">
                                    <td align="right">300.000</td>
                                    <td align="right"><span id="cardInputted300">0</span></td>
                                    <td align="right"><span id="cardSold300">0</span></td>
                                    <td align="right"><span id="cardActivate300">0</span></td>
                                    <td align="right"><span id="cardDeactivate300">0</span></td>
                                    <td align="right"><span id="cardPreExpired300">0</span></td>
                                    <td align="right"><span id="cardExpired300">0</span></td>
                                </tr>
                                <tr class="evenRow" id="rowEight">
                                    <td align="right">500.000</td>
                                    <td align="right"><span id="cardInputted500">0</span></td>
                                    <td align="right"><span id="cardSold500">0</span></td>
                                    <td align="right"><span id="cardActivate500">0</span></td>
                                    <td align="right"><span id="cardDeactivate500">0</span></td>
                                    <td align="right"><span id="cardPreExpired500">0</span></td>
                                    <td align="right"><span id="cardExpired500">0</span></td>
                                </tr>
                                <tr class="evenRow" id="rowNine">
                                    <td align="right">1.000.000</td>
                                    <td align="right"><span id="cardInputted1000">0</span></td>
                                    <td align="right"><span id="cardSold1000">0</span></td>
                                    <td align="right"><span id="cardActivate1000">0</span></td>
                                    <td align="right"><span id="cardDeactivate1000">0</span></td>
                                    <td align="right"><span id="cardPreExpired1000">0</span></td>
                                    <td align="right"><span id="cardExpired1000">0</span></td>
                                </tr>
                                <tr class="evenRow" id="rowTen">
                                    <td align="right">2.000.000</td>
                                    <td align="right"><span id="cardInputted2000">0</span></td>
                                    <td align="right"><span id="cardSold2000">0</span></td>
                                    <td align="right"><span id="cardActivate2000">0</span></td>
                                    <td align="right"><span id="cardDeactivate2000">0</span></td>
                                    <td align="right"><span id="cardPreExpired2000">0</span></td>
                                    <td align="right"><span id="cardExpired2000">0</span></td>
                                </tr>
                                <tr class="oddRow">
                                    <td align="right">${colTotal}</td>
                                    <td align="right"><span id="cardInputtedTg">0</span></td>
                                    <td align="right"><span id="cardSoldTg">0</span></td>
                                    <td align="right"><span id="cardActivateTg">0</span></td>
                                    <td align="right"><span id="cardDeactivateTg">0</span></td>
                                    <td align="right"><span id="cardPreExpiredTg">0</span></td>
                                    <td align="right"><span id="cardExpiredTg">0</span></td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </section>
            </div>


            <script type="text/javascript">
              $(document).ready(function () {
                var isSale = '<c:out value="${isSale}"/>';
                if(isSale== 'true'){
                  $('#row-draw-pie-chard').css("display","none");
                }else{
                  $('#row-draw-pie-chard').css("display","block");
                }

                var filterDataDefault = {
                  'providers': [],
                  'cardTypes': [],
                  'faceValues': []
                };
                updateStatistic(filterDataDefault, null);

                function updateStatistic(filterDataDefault, daterange) {

                  updateCardData(filterDataDefault, null);
                }

                $("#statistic").click(function () {
                  var provideres = [];
                  <c:if test="${isSale ne true}">
                  provideres = ($('#provider').val() === null) ? [] : $('#provider').val();
                  </c:if>
                  provideres = provideres.filter(function (e) {
                    return e
                  });
                  var cardTypes = ($('#cardType').val() === null) ? [] : $('#cardType').val();
                  cardTypes = cardTypes.filter(function (e) {
                    return e
                  });
                  var faceValues = ($('#faceValue').val() === null) ? [] : $('#faceValue').val();
                  faceValues = faceValues.filter(function (e) {
                    return e
                  });

                  var specialCard = null;
                  var specialCustomer = [];
                  <c:if test="${isSale ne true}">
                  specialCard = ($('#specialCard').val() === null) ? '' : $('#specialCard').val();
                  specialCustomer = ($('#specialCustomer').val() === null) ? [] : $(
                      '#specialCustomer').val();
                  </c:if>
                  /*specialCustomer = specialCustomer.filter(function (e) {
                    return e
                  });*/
                  var daterange = $('#reservation').val();
                  var filterData = {
                    'providers': provideres,
                    'cardTypes': cardTypes,
                    'faceValues': faceValues,
                    'isPrivate': specialCard === '1' ? true : (specialCard === '0' ? false : null),
                    'privateCustomerCif': $.makeArray(specialCustomer)
                  };
                  updateCardData(filterData, daterange);
                });

                function updateCardData(filterData, daterange) {

                  $("#mloading").modal('toggle');
                  google.charts.load('current', {'packages': ['corechart']});
                  var url = "<%=request.getContextPath() %>/provider/dashboard/statistic?daterange="
                      + encodeURIComponent(daterange);
                  $.ajax({
                    url: url,
                    method: "POST",
                    dataType: 'json',
                    data: JSON.stringify(filterData),
                    contentType: "application/json"
                  }).success(function (result) {
                    if (result.cardInputted === undefined) {
                      $.MessageBox(
                          {message: 'Connecting to Server is error, Statistic cannot update !'});
                      return;
                    }
                    $("#cardInputtedNumber").text(
                        formatNumberSeparator(result.cardInputted.number, 'vi'));
                    $("#cardInputtedValue").text(formatNumberSeparator(result.cardInputted.value,
                        'vi') + ' VND');
                    $("#cardInputtedCapital").text(formatNumberSeparator(
                        result.cardInputted.capital, 'vi') + ' VND');
                    $("#cardSoldNumber").text(formatNumberSeparator(result.cardSold.number, 'vi'));
                    $("#cardSoldValue").text(formatNumberSeparator(result.cardSold.value, 'vi')
                        + ' VND');
                    $("#cardSoldCapital").text(formatNumberSeparator(result.cardSold.capital, 'vi')
                        + ' VND');
                    $("#cardActivateNumber").text(
                        formatNumberSeparator(result.cardActivate.number, 'vi'));
                    $("#cardActivateValue").text(formatNumberSeparator(result.cardActivate.value,
                        'vi') + ' VND');
                    $("#cardActivateCapital").text(formatNumberSeparator(
                        result.cardActivate.capital, 'vi') + ' VND');
                    $("#cardDeactivateNumber").text(
                        formatNumberSeparator(result.cardDeactivate.number, 'vi'));
                    $("#cardDeactivateValue").text(formatNumberSeparator(
                        result.cardDeactivate.value, 'vi') + ' VND');
                    $("#cardDeactivateCapital").text(formatNumberSeparator(
                        result.cardDeactivate.capital, 'vi') + ' VND');
                    $("#cardPreExpiredNumber").text(
                        formatNumberSeparator(result.cardPreExpired.number, 'vi'));
                    $("#cardPreExpiredValue").text(formatNumberSeparator(
                        result.cardPreExpired.value, 'vi') + ' VND');
                    $("#cardPreExpiredCapital").text(formatNumberSeparator(
                        result.cardPreExpired.capital, 'vi') + ' VND');
                    $("#cardExpiredNumber").text(
                        formatNumberSeparator(result.cardExpired.number, 'vi'));
                    $("#cardExpiredValue").text(formatNumberSeparator(result.cardExpired.value,
                        'vi') + ' VND');
                    $("#cardExpiredCapital").text(formatNumberSeparator(result.cardExpired.capital,
                        'vi') + ' VND');

                    google.charts.setOnLoadCallback(function () {

                      drawPieChart(JSON.parse(result.pieDataNumberCards),
                          '<spring:message code="common.title.percentage.of.card"/>', "cards",
                          'numberCards-pie-chart');
                      drawPieChart(JSON.parse(result.pieDataFaceValues),
                          '<spring:message code="common.title.percentage.of.face.value"/>', "VND",
                          'faceValue-pie-chart');

                    });
                    //chart table & scroll div
                    var scrollCard = $("#scrollCard");
                    scrollCard.empty();
                    var cardRowItemes = JSON.parse(result.cardRowItemes);
                    $.each(cardRowItemes, function (key, obj) {
                      if (obj !== 'undefined' && obj.length > 0) {
                        var divCard = $("#divCard").clone();
                        var divCardType = pushDataDivCard(obj, divCard);
                        divCardType.find("#titleCard").text(key);
                        divCardType.find("#titleCard").addClass("href" + key);
                        divCardType.css('display', 'block');
                        scrollCard.append(divCardType);
                      }
                    });
                    //summary card warning
                    var sumaryCard = $("#sumaryCard");
                    sumaryCard.empty();
                    var cardSumaryWarning = JSON.parse(result.cardSumaryWarning);
                    var size = Object.keys(cardSumaryWarning).length - 1;
                    var count = 0;
                    $.each(cardSumaryWarning, function (key, obj) {
                      if (obj !== 'undefined' && obj.length > 0) {
                        if (count === size) {
                          sumaryCard.append(textAnchorEndPage(key, obj));
                        } else {
                          count = count + 1;
                          sumaryCard.append(textAnchorLink(key, obj)
                              + "<div style='float: left'>&nbsp;|&nbsp;</div>");
                        }
                      }
                    });
                  }).fail(function (result) {
                    console.log('fail');
                  }).always(function (result) {
                    console.log('always');
                    $("#mloading").modal('toggle');
                  });
                }

                function textAnchorLink(text, cardWarnings) {
                  var textWarning = textFacevalue(text, cardWarnings);
                  return "<a style=\"float: left;\" class='lighWarning' onclick=\"anchorLink('.href"
                      + text + "');\">" + text + " </a>" + textWarning;
                }

                function textAnchorEndPage(text, cardWarnings) {
                  var textWarning = textFacevalue(text, cardWarnings);
                  return "<a style=\"float: left;\" class='lighWarning' onclick=\"anchorEndPage('.href"
                      + text + "');\">" + text + " </a>" + textWarning;
                }

                function textFacevalue(text, cardWarnings) {
                  var textWarning = "";
                  /*$.each(cardWarnings, function (key, item) {
                   if (item.level === 1) {
                   textWarning = textWarning + "<div style='float: left'>" +item.faceValue + "&nbsp</div>" + iconThree() + "&nbsp";
                   } else if (item.level === 2) {
                   textWarning = textWarning + "<div style='float: left'>" +item.faceValue + "&nbsp</div>" + iconTwo() + "&nbsp";
                   } else if (item.level === 3) {
                   textWarning = textWarning + "<div style='float: left'>" +item.faceValue + "&nbsp</div>" + iconOne() + "&nbsp";
                   }
                   });*/
                  return textWarning;
                }

                function iconOne() {
                  return "<div style='float: left' class=\"square levelOneWarning\"><img></div>";
                }

                function iconTwo() {
                  return "<div style='float: left' class=\"square levelTwoWarning\"><img></div>";
                }

                function iconThree() {
                  return "<div style='float: left' class=\"square levelThreeWarning\"><img></div>";
                }

                function cleanDataDivCard(divCard) {
                  divCard.find("#titleCard").removeClass("hrefVIETTEL");
                  divCard.find("#titleCard").removeClass("hrefMOBIFONE");
                  divCard.find("#titleCard").removeClass("hrefVINAPHONE");
                  divCard.find("#titleCard").removeClass("hrefVNMOBILE");
                  divCard.find("#titleCard").removeClass("hrefGATE");
                  divCard.find("#titleCard").removeClass("hrefGMOBILE");
                  divCard.find("#titleCard").removeClass("hrefVCOIN");
                  divCard.find("#titleCard").removeClass("hrefZING");
                  divCard.find("#titleCard").removeClass("hrefGARENA");
                  divCard.find("#titleCard").removeClass("hrefONCASH");

                  divCard.find("#rowOne").removeClass("levelOneWarning");
                  divCard.find("#rowOne").removeClass("levelTwoWarning");
                  divCard.find("#rowOne").removeClass("levelThreeWarning");
                  divCard.find("#rowOne").addClass("oddRow");
                  divCard.find("#cardInputted10").text(0);
                  divCard.find("#cardSold10").text(0);
                  divCard.find("#cardActivate10").text(0);
                  divCard.find("#cardDeactivate10").text(0);
                  divCard.find("#cardPreExpired10").text(0);
                  divCard.find("#cardExpired10").text(0);

                  divCard.find("#rowTwo").removeClass("levelOneWarning");
                  divCard.find("#rowTwo").removeClass("levelTwoWarning");
                  divCard.find("#rowTwo").removeClass("levelThreeWarning");
                  divCard.find("#rowTwo").addClass("evenRow");
                  divCard.find("#cardInputted20").text(0);
                  divCard.find("#cardSold20").text(0);
                  divCard.find("#cardActivate20").text(0);
                  divCard.find("#cardDeactivate20").text(0);
                  divCard.find("#cardPreExpired20").text(0);
                  divCard.find("#cardExpired20").text(0);

                  divCard.find("#rowThree").removeClass("levelOneWarning");
                  divCard.find("#rowThree").removeClass("levelTwoWarning");
                  divCard.find("#rowThree").removeClass("levelThreeWarning");
                  divCard.find("#rowThree").addClass("oddRow");
                  divCard.find("#cardInputted30").text(0);
                  divCard.find("#cardSold30").text(0);
                  divCard.find("#cardActivate30").text(0);
                  divCard.find("#cardDeactivate30").text(0);
                  divCard.find("#cardPreExpired30").text(0);
                  divCard.find("#cardExpired30").text(0);

                  divCard.find("#row40").removeClass("levelOneWarning");
                  divCard.find("#row40").removeClass("levelTwoWarning");
                  divCard.find("#row40").removeClass("levelThreeWarning");
                  divCard.find("#row40").addClass("evenRow");
                  divCard.find("#cardInputted40").text(0);
                  divCard.find("#cardSold40").text(0);
                  divCard.find("#cardActivate40").text(0);
                  divCard.find("#cardDeactivate40").text(0);
                  divCard.find("#cardPreExpired40").text(0);
                  divCard.find("#cardExpired40").text(0);

                  divCard.find("#rowFour").removeClass("levelOneWarning");
                  divCard.find("#rowFour").removeClass("levelTwoWarning");
                  divCard.find("#rowFour").removeClass("levelThreeWarning");
                  divCard.find("#rowFour").addClass("oddRow");
                  divCard.find("#cardInputted50").text(0);
                  divCard.find("#cardSold50").text(0);
                  divCard.find("#cardActivate50").text(0);
                  divCard.find("#cardDeactivate50").text(0);
                  divCard.find("#cardPreExpired50").text(0);
                  divCard.find("#cardExpired50").text(0);

                  divCard.find("#row70").removeClass("levelOneWarning");
                  divCard.find("#row70").removeClass("levelTwoWarning");
                  divCard.find("#row70").removeClass("levelThreeWarning");
                  divCard.find("#row70").addClass("evenRow");
                  divCard.find("#cardInputted70").text(0);
                  divCard.find("#cardSold70").text(0);
                  divCard.find("#cardActivate70").text(0);
                  divCard.find("#cardDeactivate70").text(0);
                  divCard.find("#cardPreExpired70").text(0);
                  divCard.find("#cardExpired70").text(0);

                  divCard.find("#row90").removeClass("levelOneWarning");
                  divCard.find("#row90").removeClass("levelTwoWarning");
                  divCard.find("#row90").removeClass("levelThreeWarning");
                  divCard.find("#row90").addClass("oddRow");
                  divCard.find("#cardInputte90").text(0);
                  divCard.find("#cardSold90").text(0);
                  divCard.find("#cardActivate90").text(0);
                  divCard.find("#cardDeactivate90").text(0);
                  divCard.find("#cardPreExpired90").text(0);
                  divCard.find("#cardExpired90").text(0);

                  divCard.find("#rowFive").removeClass("levelOneWarning");
                  divCard.find("#rowFive").removeClass("levelTwoWarning");
                  divCard.find("#rowFive").removeClass("levelThreeWarning");
                  divCard.find("#rowFive").addClass("evenRow");
                  divCard.find("#cardInputted100").text(0);
                  divCard.find("#cardSold100").text(0);
                  divCard.find("#cardActivate100").text(0);
                  divCard.find("#cardDeactivate100").text(0);
                  divCard.find("#cardPreExpired100").text(0);
                  divCard.find("#cardExpired100").text(0);

                  divCard.find("#row125").removeClass("levelOneWarning");
                  divCard.find("#row125").removeClass("levelTwoWarning");
                  divCard.find("#row125").removeClass("levelThreeWarning");
                  divCard.find("#row125").addClass("oddRow");
                  divCard.find("#cardInputte125").text(0);
                  divCard.find("#cardSold125").text(0);
                  divCard.find("#cardActivate125").text(0);
                  divCard.find("#cardDeactivate125").text(0);
                  divCard.find("#cardPreExpired125").text(0);
                  divCard.find("#cardExpired125").text(0);

                  divCard.find("#rowSix").removeClass("levelOneWarning");
                  divCard.find("#rowSix").removeClass("levelTwoWarning");
                  divCard.find("#rowSix").removeClass("levelThreeWarning");
                  divCard.find("#rowSix").addClass("evenRow");
                  divCard.find("#cardInputted200").text(0);
                  divCard.find("#cardSold200").text(0);
                  divCard.find("#cardActivate200").text(0);
                  divCard.find("#cardDeactivate200").text(0);
                  divCard.find("#cardPreExpired200").text(0);
                  divCard.find("#cardExpired200").text(0);

                  divCard.find("#rowSeven").removeClass("levelOneWarning");
                  divCard.find("#rowSeven").removeClass("levelTwoWarning");
                  divCard.find("#rowSeven").removeClass("levelThreeWarning");
                  divCard.find("#rowSeven").addClass("oddRow");
                  divCard.find("#cardInputted300").text(0);
                  divCard.find("#cardSold300").text(0);
                  divCard.find("#cardActivate300").text(0);
                  divCard.find("#cardDeactivate300").text(0);
                  divCard.find("#cardPreExpired300").text(0);
                  divCard.find("#cardExpired300").text(0);

                  divCard.find("#rowEight").removeClass("levelOneWarning");
                  divCard.find("#rowEight").removeClass("levelTwoWarning");
                  divCard.find("#rowEight").removeClass("levelThreeWarning");
                  divCard.find("#rowEight").addClass("evenRow");
                  divCard.find("#cardInputted500").text(0);
                  divCard.find("#cardSold500").text(0);
                  divCard.find("#cardActivate500").text(0);
                  divCard.find("#cardDeactivate500").text(0);
                  divCard.find("#cardPreExpired500").text(0);
                  divCard.find("#cardExpired500").text(0);

                  divCard.find("#rowNine").removeClass("levelOneWarning");
                  divCard.find("#rowNine").removeClass("levelTwoWarning");
                  divCard.find("#rowNine").removeClass("levelThreeWarning");
                  divCard.find("#rowNine").addClass("evenRow");
                  divCard.find("#cardInputted1000").text(0);
                  divCard.find("#cardSold1000").text(0);
                  divCard.find("#cardActivate1000").text(0);
                  divCard.find("#cardDeactivate1000").text(0);
                  divCard.find("#cardPreExpired1000").text(0);
                  divCard.find("#cardExpired1000").text(0);

                  divCard.find("#rowTen").removeClass("levelOneWarning");
                  divCard.find("#rowTen").removeClass("levelTwoWarning");
                  divCard.find("#rowTen").removeClass("levelThreeWarning");
                  divCard.find("#rowTen").addClass("evenRow");
                  divCard.find("#cardInputted2000").text(0);
                  divCard.find("#cardSold2000").text(0);
                  divCard.find("#cardActivate2000").text(0);
                  divCard.find("#cardDeactivate2000").text(0);
                  divCard.find("#cardPreExpired2000").text(0);
                  divCard.find("#cardExpired2000").text(0);

                  divCard.find("#cardInputtedTg").text(0);
                  divCard.find("#cardSoldTg").text(0);
                  divCard.find("#cardActivateTg").text(0);
                  divCard.find("#cardDeactivateTg").text(0);
                  divCard.find("#cardPreExpiredTg").text(0);
                  divCard.find("#cardExpiredTg").text(0);
                }

              function pushDataDivCard(cardTypes, divCard) {
                cleanDataDivCard(divCard);
                $.each(cardTypes, function (i, obj) {
                  if (obj.faceValue === "10000") {
                    divCard.find("#rowOne").addClass(
                        colorLevelWarning(obj.leverWarning, 'oddRow'));
                    divCard.find("#cardInputted10").text(
                        formatNumberSeparator(obj.cardInputted, 'vi'));
                    divCard.find("#cardSold10").text(formatNumberSeparator(obj.cardSold, 'vi'));
                    divCard.find("#cardActivate10").text(
                        formatNumberSeparator(obj.cardActivate, 'vi'));
                    divCard.find("#cardDeactivate10").text(
                        formatNumberSeparator(obj.cardDeactivate, 'vi'));
                    divCard.find("#cardExpired10").text(
                        formatNumberSeparator(obj.cardExpired, 'vi'));
                    divCard.find("#cardPreExpired10").text(
                        formatNumberSeparator(obj.cardPreExpired, 'vi'));
                  } else if (obj.faceValue === "20000") {
                    divCard.find("#rowTwo").addClass(
                        colorLevelWarning(obj.leverWarning, 'evenRow'));
                    divCard.find("#cardInputted20").text(
                        formatNumberSeparator(obj.cardInputted, 'vi'));
                    divCard.find("#cardSold20").text(formatNumberSeparator(obj.cardSold, 'vi'));
                    divCard.find("#cardActivate20").text(
                        formatNumberSeparator(obj.cardActivate, 'vi'));
                    divCard.find("#cardDeactivate20").text(
                        formatNumberSeparator(obj.cardDeactivate, 'vi'));
                    divCard.find("#cardExpired20").text(
                        formatNumberSeparator(obj.cardExpired, 'vi'));
                    divCard.find("#cardPreExpired20").text(
                        formatNumberSeparator(obj.cardPreExpired, 'vi'));
                  } else if (obj.faceValue === "30000") {
                    divCard.find("#rowThree").addClass(
                        colorLevelWarning(obj.leverWarning, 'oddRow'));
                    divCard.find("#cardInputted30").text(
                        formatNumberSeparator(obj.cardInputted, 'vi'));
                    divCard.find("#cardSold30").text(formatNumberSeparator(obj.cardSold, 'vi'));
                    divCard.find("#cardActivate30").text(
                        formatNumberSeparator(obj.cardActivate, 'vi'));
                    divCard.find("#cardDeactivate30").text(
                        formatNumberSeparator(obj.cardDeactivate, 'vi'));
                    divCard.find("#cardExpired30").text(
                        formatNumberSeparator(obj.cardExpired, 'vi'));
                    divCard.find("#cardPreExpired30").text(
                        formatNumberSeparator(obj.cardPreExpired, 'vi'));
                  } else if (obj.faceValue === "40000") {
                    divCard.find("#row40").addClass(
                        colorLevelWarning(obj.leverWarning, 'evenRow'));
                    divCard.find("#cardInputted40").text(
                        formatNumberSeparator(obj.cardInputted, 'vi'));
                    divCard.find("#cardSold40").text(formatNumberSeparator(obj.cardSold, 'vi'));
                    divCard.find("#cardActivate40").text(
                        formatNumberSeparator(obj.cardActivate, 'vi'));
                    divCard.find("#cardDeactivate40").text(
                        formatNumberSeparator(obj.cardDeactivate, 'vi'));
                    divCard.find("#cardExpired40").text(
                        formatNumberSeparator(obj.cardExpired, 'vi'));
                    divCard.find("#cardPreExpired40").text(
                        formatNumberSeparator(obj.cardPreExpired, 'vi'));
                  } else if (obj.faceValue === "50000") {
                    divCard.find("#rowFour").addClass(
                        colorLevelWarning(obj.leverWarning, 'oddRow'));
                    divCard.find("#cardInputted50").text(
                        formatNumberSeparator(obj.cardInputted, 'vi'));
                    divCard.find("#cardSold50").text(formatNumberSeparator(obj.cardSold, 'vi'));
                    divCard.find("#cardActivate50").text(
                        formatNumberSeparator(obj.cardActivate, 'vi'));
                    divCard.find("#cardDeactivate50").text(
                        formatNumberSeparator(obj.cardDeactivate, 'vi'));
                    divCard.find("#cardExpired50").text(
                        formatNumberSeparator(obj.cardExpired, 'vi'));
                    divCard.find("#cardPreExpired50").text(
                        formatNumberSeparator(obj.cardPreExpired, 'vi'));
                  } else if (obj.faceValue === "70000") {
                    divCard.find("#row70").addClass(
                        colorLevelWarning(obj.leverWarning, 'evenRow'));
                    divCard.find("#cardInputted70").text(
                        formatNumberSeparator(obj.cardInputted, 'vi'));
                    divCard.find("#cardSold70").text(formatNumberSeparator(obj.cardSold, 'vi'));
                    divCard.find("#cardActivate70").text(
                        formatNumberSeparator(obj.cardActivate, 'vi'));
                    divCard.find("#cardDeactivate70").text(
                        formatNumberSeparator(obj.cardDeactivate, 'vi'));
                    divCard.find("#cardExpired70").text(
                        formatNumberSeparator(obj.cardExpired, 'vi'));
                    divCard.find("#cardPreExpired70").text(
                        formatNumberSeparator(obj.cardPreExpired, 'vi'));
                  } else if (obj.faceValue === "90000") {
                    divCard.find("#row90").addClass(
                        colorLevelWarning(obj.leverWarning, 'oddRow'));
                    divCard.find("#cardInputted90").text(
                        formatNumberSeparator(obj.cardInputted, 'vi'));
                    divCard.find("#cardSold90").text(formatNumberSeparator(obj.cardSold, 'vi'));
                    divCard.find("#cardActivate90").text(
                        formatNumberSeparator(obj.cardActivate, 'vi'));
                    divCard.find("#cardDeactivate90").text(
                        formatNumberSeparator(obj.cardDeactivate, 'vi'));
                    divCard.find("#cardExpired90").text(
                        formatNumberSeparator(obj.cardExpired, 'vi'));
                    divCard.find("#cardPreExpired90").text(
                        formatNumberSeparator(obj.cardPreExpired, 'vi'));
                  } else if (obj.faceValue === "100000") {
                    divCard.find("#rowFive").addClass(
                        colorLevelWarning(obj.leverWarning, 'evenRow'));
                    divCard.find("#cardInputted100").text(
                        formatNumberSeparator(obj.cardInputted, 'vi'));
                    divCard.find("#cardSold100").text(formatNumberSeparator(obj.cardSold, 'vi'));
                    divCard.find("#cardActivate100").text(
                        formatNumberSeparator(obj.cardActivate, 'vi'));
                    divCard.find("#cardDeactivate100").text(
                        formatNumberSeparator(obj.cardDeactivate, 'vi'));
                    divCard.find("#cardExpired100").text(
                        formatNumberSeparator(obj.cardExpired, 'vi'));
                    divCard.find("#cardPreExpired100").text(
                        formatNumberSeparator(obj.cardPreExpired, 'vi'));
                  }else if (obj.faceValue === "125000") {
                    divCard.find("#row125").addClass(
                        colorLevelWarning(obj.leverWarning, 'oddRow'));
                    divCard.find("#cardInputted125").text(
                        formatNumberSeparator(obj.cardInputted, 'vi'));
                    divCard.find("#cardSold125").text(formatNumberSeparator(obj.cardSold, 'vi'));
                    divCard.find("#cardActivate125").text(
                        formatNumberSeparator(obj.cardActivate, 'vi'));
                    divCard.find("#cardDeactivate125").text(
                        formatNumberSeparator(obj.cardDeactivate, 'vi'));
                    divCard.find("#cardExpired125").text(
                        formatNumberSeparator(obj.cardExpired, 'vi'));
                    divCard.find("#cardPreExpired125").text(
                        formatNumberSeparator(obj.cardPreExpired, 'vi'));
                  }
                  else if (obj.faceValue === "200000") {
                    divCard.find("#rowSix").addClass(
                        colorLevelWarning(obj.leverWarning, 'evenRow'));
                    divCard.find("#cardInputted200").text(
                        formatNumberSeparator(obj.cardInputted, 'vi'));
                    divCard.find("#cardSold200").text(formatNumberSeparator(obj.cardSold, 'vi'));
                    divCard.find("#cardActivate200").text(
                        formatNumberSeparator(obj.cardActivate, 'vi'));
                    divCard.find("#cardDeactivate200").text(
                        formatNumberSeparator(obj.cardDeactivate, 'vi'));
                    divCard.find("#cardExpired200").text(
                        formatNumberSeparator(obj.cardExpired, 'vi'));
                    divCard.find("#cardPreExpired200").text(
                        formatNumberSeparator(obj.cardPreExpired, 'vi'));
                  } else if (obj.faceValue === "300000") {
                    divCard.find("#rowSeven").addClass(
                        colorLevelWarning(obj.leverWarning, 'oddRow'));
                    divCard.find("#cardInputted300").text(
                        formatNumberSeparator(obj.cardInputted, 'vi'));
                    divCard.find("#cardSold300").text(formatNumberSeparator(obj.cardSold, 'vi'));
                    divCard.find("#cardActivate300").text(
                        formatNumberSeparator(obj.cardActivate, 'vi'));
                    divCard.find("#cardDeactivate300").text(
                        formatNumberSeparator(obj.cardDeactivate, 'vi'));
                    divCard.find("#cardExpired300").text(
                        formatNumberSeparator(obj.cardExpired, 'vi'));
                    divCard.find("#cardPreExpired300").text(
                        formatNumberSeparator(obj.cardPreExpired, 'vi'));
                  } else if (obj.faceValue === "500000") {
                    divCard.find("#rowEight").addClass(
                        colorLevelWarning(obj.leverWarning, 'evenRow'));
                    divCard.find("#cardInputted500").text(
                        formatNumberSeparator(obj.cardInputted, 'vi'));
                    divCard.find("#cardSold500").text(formatNumberSeparator(obj.cardSold, 'vi'));
                    divCard.find("#cardActivate500").text(
                        formatNumberSeparator(obj.cardActivate, 'vi'));
                    divCard.find("#cardDeactivate500").text(
                        formatNumberSeparator(obj.cardDeactivate, 'vi'));
                    divCard.find("#cardExpired500").text(
                        formatNumberSeparator(obj.cardExpired, 'vi'));
                    divCard.find("#cardPreExpired500").text(
                        formatNumberSeparator(obj.cardPreExpired, 'vi'));
                  } else if (obj.faceValue === "1000000") {
                    divCard.find("#rowNine").addClass(
                        colorLevelWarning(obj.leverWarning, 'evenRow'));
                    divCard.find("#cardInputted1000").text(
                        formatNumberSeparator(obj.cardInputted, 'vi'));
                    divCard.find("#cardSold1000").text(formatNumberSeparator(obj.cardSold, 'vi'));
                    divCard.find("#cardActivate1000").text(
                        formatNumberSeparator(obj.cardActivate, 'vi'));
                    divCard.find("#cardDeactivate1000").text(
                        formatNumberSeparator(obj.cardDeactivate, 'vi'));
                    divCard.find("#cardExpired1000").text(
                        formatNumberSeparator(obj.cardExpired, 'vi'));
                    divCard.find("#cardPreExpired1000").text(
                        formatNumberSeparator(obj.cardPreExpired, 'vi'));
                  } else if (obj.faceValue === "2000000") {
                    divCard.find("#rowTen").addClass(
                        colorLevelWarning(obj.leverWarning, 'evenRow'));
                    divCard.find("#cardInputted2000").text(
                        formatNumberSeparator(obj.cardInputted, 'vi'));
                    divCard.find("#cardSold2000").text(formatNumberSeparator(obj.cardSold, 'vi'));
                    divCard.find("#cardActivate2000").text(
                        formatNumberSeparator(obj.cardActivate, 'vi'));
                    divCard.find("#cardDeactivate2000").text(
                        formatNumberSeparator(obj.cardDeactivate, 'vi'));
                    divCard.find("#cardExpired2000").text(
                        formatNumberSeparator(obj.cardExpired, 'vi'));
                    divCard.find("#cardPreExpired2000").text(
                        formatNumberSeparator(obj.cardPreExpired, 'vi'));
                  }
                });
                divCard.find("#cardInputtedTg").text(
                    formatNumberSeparator(
                        parseInt(divCard.find("#cardInputted10").text().replace(".", "")) +
                        parseInt(divCard.find("#cardInputted20").text().replace(".", "")) +
                        parseInt(divCard.find("#cardInputted30").text().replace(".", "")) +
                        parseInt(divCard.find("#cardInputted40").text().replace(".", "")) +
                        parseInt(divCard.find("#cardInputted50").text().replace(".", "")) +
                        parseInt(divCard.find("#cardInputted70").text().replace(".", "")) +
                        parseInt(divCard.find("#cardInputted90").text().replace(".", "")) +
                        parseInt(divCard.find("#cardInputted100").text().replace(".", "")) +
                        parseInt(divCard.find("#cardInputted125").text().replace(".", "")) +
                        parseInt(divCard.find("#cardInputted200").text().replace(".", "")) +
                        parseInt(divCard.find("#cardInputted300").text().replace(".", "")) +
                        parseInt(divCard.find("#cardInputted500").text().replace(".", "")) +
                        parseInt(divCard.find("#cardInputted1000").text().replace(".", "")) +
                        parseInt(divCard.find("#cardInputted2000").text().replace(".", ""))
                        , 'vi')
                );
                divCard.find("#cardSoldTg").text(
                    formatNumberSeparator(
                        parseInt(divCard.find("#cardSold10").text().replace(".", "")) +
                        parseInt(divCard.find("#cardSold20").text().replace(".", "")) +
                        parseInt(divCard.find("#cardSold30").text().replace(".", "")) +
                        parseInt(divCard.find("#cardSold40").text().replace(".", "")) +
                        parseInt(divCard.find("#cardSold50").text().replace(".", "")) +
                        parseInt(divCard.find("#cardSold70").text().replace(".", "")) +
                        parseInt(divCard.find("#cardSold90").text().replace(".", "")) +
                        parseInt(divCard.find("#cardSold100").text().replace(".", "")) +
                        parseInt(divCard.find("#cardSold125").text().replace(".", "")) +
                        parseInt(divCard.find("#cardSold200").text().replace(".", "")) +
                        parseInt(divCard.find("#cardSold300").text().replace(".", "")) +
                        parseInt(divCard.find("#cardSold500").text().replace(".", "")) +
                        parseInt(divCard.find("#cardSold1000").text().replace(".", "")) +
                        parseInt(divCard.find("#cardSold2000").text().replace(".", ""))
                        , 'vi')
                );
                divCard.find("#cardActivateTg").text(
                    formatNumberSeparator(
                        parseInt(divCard.find("#cardActivate10").text().replace(".", "")) +
                        parseInt(divCard.find("#cardActivate20").text().replace(".", "")) +
                        parseInt(divCard.find("#cardActivate30").text().replace(".", "")) +
                        parseInt(divCard.find("#cardActivate40").text().replace(".", "")) +
                        parseInt(divCard.find("#cardActivate50").text().replace(".", "")) +
                        parseInt(divCard.find("#cardActivate70").text().replace(".", "")) +
                        parseInt(divCard.find("#cardActivate90").text().replace(".", "")) +
                        parseInt(divCard.find("#cardActivate100").text().replace(".", "")) +
                        parseInt(divCard.find("#cardActivate125").text().replace(".", "")) +
                        parseInt(divCard.find("#cardActivate200").text().replace(".", "")) +
                        parseInt(divCard.find("#cardActivate300").text().replace(".", "")) +
                        parseInt(divCard.find("#cardActivate500").text().replace(".", "")) +
                        parseInt(divCard.find("#cardActivate1000").text().replace(".", "")) +
                        parseInt(divCard.find("#cardActivate2000").text().replace(".", ""))
                        , 'vi')
                );
                divCard.find("#cardDeactivateTg").text(
                    formatNumberSeparator(
                        parseInt(divCard.find("#cardDeactivate10").text().replace(".", "")) +
                        parseInt(divCard.find("#cardDeactivate20").text().replace(".", "")) +
                        parseInt(divCard.find("#cardDeactivate30").text().replace(".", "")) +
                        parseInt(divCard.find("#cardDeactivate40").text().replace(".", "")) +
                        parseInt(divCard.find("#cardDeactivate50").text().replace(".", "")) +
                        parseInt(divCard.find("#cardDeactivate70").text().replace(".", "")) +
                        parseInt(divCard.find("#cardDeactivate90").text().replace(".", "")) +
                        parseInt(divCard.find("#cardDeactivate100").text().replace(".", "")) +
                        parseInt(divCard.find("#cardDeactivate125").text().replace(".", "")) +
                        parseInt(divCard.find("#cardDeactivate200").text().replace(".", "")) +
                        parseInt(divCard.find("#cardDeactivate300").text().replace(".", "")) +
                        parseInt(divCard.find("#cardDeactivate500").text().replace(".", "")) +
                        parseInt(divCard.find("#cardDeactivate1000").text().replace(".", "")) +
                        parseInt(divCard.find("#cardDeactivate2000").text().replace(".", ""))
                        , 'vi')
                );
                divCard.find("#cardExpiredTg").text(
                    formatNumberSeparator(
                        parseInt(divCard.find("#cardExpired10").text().replace(".", "")) +
                        parseInt(divCard.find("#cardExpired20").text().replace(".", "")) +
                        parseInt(divCard.find("#cardExpired30").text().replace(".", "")) +
                        parseInt(divCard.find("#cardExpired40").text().replace(".", "")) +
                        parseInt(divCard.find("#cardExpired50").text().replace(".", "")) +
                        parseInt(divCard.find("#cardExpired70").text().replace(".", "")) +
                        parseInt(divCard.find("#cardExpired90").text().replace(".", "")) +
                        parseInt(divCard.find("#cardExpired100").text().replace(".", "")) +
                        parseInt(divCard.find("#cardExpired125").text().replace(".", "")) +
                        parseInt(divCard.find("#cardExpired200").text().replace(".", "")) +
                        parseInt(divCard.find("#cardExpired300").text().replace(".", "")) +
                        parseInt(divCard.find("#cardExpired500").text().replace(".", "")) +
                        parseInt(divCard.find("#cardExpired1000").text().replace(".", "")) +
                        parseInt(divCard.find("#cardExpired2000").text().replace(".", ""))
                        , 'vi')
                );
                divCard.find("#cardPreExpiredTg").text(
                    formatNumberSeparator(
                        parseInt(divCard.find("#cardPreExpired10").text().replace(".", "")) +
                        parseInt(divCard.find("#cardPreExpired20").text().replace(".", "")) +
                        parseInt(divCard.find("#cardPreExpired30").text().replace(".", "")) +
                        parseInt(divCard.find("#cardPreExpired40").text().replace(".", "")) +
                        parseInt(divCard.find("#cardPreExpired50").text().replace(".", "")) +
                        parseInt(divCard.find("#cardPreExpired70").text().replace(".", "")) +
                        parseInt(divCard.find("#cardPreExpired90").text().replace(".", "")) +
                        parseInt(divCard.find("#cardPreExpired100").text().replace(".", "")) +
                        parseInt(divCard.find("#cardPreExpired125").text().replace(".", "")) +
                        parseInt(divCard.find("#cardPreExpired200").text().replace(".", "")) +
                        parseInt(divCard.find("#cardPreExpired300").text().replace(".", "")) +
                        parseInt(divCard.find("#cardPreExpired500").text().replace(".", "")) +
                        parseInt(divCard.find("#cardPreExpired1000").text().replace(".", "")) +
                        parseInt(divCard.find("#cardPreExpired2000").text().replace(".", ""))
                        , 'vi')
                );
                return divCard;
              }
              function colorLevelWarning(level, leverDefault) {
                if (level === 0) {
                  return leverDefault;
                } else if (level === 1) {
                  return "levelThreeWarning";
                } else if (level === 2) {
                  return "levelTwoWarning";
                } else if (level === 3) {
                  return "levelOneWarning";
                }
              }

              function formatNumberSeparator(x, locale) {
                var locale = "vi";
                var separator = ",";
                if (locale === "vi") {
                  separator = ".";
                }
                return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, separator);
              }

              function drawPieChart(data, title, type, divId) {
                chartData = new google.visualization.DataTable();
                chartData.addColumn('string', title);
                chartData.addColumn('number', 'cards');
                var dataArray = [];
                $.each(data, function (i, obj) {
                  dataArray.push(
                      [obj.name + ': ' + formatNumberSeparator(obj.value, '') + ' ' + type,
                        obj.value])
                });
                chartData.addRows(dataArray);
                var options = {
                  title: title,
                  titleTextStyle: {
                    color: 'black',    // any HTML string color ('red', '#cc00cc')
                    /*fontName: 'Times New Roman', // i.e. 'Times New Roman'*/
                    fontSize: 16, // 12, 18 whatever you want (don't specify px)
                    bold: false,    // true or false
                    italic: false   // true of false
                  },
                  sliceVisibilityThreshold: 0,
                  tooltip: {
                    text: 'percentage'
                  },
                  chartArea: {left: 10, top: 35, width: '100%', height: '65%'},
                  /*chartArea:{
                   top:20,
                   left:100
                   },*/
                  colors: ['#818996', '#67A22C', '#D2EBC3']
                };
                var chart = new google.visualization.PieChart(document.getElementById(divId));
                chart.draw(chartData, options);
              }
              });

              function anchorLink(href) {
                $('html, body').animate({scrollTop: $(href).offset().top - 500}, 'slow');
              }

              function anchorEndPage(href) {
                $("html, body").animate({scrollTop: $(document).height()}, 500);
              }
            </script>
        </section>
        <jsp:include page="../include_page/footer.jsp"/>
    </div>
</section>
<jsp:include page="../include_page/js_footer.jsp"/>
<jsp:include page="../include_page/date_picker.jsp">
    <jsp:param name="isFullTime" value="true"/>
</jsp:include>
<script type="text/javascript">
  $('#provider').multiselect({
    includeSelectAllOption: true,
    selectAllValue: '',
    maxHeight: 400,
    dropUp: true,
    nonSelectedText: '<spring:message code="common.select.provider" />',
    inheritClass: true
  });

  $('#cardType').multiselect({
    includeSelectAllOption: true,
    selectAllValue: '',
    maxHeight: 400,
    dropUp: true,
    nonSelectedText: '<spring:message code="common.select.card.type" />',
    inheritClass: true
  });

  $('#faceValue').multiselect({
    includeSelectAllOption: true,
    selectAllValue: '',
    maxHeight: 400,
    dropUp: true,
    nonSelectedText: '<spring:message code="common.select.card.value" />',
    inheritClass: true
  });

  $('#specialCard').on('change', function () {
    if (this.value === '1') {
      $('#specialCustomer').prop('disabled', false);
    } else {
      $('#specialCustomer').prop('disabled', true);
    }
  });
</script>
</body>
</html>