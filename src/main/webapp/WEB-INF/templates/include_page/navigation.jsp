<%@ page import="static vn.mog.ewallet.web.controller.epin.CardController.CARD_STORE_LIST" %>
<%@ page
        import="static vn.mog.ewallet.constant.SharedConstants.WEB_DOMAIN_PLATFORM_OPERATION_SUBPATH_EPIN_STORE_N02_URL" %>
<%@ page
        import="static vn.mog.ewallet.web.controller.dashboard.DashBoardController.CARD_STORE_DASHBOAR" %>
<%@ page
        import="static vn.mog.ewallet.web.controller.po.PurchaseOrderController.PURCHASE_ORDER_LIST" %>
<%@ page
        import="static vn.mog.ewallet.constant.SharedConstants.WEB_DOMAIN_PLATFORM_OPERATION_SUBPATH_EPIN_STORE_URL" %>
<%@ page
        import="static vn.mog.ewallet.constant.SharedConstants.WEB_DOMAIN_PLATFORM_OPERATION_SUBPATH_EPIN_STORE_OFFLINE_URL" %>
<%@ page
        import="static vn.mog.ewallet.web.controller.special.customer.SpecialAccountController.SPECIAL_ACCOUNT_MANAGE_LIST" %>
<%@ page import="static vn.mog.ewallet.web.controller.po.ProfileProviderController.PROFILE_MANAGER_LIST" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ include file="../include_page/taglibs.jsp" %>

<%--<%String menu = (String) request.getSession().getAttribute("menu");%>--%>
<%--<%if (menu != null) {%>--%>
<%--<c:set var="menu" value="<%=menu%>" scope="page"/>--%>
<%--<%} else {%>--%>
<%--<c:set var="menu" value="${menu}" scope="page"/>--%>
<%--<%}%>--%>

<%--Service Tab--%>
<c:set var="urlDashboard" value="${topupOperationUrl}/service/dashboard/index" scope="application"/>
<c:set var="urlTransHistory" value="${topupOperationUrl}/service/transaction-history/list"/>
<c:set var="urlExportEpin" value="${topupOperationUrl}/service/merchant-po/list"/>

<c:set var="urlEpinDoc" value="${topupOperationUrl}/service/merchant-po/api-document"/>
<c:set var="urlTopup" value="${topupOperationUrl}/topup/request"/>
<c:set var="urlDisbursement" value="${topupOperationUrl}/disbursement/request"/>
<c:set var="urlBillpayment" value="${topupOperationUrl}/billpayment/request"/>
<%--Reversal TXN--%>
<c:set var="urlReversalTxn" value="${topupOperationUrl}/service/reversal-history/list"/>
<c:set var="urlTxnRequest" value="${topupOperationUrl}/service/reversal-history/request"/>
<%--Service urlTrueService--%>
<c:set var="urlTrueService" value="${topupOperationUrl}/service/service-profile/list"/>
<c:set var="urlSerConfig" value="${topupOperationUrl}/service/service-profile/operation"/>
<c:set var="urlTrueServiceOperation"
       value="${topupOperationUrl}/service/service-profile/operation"/>
<%--Nap tien--%>
<c:set var="urlFundIn" value="${topupOperationUrl}/wallet/fund-in-history/list"/>
<c:set var="urlFundInOrder" value="${topupOperationUrl}/wallet/fund-in/list"/>
<%--Rut tien--%>
<c:set var="urlFundOut" value="${topupOperationUrl}/wallet/fund-out-history/list"/>
<c:set var="urlFundOutOrder" value="${topupOperationUrl}/wallet/fund-out/list"/>
<%--Balance montorning--%>
<c:set var="urlBalanceMonitoring" value="${topupOperationUrl}/wallet/balance/balance-monitoring"/>
<c:set var="urlBalanceCustomer" value="${topupOperationUrl}/wallet/balance/balance-customer"/>
<%--Balance Request--%>
<c:set var="urlBalanceInitiate" value="${topupOperationUrl}/wallet/fund-out/list"/>
<c:set var="urlFundinSofBalanceRequest"
       value="${topupOperationUrl}/wallet/transfer/fundin-sof/processing"/>
<c:set var="urlTransferWalletBalanceRequest"
       value="${topupOperationUrl}/wallet/transfer/transfer-wallet/processing"/>
<c:set var="urlRequestReim" value="${topupOperationUrl}/wallet/wallet-transfer/processing"/>

<%--Wallet Tab--%>
<%--Movement Rule--%>
<c:set var="urlRuleTrans" value="${topupOperationUrl}/wallet/transaction/rule/list"/>
<c:set var="urlMovementConfig" value="${topupOperationUrl}"/>
<%--Movement history--%>
<c:set var="urlMovementHistory"
       value="${topupOperationUrl}/wallet/wallet-transfer/movement-history"/>
<%--Bao cao tai chinh--%>
<c:set var="urlRecon"
       value="${topupOperationUrl}/wallet/balance-deduction-reconcilation-report/merchant/list"/>

<%--Store Card N02--%>
<c:set var="urlStoreMonitoring"><%=WEB_DOMAIN_PLATFORM_OPERATION_SUBPATH_EPIN_STORE_N02_URL
        + CARD_STORE_DASHBOAR%>
</c:set>
<c:set var="urlStoreCardManagement"><%=WEB_DOMAIN_PLATFORM_OPERATION_SUBPATH_EPIN_STORE_N02_URL
        + CARD_STORE_LIST%>
</c:set>
<c:set var="urlPurchaseOrder"><%=WEB_DOMAIN_PLATFORM_OPERATION_SUBPATH_EPIN_STORE_N02_URL
        + PURCHASE_ORDER_LIST%>
</c:set>
<%--Speical Customer--%>
<c:set var="urlSpecialCustomer"><%=WEB_DOMAIN_PLATFORM_OPERATION_SUBPATH_EPIN_STORE_N02_URL
        + SPECIAL_ACCOUNT_MANAGE_LIST%>
</c:set>
<c:set var="urlProfileProviderCardStoreN02"><%=WEB_DOMAIN_PLATFORM_OPERATION_SUBPATH_EPIN_STORE_N02_URL
    + PROFILE_MANAGER_LIST%>
</c:set>

<%--Provider--%>
<c:set var="urlProvider" value="${topupOperationUrl}/provider/provider-profile/list"/>

<%--Store Card--%>
<c:set var="urlStoreOnLineWeb"
       value="<%=WEB_DOMAIN_PLATFORM_OPERATION_SUBPATH_EPIN_STORE_URL%>"
       scope="application"/>

<c:set var="urlStoreOnLineMonitoring" value="${urlStoreOnLineWeb}/provider/cardstore/dashboard"/>

<c:set var="urlStoreOnLineCardManagement"
       value="${urlStoreOnLineWeb}/provider/card-manager/list"/>

<c:set var="urlPurchaseOrderOnLine" value="${urlStoreOnLineWeb}/provider/purchase-order/list"/>

<c:set var="urlSpecialCustomerOnLine"
       value="${urlStoreOnLineWeb}/provider/special-account/manage/list"/>

<c:set var="urlStoreOnlineProfileProvider" value="${urlStoreOnLineWeb}/provider/profile-manager/list"/>

<%--Store Card Off Line--%>
<c:set var="urlStoreOffLineWeb"
       value="<%=WEB_DOMAIN_PLATFORM_OPERATION_SUBPATH_EPIN_STORE_OFFLINE_URL%>"
       scope="application"/>

<c:set var="urlStoreOffLineMonitoring" value="${urlStoreOffLineWeb}/provider/cardstore/dashboard"/>

<c:set var="urlStoreOffLineCardManagement"
       value="${urlStoreOffLineWeb}/provider/card-manager/list"/>

<c:set var="urlPurchaseOrderOffLine" value="${urlStoreOffLineWeb}/provider/purchase-order/list"/>

<c:set var="urlSpecialCustomerOffLine"
       value="${urlStoreOffLineWeb}/provider/special-account/manage/list"/>

<c:set var="urlStoreOfflineProfileProvider" value="${urlStoreOffLineWeb}/provider/profile-manager/list"/>

<aside id="sidebar-left" class="sidebar-left">

    <div class="sidebar-header">
        <div class="sidebar-title">Menu</div>
        <div class="sidebar-toggle hidden-xs" data-target="html"
             data-fire-event="sidebar-left-toggle"
             data-toggle-class="sidebar-left-collapsed">
            <i class="fa fa-bars" aria-label="Toggle sidebar"></i>
        </div>
    </div>

    <div class="nano">
        <div class="nano-content">
            <nav id="menu" class="nav-main" role="navigation">
                <ul class="nav nav-main">

                    <c:if test="${empty menu || menu == 'all' || menu == 'ser'}">
                        <sec:authorize access="hasAnyRole('ADMIN_OPERATION',
            'FINANCE','FA_MANAGER',
            'SALE_EXCUTIVE','SALE_DIRECTOR','SALESUPPORT_MANAGER','SALESUPPORT_LEADER','SALESUPPORT','MERCHANT')">
                            <li data-nav-group="Service"
                                class="${param.nav =='dashboard' ? 'nav-active':'' }">
                                <a href="${ewallet:isSignature(urlDashboard, menu)}">
                                    <i class="fa fa-line-chart"></i>
                                    <span><spring:message code="menu.left.dashboard"/></span>
                                </a>
                            </li>
                        </sec:authorize>

                        <sec:authorize access="hasAnyRole('ADMIN_OPERATION','STAFF', 'SALE_ASM','SALESUPPORT_MANAGER','SALESUPPORT_LEADER','SALESUPPORT',
                                              'MERCHANT','AGENT','CUSTOMER')">
                            <li data-nav-group="Service"
                                class="${param.nav == 'hisTxn' ? 'nav-active nav-expanded' : '' }">
                                <a href="${ewallet:isSignature(urlTransHistory, menu)}">
                                    <i class=""><img src="${contextPath}/assets/images/icon/menu/overview.png" class="icon-menu-left"></i>
                                    <span><spring:message code="menu.left.transaction"/></span>
                                </a>
                            </li>
                        </sec:authorize>


                        <sec:authorize access="hasAnyRole('MERCHANT','AGENT','CUSTOMER')"
                                       var="perExportEpin"/>
                        <sec:authorize
                                access="hasAnyRole('ADMIN_OPERATION','SALESUPPORT','SALE_DIRECTOR', 'SALE_ASM','MERCHANT', 'RECONCILIATION','RECONCILIATION_LEADER')">

                            <li data-nav-group="Service" class="nav-parent ${param.nav =='merchantpo' ||
                                                              param.nav =='api' ||
                                                              param.nav =='billpayment' ||
                                                              param.nav =='topup' ||
                                                              param.nav =='disbursement'? 'nav-active nav-expanded' : '' }">
                                <a>
                                    <i class=""><img src="${contextPath}/assets/images/icon/menu/service.png" class="icon-menu-left"></i>
                                    <span><spring:message code="menu.left.service"/></span>
                                </a>
                                <ul class="nav nav-children">
                                    <li class="${param.nav =='merchantpo' ? 'nav-active' : ''}">
                                        <c:choose>
                                            <c:when test="${perExportEpin eq true}">
                                                <a href="${ewallet:isSignature(urlExportEpin, menu)}">
                                                    <spring:message
                                                            code="menu.left.service.submenu.exportcard"/>
                                                </a>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="${ewallet:isSignature(urlExportEpin, menu)}&status=1&status=2">
                                                    <spring:message
                                                            code="menu.left.service.submenu.exportcard"/>
                                                </a>
                                            </c:otherwise>
                                        </c:choose>
                                    </li>
                                    <li class="${param.nav =='api' ? 'nav-active' : ''}">
                                        <a href="${ewallet:isSignature(urlEpinDoc, menu)}">
                                            <spring:message
                                                    code="menu.left.service.submenu.apidoc"/>
                                        </a>
                                    </li>
                                </ul>
                            </li>
                        </sec:authorize>

                        <sec:authorize
                                access="hasAnyRole('ADMIN_OPERATION', 'SALESUPPORT_LEADER', 'SALESUPPORT', 'SALE_DIRECTOR')">

                            <li data-nav-group="Service" class="nav-parent ${param.nav =='service' ||
                                                               param.nav =='ser-config' ||
                                                               param.nav =='serOperation'  ? 'nav-active nav-expanded' : '' }">
                                <a>
                                    <i class=""><img src="${contextPath}/assets/images/icon/menu/system.png" class="icon-menu-left"></i>
                                    <span><spring:message code="menu.left.system"/></span>
                                </a>

                                <ul class="nav nav-children">
                                    <sec:authorize access="hasAnyRole('ADMIN_OPERATION',
                                'SALESUPPORT_LEADER', 'SALESUPPORT',
                                'RECONCILIATION','RECONCILIATION_LEADER',
                                'FINANCE',
                                'SALE_DIRECTOR','SALE_ASM' )">
                                        <li class="${param.nav =='service' ? 'nav-active' : ''}">
                                            <a href="${ewallet:isSignature(urlTrueService, menu)}">
                                                <spring:message
                                                        code="menu.service.management.list"/>
                                            </a>
                                        </li>
                                    </sec:authorize>

                                    <sec:authorize
                                            access="hasAnyRole('ADMIN_OPERATION','SALESUPPORT')">
                                        <li class="${param.nav =='serOperation' ? 'nav-active' : ''}">
                                            <a href="${ewallet:isSignature(urlTrueServiceOperation, menu)}">
                                                <spring:message
                                                        code="menu.left.system.submenu.service.operation"/>
                                            </a>
                                        </li>
                                    </sec:authorize>
                                </ul>
                            </li>
                        </sec:authorize>
                    </c:if>

                    <c:if test="${empty menu  || menu == 'all' || menu == 'wal'}">

                        <sec:authorize
                                access="hasAnyRole('ADMIN_OPERATION','FINANCE','ACCOUNTING','SALE_ASM')">
                            <li class="nav-parent ${param.nav =='balance-cust' ||param.nav == 'balance-mo' ? 'nav-active nav-expanded':'' }">
                                <a>
                                    <i class=""><img src="${contextPath}/assets/images/icon/menu/overview.png" class="icon-menu-left"></i>
                                    <span><spring:message
                                            code="menu.left.balance.monitoring"/></span>
                                </a>
                                <ul class="nav nav-children">
                                    <li class="${param.nav == 'balance-mo' ? 'nav-active':'' }">
                                        <a href="${ewallet:isSignature(urlBalanceMonitoring, menu)}">
                      <span><spring:message
                              code="menu.left.balance.monitoring.submenu.dashboard"/></span>
                                        </a>
                                    </li>
                                    <li class="${param.nav == 'balance-cust' ? 'nav-active':'' }">
                                        <a href="${ewallet:isSignature(urlBalanceCustomer, menu)}">
                      <span><spring:message
                              code="menu.wallet.balance.monitoring.balanceCustomer"/></span>
                                        </a>
                                    </li>
                                </ul>
                            </li>
                        </sec:authorize>

                        <sec:authorize access="hasAnyRole('ADMIN_OPERATION',
                                              'FINANCE_LEADER','FA_MANAGER','FINANCE','ACCOUNTING',
                                              'SALE_EXCUTIVE','SALESUPPORT',
                                               'CUSTOMER','MERCHANT','AGENT')">
                            <li data-nav-group="Wallet" class="nav-parent ${param.nav == 'fund_in' ||
                                                              param.nav == 'orderfund_in' ? 'nav-active nav-expanded':'' }">
                                <a>
                                    <i class=""><img src="${contextPath}/assets/images/icon/menu/cashIn.png" class="icon-menu-left"></i>
                                    <span><spring:message code="menu.left.fundin"/></span>
                                </a>
                                <ul class="nav nav-children">
                                    <li class="${param.nav == 'fund_in' ? 'nav-active':'' }">
                                        <a href="${ewallet:isSignature(urlFundIn, menu)}">
                                            <span><spring:message
                                                    code="menu.left.fundin.submenu.history"/></span>
                                        </a>
                                    </li>
                                    <li class="${param.nav == 'orderfund_in' ? 'nav-active':'' }">
                                        <a href="${ewallet:isSignature(urlFundInOrder, menu)}">
                                            <span><spring:message
                                                    code="menu.left.fundin.submenu.request"/></span>
                                        </a>
                                    </li>
                                </ul>
                            </li>
                        </sec:authorize>

                        <sec:authorize access="hasAnyRole('ADMIN_OPERATION',
                                              'FA_MANAGER','FINANCE','ACCOUNTING','SALE_ASM','SALE_EXCUTIVE',
                                              'CUSTOMER','MERCHANT','AGENT')">
                            <li data-nav-group="Wallet" class="nav-parent ${param.nav =='fund_out' ||
                                                              param.nav == 'orderfund_out' ? 'nav-active nav-expanded' : '' }">
                                <a>
                                    <i class=""><img src="${contextPath}/assets/images/icon/menu/cashOut.png" class="icon-menu-left"></i>
                                    <span><spring:message code="menu.left.fundout"/></span>
                                </a>
                                <ul class="nav nav-children">
                                    <li class="${param.nav == 'fund_out' ? 'nav-active':'' }">
                                        <a href="${ewallet:isSignature(urlFundOut, menu)}">
                                            <span><spring:message
                                                    code="menu.left.fundout.submit.history"/></span>
                                        </a>
                                    </li>
                                    <li class="${param.nav == 'orderfund_out' ? 'nav-active':'' }">
                                        <a href="${ewallet:isSignature(urlFundOutOrder, menu)}">
                                            <span><spring:message
                                                    code="menu.left.fundout.submenu.request"/></span>
                                        </a>
                                    </li>
                                </ul>
                            </li>
                        </sec:authorize>


                        <sec:authorize
                                access="hasAnyRole('ADMIN_OPERATION','FINANCE','FINANCE_LEADER','FA_MANAGER','SALESUPPORT','ACCOUNTING','SALE_ASM')">
                            <li data-nav-group="Wallet" class="nav-parent ${param.nav == 'transfer_transaction'||
                                                              param.nav == 'order-initiate'||
                                                              param.nav == 'transfer_process' ||
                                                              param.nav == 'request-reim' ? 'nav-active nav-expanded':'' }">
                                <a>
                                    <i class=""><img src="${contextPath}/assets/images/icon/menu/fundTransfer.png" class="icon-menu-left"></i>
                                    <span><spring:message code="menu.left.wallet.transfer"/></span>
                                </a>
                                <ul class="nav nav-children">

                                    <sec:authorize
                                            access="hasAnyRole('ADMIN_OPERATION','FINANCE','ACCOUNTING','SALESUPPORT','SALE_ASM','SALESUPPORT_MANAGER',
                      'FA_MANAGER','FINANCE_LEADER','FINANCESUPPORT_LEADER','FINANCE_SUPPORT','FINANCE')">
                                        <li class="${param.nav == 'transfer_transaction' ? 'nav-active':'' }">
                                            <a href="${ewallet:isSignature(urlMovementHistory, menu)}">
                        <span><spring:message
                                code="menu.left.wallet.transfer.submenu.transfer.history"/></span>
                                            </a>
                                        </li>
                                    </sec:authorize>

                                    <li class="${param.nav == 'fundin-sof' ? 'nav-active' : ''}">
                                        <a href="${ewallet:isSignature(urlFundinSofBalanceRequest, menu)}">
                                            <span><spring:message
                                                    code="menu.wallet.balance.request.fundin.sof"/></span>
                                        </a>
                                    </li>
                                    <li class="${param.nav == 'transfer-wallet' ? 'nav-active' : ''}">
                                        <a href="${ewallet:isSignature(urlTransferWalletBalanceRequest, menu)}">
                      <span><spring:message
                              code="menu.wallet.balance.request.transfer.wallet"/></span>
                                        </a>
                                    </li>

                                </ul>
                            </li>
                        </sec:authorize>

                        <sec:authorize
                                access="hasAnyRole('ADMIN_OPERATION','FINANCE','ACCOUNTING','SALE_ASM')">
                            <li data-nav-group="Wallet"
                                class="nav-parent ${param.nav =='tranRule' ? 'nav-active nav-expanded' : ''}">
                                <a>
                                    <i class="fa fa-tasks"></i>
                                    <span><spring:message
                                            code="menu.left.wallet.transfer.submenu.transaction.rule"/></span>
                                </a>
                                <ul class="nav nav-children">
                                    <li class="${param.nav == 'tranRule' ? 'nav-active':'' }">
                                        <a href="${ewallet:isSignature(urlRuleTrans, menu)}">
                                            <span><spring:message
                                                    code="menu.wallet.balanceRule.movementlist"/></span>
                                        </a>
                                    </li>
                                </ul>
                            </li>
                        </sec:authorize>
                    </c:if>


                    <c:if test="${empty menu || menu == 'all' || menu == 'pro'}">

                        <sec:authorize access="hasAnyRole('ADMIN_OPERATION',
                    'FA_MANAGER','FINANCE_LEADER','FINANCESUPPORT_LEADER','FINANCE_SUPPORT','FINANCE',
                    'SALESUPPORT', 'SALESUPPORT_LEADER','SALESUPPORT_MANAGER',
                    'CUSTOMERCARE_MANAGER','CUSTOMERCARE',
                    'RECONCILIATION_LEADER','RECONCILIATION_MANAGER','RECONCILIATION')"
                                       var="permisAllProvider"/>

                        <sec:authorize
                                access="hasAnyRole('SALE_DIRECTOR','SALE_EXCUTIVE','SALE_SUPERVISOR','SALE_ASSISTANT','SALE_ASM','SALE_RSM')"
                                var="permisSaleProvider"/>

                        <%-- card store online --%>
                        <c:if test="${permisAllProvider}">
                            <li data-nav-group="Provider"
                                class="nav-parent ${param.nav =='dashboardcs' ? 'nav-active nav-expanded' : '' }">
                                <a>
                                    <i class=""><img src="${contextPath}/assets/images/icon/menu/cardStore.png" class="icon-menu-left"></i>
                                    <span><spring:message code="menu.left.card.store"/></span>
                                </a>
                                <ul class="nav nav-children">
                                    <li class="${param.nav == 'store_monitoring_on_line' ? 'nav-active':'' }">
                                        <a href="${ewallet:isSignature(urlStoreOnLineMonitoring, menu)}">
                                            <span><spring:message
                                                    code="menu.provider.cardStore.storeMonitoring"/></span>
                                        </a>
                                    </li>
                                    <li class="${param.nav == 'card_item_on_line' ? 'nav-active':'' }">
                                        <a href="${ewallet:isSignature(urlStoreOnLineCardManagement, menu)}">
                                            <span><spring:message
                                                    code="menu.provider.cardStore.cardItem"/></span>
                                        </a>
                                    </li>
                                    <li class="${param.nav == 'purchase_order_on_line' ? 'nav-active':'' }">
                                        <a href="${ewallet:isSignature(urlPurchaseOrderOnLine, menu)}">
                                            <span><spring:message
                                                    code="menu.provider.cardStore.purchaseOrder"/></span>
                                        </a>
                                    </li>
                                    <li class="${param.nav == 'special-account-online' ? 'nav-active':'' }">
                                        <a href="${ewallet:isSignature(urlSpecialCustomerOnLine, menu)}">
                                            <span><spring:message
                                                    code="menu.left.manage.special.customer"/></span>
                                        </a>
                                    </li>
                                    <li class="${param.nav == 'profile_provider' ? 'nav-active':'' }">
                                        <a href="${ewallet:isSignature(urlStoreOnlineProfileProvider, menu)}">
                                            <span><spring:message
                                                code="label.profile.provider"/></span>
                                        </a>
                                    </li>


                                </ul>
                            </li>
                        </c:if>
                        <%-- /card store online --%>

                        <%-- card store online special --%>
                        <li data-nav-group="Provider" class="nav-parent ${param.nav =='store_monitoring' ||
                                                                param.nav == 'card_item' ||
                                                                param.nav == 'purchase_order' ||
                                                                param.nav == 'special_customer' ||
                                                                param.nav == 'profile_provider_n02' ? 'nav-active nav-expanded' : '' }">

                            <a>
                                <i class=""><img src="${contextPath}/assets/images/icon/menu/cardStore.png" class="icon-menu-left"></i>
                                <span><spring:message code="menu.left.card.store.special"/></span>
                                <span class="glyphicon glyphicon-star" style="color: #ffcc00"></span>
                            </a>

                            <ul class="nav nav-children">
                                <c:if test="${permisAllProvider}">
                                    <li class="${param.nav == 'store_monitoring' ? 'nav-active':'' }">
                                        <a href="${ewallet:isSignature(urlStoreMonitoring, menu)}">
                                            <span><spring:message
                                                    code="menu.provider.cardStore.storeMonitoring"/></span>
                                        </a>
                                    </li>
                                    <li class="${param.nav == 'card_item' ? 'nav-active':'' }">
                                        <a href="${ewallet:isSignature(urlStoreCardManagement, menu)}">
                                            <span><spring:message
                                                    code="menu.provider.cardStore.cardItem"/></span>
                                        </a>
                                    </li>
                                    <li class="${param.nav == 'purchase_order' ? 'nav-active':'' }">
                                        <a href="${ewallet:isSignature(urlPurchaseOrder, menu)}">
                                            <span><spring:message
                                                    code="menu.provider.cardStore.purchaseOrder"/></span>
                                        </a>
                                    </li>
                                    <li class="${param.nav == 'special_customer' ? 'nav-active':'' }">
                                        <a href="${ewallet:isSignature(urlSpecialCustomer, menu)}">
                                            <span><spring:message
                                                    code="menu.left.manage.special.customer"/></span>
                                        </a>
                                    </li>
                                    <li class="${param.nav == 'profile_provider_n02' ? 'nav-active':'' }">
                                        <a href="${ewallet:isSignature(urlProfileProviderCardStoreN02, menu)}">
                                            <span><spring:message
                                                code="label.profile.provider"/></span>
                                        </a>
                                    </li>
                                </c:if>
                                <c:if test="${permisSaleProvider}">
                                    <li class="${param.nav == 'store_monitoring' ? 'nav-active':'' }">
                                        <a href="${ewallet:isSignature(urlStoreMonitoring, menu)}">
                                            <span><spring:message
                                                    code="menu.provider.cardStore.storeMonitoring"/></span>
                                        </a>
                                    </li>
                                </c:if>
                            </ul>
                        </li>
                        <%-- /card store online special --%>

                        <%-- card store off line --%>
                        <c:if test="${permisAllProvider}">
                            <li data-nav-group="Provider"
                                class="nav-parent ${param.nav =='dashboardcs' ? 'nav-active nav-expanded' : '' }">
                                <a>
                                    <i class=""><img src="${contextPath}/assets/images/icon/menu/cardStore.png" class="icon-menu-left"></i>
                                    <span><spring:message code="menu.left.card.store.two"/></span>
                                </a>
                                <ul class="nav nav-children">
                                    <li class="${param.nav == 'store_monitoring_off_line' ? 'nav-active':'' }">
                                        <a href="${ewallet:isSignature(urlStoreOffLineMonitoring, menu)}">
                                            <span><spring:message
                                                    code="menu.provider.cardStore.storeMonitoring.off.line"/></span>
                                        </a>
                                    </li>
                                    <li class="${param.nav == 'card_item_off_line' ? 'nav-active':'' }">
                                        <a href="${ewallet:isSignature(urlStoreOffLineCardManagement, menu)}">
                                            <span><spring:message
                                                    code="menu.provider.cardStore.cardItem.off.line"/></span>
                                        </a>
                                    </li>
                                    <li class="${param.nav == 'purchase_order_off_line' ? 'nav-active':'' }">
                                        <a href="${ewallet:isSignature(urlPurchaseOrderOffLine, menu)}">
                                            <span><spring:message
                                                    code="menu.provider.cardStore.purchaseOrder.off.line"/></span>
                                        </a>
                                    </li>
                                    <li class="${param.nav == 'special-account-offline' ? 'nav-active':'' }">
                                        <a href="${ewallet:isSignature(urlSpecialCustomerOffLine, menu)}">
                                            <span><spring:message
                                                    code="menu.left.manage.special.customer"/></span>
                                        </a>
                                    </li>
                                    <li class="${param.nav == 'profile_provider_offline' ? 'nav-active':'' }">
                                        <a href="${ewallet:isSignature(urlStoreOfflineProfileProvider, menu)}">
                                            <span><spring:message
                                                code="label.profile.provider"/></span>
                                        </a>
                                    </li>
                                </ul>
                            </li>
                        </c:if>
                        <%-- /card store off line --%>


                        <sec:authorize access="hasAnyRole('ADMIN_OPERATION',
                                              'SALESUPPORT','SALESUPPORT_LEADER','SALESUPPORT_MANAGER',
                                              'CUSTOMERCARE_MANAGER','CUSTOMERCARE',
                                              'TECHSUPPORT','FA_MANAGER','FINANCE_LEADER','FINANCESUPPORT_LEADER','FINANCE_SUPPORT','FINANCE')">
                            <li class="${param.nav == 'provider' ? 'nav-active':'' }"
                                data-nav-group="Provider">
                                <a href="${ewallet:isSignature(urlProvider, menu)}">
                                    <i class=""><img src="${contextPath}/assets/images/icon/menu/provider.png" class="icon-menu-left"></i>
                                    <span><spring:message code="menu.left.provider"/></span>
                                </a>
                            </li>
                        </sec:authorize>
                    </c:if>
                </ul>
            </nav>
        </div>
    </div>
</aside>