<%@ page import="vn.mog.ewallet.constant.SharedConstants" %>
<%@ page import="static vn.mog.ewallet.constant.SessionConstants.SESSION_ACCOUNT_LOGIN" %>
<%@ page import="vn.mog.ewallet.web.contract.UrlIntergration" %>
<%@ page import="vn.mog.ewallet.web.contract.UserLogin" %>
<%@ page import="static vn.mog.ewallet.web.contract.UrlIntergration.FUND_IN_HISTORY_LIST" %>
<%@ page
        import="static vn.mog.ewallet.constant.SharedConstants.WEB_DOMAIN_PLATFORM_OPERATION_URL" %>
<%@ include file="taglibs.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<c:set var="topupOperationUrl" value="<%=WEB_DOMAIN_PLATFORM_OPERATION_URL%>" scope="application"/>
<c:set var="opSubpathEpinStoreUrl"
       value="<%=SharedConstants.WEB_DOMAIN_PLATFORM_OPERATION_SUBPATH_EPIN_STORE_N02_URL%>"
       scope="application"/>


<%
    String menu = (String) request.getSession().getAttribute("menu");
    UserLogin userLogin = (UserLogin) request.getSession().getAttribute(SESSION_ACCOUNT_LOGIN);
    if (userLogin == null) {
        userLogin = new UserLogin();
    }
%>
<c:set var="userLogin" value="<%=userLogin%>" scope="application"/>
<c:set var="contextPath" value="${pageContext.request.contextPath}" scope="application"/>

<%if (menu != null) {%>
<c:set var="menu" value="<%=menu%>" scope="page"/>
<%} else {%>
<c:set var="menu" value="${menu}" scope="page"/>
<%}%>

<style type="text/css">
    .group-apps {
        background: #fff;
        margin: 0;
        min-height: 100px;
        padding: 10px;
        text-align: left;
        white-space: normal;
        width: 200px;
    }

    .group-apps:before {
        left: 12.5em !important;
    }

    .item-apps:hover {
        z-index: 1001;
    }

    .item-apps {
        padding: 1px;
        display: inline-block;
        vertical-align: top;
        color: black;
        z-index: 999;
        height: 86px;
        width: 86px;
    }

    .item-apps a {
        padding-left: 15px;
    }

    .item-app-image {
        background-image: url('data:image/png;base64,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');
        background-repeat: no-repeat;
        display: inline-block;
        vertical-align: top;
        height: 64px;
        width: 64px;
    }

    .gb_Z {
        display: block;
        line-height: 20px;
        overflow: hidden;
        white-space: nowrap;
        width: 84px;
        text-overflow: ellipsis;
    }

    @media all and (max-width: 1415px) {
        .wallet-apps {
            height: 34px !important;
            width: 34px !important;
            /*float: left !important;*/
            vertical-align: middle !important;
            display: inline-block !important;
            position: absolute !important;
            right: 86px !important;
            top: 11px !important;
        }
    }

    @media all and (max-width: 767px) {
        .wallet-apps {
            height: 34px;
            width: 34px;
            float: left;
            vertical-align: middle;
            display: inline-block;
            position: absolute;
            right: 86px;
            top: 11px;
        }
    }
</style>

<sec:authorize
        access="hasAnyRole('SALE_AGENT')"
        var="isSaleAgent"/>
<sec:authorize
        access="hasAnyRole('SALE_MERCHANT')"
        var="isSaleMerchant"/>

<sec:authorize
        access="hasAnyRole('ADMIN_OPERATION','SALESUPPORT','SALESUPPORT_LEADER','SALESUPPORT_MANAGER','TECHSUPPORT','CUSTOMERCARE')"
        var="defaultUriProviderTab"/>
<c:set var="urlProviderTab">
    <c:choose>
        <c:when test="${defaultUriProviderTab}">${topupOperationUrl}<%=UrlIntergration.PROVIDER_TAB%>
        </c:when>
        <c:otherwise>${opSubpathEpinStoreUrl}/provider/cardstore/dashboard</c:otherwise>
    </c:choose>
</c:set>


<sec:authorize access="hasAnyRole('AGEN','CUSTOMER','MERCHANT','TELCO','AGGREATOR','BILLER')"
               var="defaultUriWalletTab"/>
<c:set var="urlWalletTab">
    <c:choose>
        <c:when test="${defaultUriWalletTab}">
            ${topupOperationUrl}<%=FUND_IN_HISTORY_LIST%>
        </c:when>
        <c:otherwise>
            ${topupOperationUrl}<%=UrlIntergration.WALLET_TAB%>
        </c:otherwise>
    </c:choose>
</c:set>
<c:set var="urlServiceTab" value="${topupOperationUrl}/service/transaction-history/list"/>
<%--<c:set var="urlSettingTab"><%=SUBPATH_SETTING_URL%></c:set>--%>
<c:set var="urlOperationTab"><%=UrlIntergration.SUBPATH_OPERATION_URL%>
</c:set>
<c:set var="urlBillpayTab"><%=UrlIntergration.SUBPATH_BILLPAY_URL%>
</c:set>
<c:set var="urlChangePass" value="${topupOperationUrl}/staff-account/manage/change-password"/>

<%--<c:set var="urlCustomerTab"><%=SUBPATH_CUSTOMER_URL%></c:set>--%>

<%--STAFF ACCOUNT--%>
<c:set var="urlSettingTab" value="${topupOperationUrl}/staff-account/manage/list?menu=setting"/>
<%--CUSTOMER--%>
<c:set var="urlCustomerTab" value="${topupOperationUrl}/customer/manage/list-all?menu=cus"/>
<c:set var="urlCustomerTabAgent"
       value="${topupOperationUrl}/customer/manage/list?menu=cus&customerType=2"/>
<c:set var="urlCustomerTabMerchant"
       value="${topupOperationUrl}/customer/manage/list?menu=cus&customerType=3"/>

<sec:authorize
        access="hasAnyRole('FA_MANAGER','FINANCE_LEADER','FINANCESUPPORT_LEADER','FINANCE_SUPPORT','FINANCE')"
        var="permisFinance"/>
<header class="header navbar navbar-secondary">
    <div class="progress skill-bar hidden" id="loader">
        <div class="progress-bar progress-bar-loading" role="progressbar" aria-valuenow="100"
             aria-valuemin="0" aria-valuemax="100">
            <span class="skill">Loading...<i class="val">100%</i></span>
        </div>
    </div>
    <div class="container-fluid navbar-container">
        <nav class="navbar navbar-default navbar-default-normal" role="navigation">
            <div class="navbar-header">
                <%--<a class="navbar-brand navbar-brand-secondary" href="#">Zo-Ta</a>--%>
                <div class="navbar-brand sprite-img-logo2x_150_50"></div>
            </div>
            <div class="collapse navbar-collapse navbar-ex1-collapse">

                <ul class="navbar-nav nav" style="margin-left: 3em">

                    <%--<sec:authorize access="hasAnyRole('ADMIN_OPERATION','SALE_DIRECTOR','SALE_EXCUTIVE',--%>
                    <%--'SALE_SUPERVISOR','SALE_ASM','SALE_RSM')">--%>
                    <%--<li class="${not empty menu && menu == 'cus' ? 'active' : '' }">--%>
                    <%--<a href="${ewallet:isSignature(urlCustomerTab, '')}"><spring:message--%>
                    <%--code="header.menu.tab.customer"/></a>--%>
                    <%--</li>--%>
                    <%--</sec:authorize>--%>

                    <%-- Khách hàng--%>
                    <sec:authorize
                            access="hasAnyRole('ADMIN_OPERATION','SALE_DIRECTOR','SALESUPPORT_MANAGER' ,'SALESUPPORT','CUSTOMERCARE_MANAGER','CUSTOMERCARE')"
                            var="permisAll"/>
                    <sec:authorize
                            access="hasAnyRole('SALE_EXCUTIVE','SALE_SUPERVISOR','SALE_ASM','SALE_RSM')"
                            var="permisSale"/>

                    <li class="${not empty menu && menu == 'cus' ? 'active' : '' }">
                        <c:if test="${(permisAll) || (permisFinance)}">
                            <a href="${ewallet:isSignature(urlCustomerTab, '')}"><spring:message
                                    code="header.menu.tab.customer"/></a>
                        </c:if>

                        <c:if test="${(permisSale) && isSaleAgent}">
                            <a href="${ewallet:isSignature(urlCustomerTabAgent, '')}"><spring:message
                                    code="header.menu.tab.customer"/></a>
                        </c:if>
                        <c:if test="${(permisSale) && isSaleMerchant}">
                            <a href="${ewallet:isSignature(urlCustomerTabMerchant, '')}"><spring:message
                                    code="header.menu.tab.customer"/></a>
                        </c:if>
                    </li>
                    <%-- end khách hàng--%>


                       <%-- PROVIDER--%>
                    <sec:authorize access="hasAnyRole('ADMIN_OPERATION',
                'SALESUPPORT_LEADER', 'TECHSUPPORT',
                'CUSTOMERCARE_MANAGER','CUSTOMERCARE',
                'SALESUPPORT','SALESUPPORT_MANAGER',
                'SALE_DIRECTOR','SALE_EXCUTIVE','SALE_SUPERVISOR','SALE_ASSISTANT','SALE_ASM','SALE_RSM',
                'FA_MANAGER','FINANCE_LEADER','FINANCESUPPORT_LEADER','FINANCE_SUPPORT','FINANCE')">
                        <li class="${not empty menu && menu == 'pro' ? 'active' : '' }">
                            <a href="${ewallet:isSignature(urlProviderTab, 'pro')}"><spring:message
                                    code="header.menu.tab.provider"/></a>
                        </li>
                    </sec:authorize>
                        <%-- end PROVIDER--%>

                        <%--WALLET--%>
                    <sec:authorize access="hasAnyRole('ADMIN_OPERATION','TECHSUPPORT',
                    'FA_MANAGER','FINANCE_LEADER','FINANCESUPPORT_LEADER','FINANCE_SUPPORT','FINANCE',
                    'SALESUPPORT', 'SALESUPPORT_MANAGER','SALESUPPORT_LEADER',
                    'SALE_DIRECTOR','SALE_EXCUTIVE','SALE_SUPERVISOR','SALE_ASSISTANT','SALE_ASM','SALE_RSM',
                    'CUSTOMERCARE_MANAGER','CUSTOMERCARE','ACCOUNTING',
                    'MERCHANT','AGENT','CUSTOMER','TELCO','AGGREATOR','BILLER',
                    'RECONCILIATION', 'RECONCILIATION_LEADER')">
                        <li class="${not empty menu && menu == 'wal' ? 'active' : '' }">
                            <a href="${ewallet:isSignature(urlWalletTab, 'wal')}"><spring:message
                                    code="header.menu.tab.wallet"/></a>
                        </li>
                    </sec:authorize>
                       <%-- end WALLET--%>

                    <sec:authorize access="hasAnyRole('ADMIN_OPERATION','STAFF',
                'FA_MANAGER','FINANCE_LEADER','FINANCESUPPORT_LEADER','FINANCE_SUPPORT','FINANCE',
                'ACCOUNTING','TECHSUPPORT',
                'MERCHANT','AGENT','CUSTOMER',
                'CUSTOMERCARE_MANAGER','CUSTOMERCARE','CUSTOMERCARE',
                'SALE','SALE_ASM','SALE_EXCUTIVE','PROVIDER',
                'SALESUPPORT_LEADER','SALESUPPORT_MANAGER','SALESUPPORT')">
                        <li class="${not empty menu && menu == 'ser' ? 'active' : '' }">
                            <a href="${ewallet:isSignature(urlServiceTab, 'ser')}"><spring:message
                                    code="header.menu.tab.service"/></a>
                        </li>
                    </sec:authorize>

                    <sec:authorize access="hasAnyRole('ADMIN_OPERATION')">
                        <li class="${not empty menu && menu == 'set' ? 'active' : '' }">
                            <a href="${ewallet:isSignature(urlSettingTab, '')}"><spring:message
                                    code="header.menu.tab.platform.config"/></a>
                        </li>
                    </sec:authorize>

                    <sec:authorize access="hasAnyRole('ADMIN_OPERATION')">
                        <li class="${not empty menu && menu == 'all' ? 'active' : '' }">
                            <a href="${uri_all}"><spring:message
                                    code="header.menu.tab.all"/></a>
                        </li>
                    </sec:authorize>
                </ul>

                <ul class="nav navbar-nav navbar-right" id="navbar-main-2">
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle"
                           data-toggle="dropdown">${pageContext.response.locale.language eq 'en' ? 'English' : 'Tiếng Việt'}&nbsp;<b
                                class="caret"></b></a>
                        <ul class="dropdown-menu animated" data-animation="fadeInDown-1">
                            <li><a href="lang=en" id="langEn">
                                <div class="sprite-img-en"></div>
                                <span style="vertical-align: top;">&nbsp;English</span></a></li>
                            <li><a href="lang=vi" id="langVi">
                                <div class="sprite-img-vn"></div>
                                <span style="vertical-align: top;">&nbsp;Tiếng Việt</span></a></li>
                        </ul>
                    </li>


                    <!-- Wallet Apps -->
                    <li class="dropdown" title="Platform Apps">
                        <a class="dropdown-toggle" href="#" data-toggle="dropdown"
                           style="padding-left: 0; padding-right: 10px;">
                            <div style="background-repeat: repeat-y;
                   background-image: url('data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABoAAAAaCAMAAACelLz8AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAACVVBMVEVEREAAAABEREBEREBEREBEREBEREBEREBEREBEREBEREBEREBEREBEREBEREC9vbIGBgYDAwIDAwIDAwIDAwIDAwMMDAwJCQgDAwMDAwIDAwIDAwMJCQgMDAwDAwMDAwIDAwIGBgatraMDAwIBAQEFBQUEBAMBAQEBAQEDAwIDAwIFBQUEBAMBAQEEBAMBAQEFBQUDAwIBAQEBAQEBAQEBAQEGBgUEBAQBAQEBAQEBAQEEBAQGBgUBAQEDAwNhYVsMDAwFBQUFBQUFBQUGBgUWFhQQEA8GBgUFBQUFBQUGBgUQEA8WFhQGBgUFBQUFBQUMDAxfX1p9fXYJCQgEBAMEBAMEBAMLCwsEBAMEBAMEBAMEBAMLCwsQEA8EBAQEBAMEBAMJCQh4eHEBAQEBAQEBAQEBAQEGBgUEBAMBAQEBAQEBAQEEBAMGBgUBAQEBAQEDAwMFBQUEBAMBAQEDAwIDAwMBAQEBAQEGBgUEBAMBAQEEBAMGBgUBAQF9fXYJCQgEBAMEBAMEBAQQEA8EBAMEBAMLCwsQEA8EBAQEBAMJCQhhYVsMDAwFBQUGBgUWFhQQEA8GBgUGBgUQEA8WFhQGBgUFBQUMDAxfX1oDAwMBAQEGBgUEBAQBAQEBAQEEBAQGBgUBAQEBAQEBAQEDAwO9vbIDAwIDAwIMDAwJCQgDAwMDAwIDAwIJCQgMDAwDAwMDAwIDAwIGBgaurqREREBEREBEREBEREBEREBEREBEREBEREBEREBEREBEREBEREBEREABAQEBAQEBAQEBAQEBAQH///9I3DtKAAAAwXRSTlMAAAICAAADAgAAAgMAAgIBKmVlZWVfFR9jZWVjHxVfZWUqAWXvMUn572VlMUn5Se8xZfDv8OEuRerw6kUu4V8CFTExMS4MEDAxMTAQDC4xMRUCAh9JSUkXR0lJRxcQRUlJHwL6+fn6MEf0+vRHMOr6YzFJ+WVj+uowR/RHMPoCH0lJRRBHRxcQRUkfAhUxLgwQMDAQDC4xFQJf8C5F8OpFLuHw8F8BZWUVH2NlZR8VX2VlKgECAgADAgAAAgMAAAID4EZVEQAAAAFiS0dExvoCes0AAAAHdElNRQfjARADEyRu16a5AAABpklEQVQoz2NgYmZhYGRkYGVj5wDRnFzcPCCagZePgV9AUEhYWERUTFxCUlhYSlpGVk5eWFhIQVGJgVH54KFDhw6rqKqpAxkH1dVUNQ4DBQ5qMjIwah08cuTIQQ1tHV0gfURXT1sDLKBMtpTm0YMHDx7VNwDaBQTqagb6YAFDoJSokbGGhompmbmFpYaGpZW1ja2JhoaxkR0jg72Do5O2trOLq5u7h7a2p5e3j6+ftraTf0AgQ1BwSKiOTpi5W3hEpI5OVHRMbFy8jk5oQmISA6NEckpqappFekZmVmpqVnZObl5aampKfgHQLuXDYC8XFhUD6UPFaoUqYIESsv2Fx8DSMpAzyisqs0HOqKqusQA5o1aakaGuvgHo+Mam5piWKKDjW9vaO8KAju/sSmLo7ukFebmvf8JEkJcnTZ4yFeTladNnMDDOnAUKKNvZc/LmAgNq3vwFCxcBA2rxEvzBS7y/dIj0MjjZaBjAko0B2MsHgXYtVVwmpKy83G7FylWrlZXXSK9dt36DsrLQxk2bGbZsZQAlyW3bd+wE0bt279kLovftPwAAQIYMBNxBDOMAAAAldEVYdGRhdGU6Y3JlYXRlADIwMTktMDEtMTZUMDM6MTk6MzYtMDU6MDBbTobCAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDE5LTAxLTE2VDAzOjE5OjM2LTA1OjAwKhM+fgAAAABJRU5ErkJggg==')">
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            </div>
                        </a>
                        <ul class="dropdown-menu animated group-apps" data-animation="fadeInDown-1">
                            <li class="item-apps">
                                <a href="<%=SharedConstants.WEB_DOMAIN_PLATFORM_UAA_URL%>"
                                   title="My Profile">
                                    <span class="item-app-image">&nbsp;</span>
                                    <span class="gb_Z">My Profile</span>
                                </a>
                            </li>
                            <li class="item-apps">
                                <a href="<%=SharedConstants.WEB_DOMAIN_PLATFORM_OPERATION_URL%>"
                                   title="Operation">
                                    <span class="item-app-image">&nbsp;</span>
                                    <span class="gb_Z">Operation</span>
                                </a>
                            </li>
                        </ul>
                    </li>
                    <!-- /Wallet Apps -->

                    <li class="modal-with-move-anim guide_alert guide_alert_bt_responsive guide_alert_over"
                        href="#">
                        <span class="pl_remaining_setup_steps_coun">0</span>
                        <i class=""><img src="${contextPath}/assets/images/icon/menu/bell.png"
                                         style="width: 24px;height: 24px"></i>
                    </li>
                    <li class="mney">
                        <%--<a style=""><fmt:formatNumber type="number" maxFractionDigits="3"--%>
                        <%--value="${userLogin.balance}"/>&nbsp;<span>VND</span></a>--%>
                        <a class="link-active" href="#">Helpdesk</a>
                    </li>
                    <li class="dropdown">
                        <a class="dropdown-toggle" href="#" data-toggle="dropdown"
                           style="padding-right: 6px">
                            <div class="sprite-img-user_login_36 img-account" data-toggle="tooltip"
                                 data-placement="left"
                                 title=${userLogin.username}></div>&nbsp;
                        </a>
                        <ul class="dropdown-menu animated" data-animation="fadeInDown-1">
                            <li><a href="${ewallet:isSignature(urlChangePass, '')}"><spring:message
                                    code="header.change.password"/></a></li>
                            <li class="divider" role="separator"></li>
                            <li><a href="<c:url value='/logout.html'/>"><spring:message
                                    code="header.sign.out"/></a></li>
                            </a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </nav>

        <%--RESPONSIVE MOBILE--%>
        <nav class="navbar navbar-default navbar-default-responsive" role="navigation">
            <div class="visible-xs toggle-sidebar-left" data-toggle-class="sidebar-left-opened"
                 data-target="html" data-fire-event="sidebar-left-opened"></div>
            <div class="navbar-header">
                <button class="navbar-toggle" type="button" data-toggle="collapse"
                        data-target=".navbar-ex1-collapse-1"></button>
                <a class="modal-with-move-anim guide_alert guide_alert_bt_responsive guide_alert_over"
                   href="#modalAnim"><span class="pl_remaining_setup_steps_coun">0</span>
                    <i class=""><img src="${contextPath}/assets/images/icon/menu/bell.png"
                                     style="width: 24px;height: 24px"></i>

                <div class="wallet-apps">
                    <ul>
                        <li class="dropdown" title="Platform Apps">
                            <a class="dropdown-toggle" href="#" data-toggle="dropdown">
                                <div title="Wallet Apps" style="background-repeat: no-repeat;height: 36px;width: 36px;
                      background-image: url('data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABoAAAAaCAMAAACelLz8AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAACVVBMVEVEREAAAABEREBEREBEREBEREBEREBEREBEREBEREBEREBEREBEREBEREBEREC9vbIGBgYDAwIDAwIDAwIDAwIDAwMMDAwJCQgDAwMDAwIDAwIDAwMJCQgMDAwDAwMDAwIDAwIGBgatraMDAwIBAQEFBQUEBAMBAQEBAQEDAwIDAwIFBQUEBAMBAQEEBAMBAQEFBQUDAwIBAQEBAQEBAQEBAQEGBgUEBAQBAQEBAQEBAQEEBAQGBgUBAQEDAwNhYVsMDAwFBQUFBQUFBQUGBgUWFhQQEA8GBgUFBQUFBQUGBgUQEA8WFhQGBgUFBQUFBQUMDAxfX1p9fXYJCQgEBAMEBAMEBAMLCwsEBAMEBAMEBAMEBAMLCwsQEA8EBAQEBAMEBAMJCQh4eHEBAQEBAQEBAQEBAQEGBgUEBAMBAQEBAQEBAQEEBAMGBgUBAQEBAQEDAwMFBQUEBAMBAQEDAwIDAwMBAQEBAQEGBgUEBAMBAQEEBAMGBgUBAQF9fXYJCQgEBAMEBAMEBAQQEA8EBAMEBAMLCwsQEA8EBAQEBAMJCQhhYVsMDAwFBQUGBgUWFhQQEA8GBgUGBgUQEA8WFhQGBgUFBQUMDAxfX1oDAwMBAQEGBgUEBAQBAQEBAQEEBAQGBgUBAQEBAQEBAQEDAwO9vbIDAwIDAwIMDAwJCQgDAwMDAwIDAwIJCQgMDAwDAwMDAwIDAwIGBgaurqREREBEREBEREBEREBEREBEREBEREBEREBEREBEREBEREBEREBEREABAQEBAQEBAQEBAQEBAQH///9I3DtKAAAAwXRSTlMAAAICAAADAgAAAgMAAgIBKmVlZWVfFR9jZWVjHxVfZWUqAWXvMUn572VlMUn5Se8xZfDv8OEuRerw6kUu4V8CFTExMS4MEDAxMTAQDC4xMRUCAh9JSUkXR0lJRxcQRUlJHwL6+fn6MEf0+vRHMOr6YzFJ+WVj+uowR/RHMPoCH0lJRRBHRxcQRUkfAhUxLgwQMDAQDC4xFQJf8C5F8OpFLuHw8F8BZWUVH2NlZR8VX2VlKgECAgADAgAAAgMAAAID4EZVEQAAAAFiS0dExvoCes0AAAAHdElNRQfjARADEyRu16a5AAABpklEQVQoz2NgYmZhYGRkYGVj5wDRnFzcPCCagZePgV9AUEhYWERUTFxCUlhYSlpGVk5eWFhIQVGJgVH54KFDhw6rqKqpAxkH1dVUNQ4DBQ5qMjIwah08cuTIQQ1tHV0gfURXT1sDLKBMtpTm0YMHDx7VNwDaBQTqagb6YAFDoJSokbGGhompmbmFpYaGpZW1ja2JhoaxkR0jg72Do5O2trOLq5u7h7a2p5e3j6+ftraTf0AgQ1BwSKiOTpi5W3hEpI5OVHRMbFy8jk5oQmISA6NEckpqappFekZmVmpqVnZObl5aampKfgHQLuXDYC8XFhUD6UPFaoUqYIESsv2Fx8DSMpAzyisqs0HOqKqusQA5o1aakaGuvgHo+Mam5piWKKDjW9vaO8KAju/sSmLo7ukFebmvf8JEkJcnTZ4yFeTladNnMDDOnAUKKNvZc/LmAgNq3vwFCxcBA2rxEvzBS7y/dIj0MjjZaBjAko0B2MsHgXYtVVwmpKy83G7FylWrlZXXSK9dt36DsrLQxk2bGbZsZQAlyW3bd+wE0bt279kLovftPwAAQIYMBNxBDOMAAAAldEVYdGRhdGU6Y3JlYXRlADIwMTktMDEtMTZUMDM6MTk6MzYtMDU6MDBbTobCAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDE5LTAxLTE2VDAzOjE5OjM2LTA1OjAwKhM+fgAAAABJRU5ErkJggg==')">
                                    &nbsp;
                                </div>
                            </a>
                            <ul class="dropdown-menu animated group-apps"
                                data-animation="fadeInDown-1"
                                style="left: -16rem; width: 200px; height: 109px;">
                                <li class="item-apps">
                                    <a href="<%=SharedConstants.WEB_DOMAIN_PLATFORM_UAA_URL%>"
                                       title="My Profile" style="padding-left: 15px;">
                                        <img class="item-app-image"
                                             src="data:image/png;base64,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">&nbsp;</img>
                                        <div class="gb_Z">My Profile</div>
                                    </a>
                                </li>
                                <li class="item-apps">
                                    <a href="<%=SharedConstants.WEB_DOMAIN_PLATFORM_OPERATION_URL%>"
                                       title="Operation">
                                        <img class="item-app-image"
                                             src="data:image/png;base64,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">&nbsp;</img>
                                        <div class="gb_Z">Operation</div>
                                    </a>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </div>

                <a class="navbar-brand navbar-brand-secondary" href="#"> </a>
            </div>
            <div class="collapse navbar-collapse navbar-ex1-collapse-1">
                <ul class="nav navbar-nav navbar-nav-language navbar-nav-logout">
                    <li class="dropdown dropdown-res navbar-account">
                        <a class="btn-signup ga-signup button secondary dropdown-toggle" href="#"
                           data-toggle="dropdown">
                            <div class="account_img"
                                 style="vertical-align: middle;">
                                <img src="${contextPath}/assets/images/icon/menu/account.png"  style="width: 30px;height: 30px">
                                <b>${userLogin.username}</b><b class="caret"></b>
                            </div>
                        </a>
                        <ul class="dropdown-menu">
                            <li>
                                <%--<a href="#" class="lh-inherit"><span><spring:message--%>
                                <%--code="balance.header"/></span><fmt:formatNumber type="number"--%>
                                <%--maxFractionDigits="3"--%>
                                <%--value="${userLogin.balance}"/>&nbsp;<span>VND</span></a>--%>
                                <a class="link-active" href="#">Helpdesk</a>
                            </li>
                            <li><a href="${ewallet:isSignature(urlChangePass, '')}"
                                   class="lh-inherit"><spring:message
                                    code="header.change.password"/></a></li>
                            <li><a href="<c:url value='/logout.html'/>"
                                   class="lh-inherit"><spring:message code="header.sign.out"/></a>
                            </li>
                        </ul>
                    </li>
                </ul>
                <ul class="nav navbar-nav navbar-nav-primary">
                    <%-- Khách hàng--%>
                    <sec:authorize
                            access="hasAnyRole('ADMIN_OPERATION','SALE_DIRECTOR','SALESUPPORT_MANAGER' ,'SALESUPPORT_MANAGER','SALESUPPORT_LEADER','SALESUPPORT',
                            'CUSTOMERCARE_MANAGER','CUSTOMERCARE','TECHSUPPORT')"
                            var="permisAll"/>
                    <sec:authorize
                            access="hasAnyRole('FA_MANAGER','FINANCE_LEADER','FINANCESUPPORT_LEADER','FINANCE_SUPPORT','FINANCE')"
                            var="permisFinance"/>
                    <sec:authorize
                            access="hasAnyRole('SALE_EXCUTIVE','SALE_SUPERVISOR','SALE_ASM','SALE_RSM')"
                            var="permisSale"/>

                    <li class="${not empty menu && menu == 'cus' ? 'active' : '' }">
                        <c:if test="${(permisAll) || (permisFinance)}">
                            <a href="${ewallet:isSignature(urlCustomerTab, '')}"><spring:message
                                    code="header.menu.tab.customer"/></a>
                        </c:if>

                        <c:if test="${(permisSale) && isSaleAgent}">
                            <a href="${ewallet:isSignature(urlCustomerTabAgent, '')}"><spring:message
                                    code="header.menu.tab.customer"/></a>
                        </c:if>
                        <c:if test="${(permisSale) && isSaleMerchant}">
                            <a href="${ewallet:isSignature(urlCustomerTabMerchant, '')}"><spring:message
                                    code="header.menu.tab.customer"/></a>
                        </c:if>
                    </li>
                    <%-- end khách hàng--%>

                    <sec:authorize access="hasAnyRole('ADMIN_OPERATION',
                    'CUSTOMERCARE_MANAGER','CUSTOMERCARE',
                    'SALESUPPORT','SALESUPPORT_MANAGER',
                    'SALE_DIRECTOR','SALE_EXCUTIVE','SALE_SUPERVISOR','SALE_ASSISTANT','SALE_ASM','SALE_RSM',
                    'MERCHANT','AGENT','CUSTOMER',
                    'RECONCILIATION', 'RECONCILIATION_LEADER','TECHSUPPORT',
                    'FA_MANAGER','FINANCE_LEADER','FINANCESUPPORT_LEADER','FINANCE_SUPPORT','FINANCE')">
                        <li><a href="${urlProviderTab}"><spring:message
                                code="header.menu.tab.provider"/></a></li>
                    </sec:authorize>

                    <sec:authorize access="hasAnyRole('ADMIN_OPERATION','TECHSUPPORT',
                    'FA_MANAGER','FINANCE_LEADER','FINANCESUPPORT_LEADER','FINANCE_SUPPORT','FINANCE',
                    'SALESUPPORT', 'SALESUPPORT_MANAGER','SALESUPPORT_LEADER',
                    'SALE_DIRECTOR','SALE_EXCUTIVE','SALE_SUPERVISOR','SALE_ASSISTANT','SALE_ASM','SALE_RSM',
                    'CUSTOMERCARE_MANAGER','CUSTOMERCARE','ACCOUNTING',
                    'MERCHANT','AGENT','CUSTOMER','TELCO','AGGREATOR','BILLER',
                    'RECONCILIATION', 'RECONCILIATION_LEADER')">
                        <li><a href="${urlWalletTab}"><spring:message
                                code="header.menu.tab.wallet"/></a></li>
                    </sec:authorize>

                </ul>
                <ul class="nav navbar-nav navbar-nav-secondary">
                    <sec:authorize access="hasAnyRole('ADMIN_OPERATION',
                'SALESUPPORT','ACCOUNTING','TECHSUPPORT','CUSTOMERCARE',
                'SALE_ASM','SALE_EXCUTIVE',
                'PROVIDER',
                'MERCHANT','AGENT','CUSTOMER','CUSTOMERCARE_MANAGER','SALE','SALESUPPORT_MANAGER','SALESUPPORT_LEADER',
                'FA_MANAGER','FINANCE_LEADER','FINANCESUPPORT_LEADER','FINANCE_SUPPORT','FINANCE')">
                        <li><a href="${urlServiceTab}"><spring:message
                                code="header.menu.tab.service"/></a></li>
                    </sec:authorize>

                    <sec:authorize access="hasAnyRole('ADMIN_OPERATION',
                'SALESUPPORT','SALESUPPORT_MANAGER',
                'ACCOUNTING','RISK','FRAUD','TECHSUPPORT',
                'FA_MANAGER','FINANCE_LEADER','FINANCESUPPORT_LEADER','FINANCE_SUPPORT','FINANCE')">
                        <li class="${not empty menu && menu == 'ope' ? 'active' : '' }">
                            <a href="${ewallet:isSignature(urlOperationTab, '')}"><spring:message
                                    code="header.menu.tab.operation"/></a>
                        </li>
                    </sec:authorize>

                    <sec:authorize access="hasRole('ADMIN_OPERATION')">
                        <li class="${not empty menu && menu == 'bill' ? 'active' : '' }">
                            <a href="${ewallet:isSignature(urlBillpayTab, '')}"><spring:message
                                    code="header.menu.tab.billpay"/></a>
                        </li>
                    </sec:authorize>

                    <sec:authorize access="hasAnyRole('ADMIN_OPERATION')">
                        <li class="${not empty menu && menu == 'set' ? 'active' : '' }">
                            <a href="${ewallet:isSignature(urlSettingTab, '')}"><spring:message
                                    code="header.menu.tab.platform.config"/></a>
                        </li>
                    </sec:authorize>

                    <sec:authorize access="hasAnyRole('ADMIN_OPERATION')">
                        <li class="${not empty menu && menu == 'all' ? 'active' : '' }">
                            <a href="${uri_all}"><spring:message
                                    code="header.menu.tab.all"/></a>
                        </li>
                    </sec:authorize>
                </ul>
            </div>
        </nav>
    </div>
</header>