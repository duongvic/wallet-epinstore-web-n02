<%@ page language="java" trimDirectiveWhitespaces="true" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="../include_page/taglibs.jsp" %>

<!doctype html>
<html class="fixed" lang="${pageContext.response.locale.language}">
<head>
  <!-- Basic -->
  <meta charset="UTF-8"/>
  <title><spring:message code="setting.account.role.title.page"/></title>
  <jsp:include page="../include_page/head.jsp">
    <jsp:param name="switchLib" value="true"/>
    <jsp:param name="selectLib" value="true"/>
  </jsp:include>
  <jsp:include page="../include_page/js_service.jsp">
    <jsp:param name="switchLib" value="true"/>
    <jsp:param name="tableLib" value="true"/>
    <jsp:param name="selectLib" value="true"/>
    <jsp:param name="dateLib" value="true"/>
  </jsp:include>
  <script type="text/javascript"
          src="<c:url value='/assets/javascripts/settings-custom.js'/>"></script>
</head>

<body>
<section class="body">
  <!--        ///////   header ////////-->
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
                <li><span><spring:message
                    code="menu.left.setting.account"/></span></li>
                <li><span class="nav-active"><spring:message
                    code="menu.setting.wallet.account.management.list"/></span></li>
              </ol>
            </div>
          </div>
        </div>
      </header>


      <jsp:include page="../include_page/message_new.jsp"/>

      <!-- start: page -->
      <div class="content-body-wrap">
        <div class="container-fluid">

          <div class="form-inline hidden">
            <div class="pull-left h4 mb-md mt-md panel-title"><spring:message
                code="system.account.info.page.title"/></div>
            <div class="pull-right form-responsive mb-10">
              <%--<sec:authorize access="hasRole('ADMIN_OPERATION')">--%>
              <%--</sec:authorize>--%>
            </div>
          </div>

          <section class="panel search_payment panel-default">
            <div class="panel-body pt-none">
              <spring:message code="label.un.authenticated" var="unAuthenticated"/>
              <spring:message code="labe.authenticated" var="authenticated"/>
              <div class="tab-content">
                <div id="tab-list-customer" class="tab-pane active">
                  <!-- form search -->
                  <form id="${'edit' eq edit_type ? 'form-account-detail' : 'form-account-create'}"
                        method="POST"
                        class="panel panel-default"
                        onsubmit="return saveAttribute()"
                        action="${'edit' eq edit_type ? (contextPath.concat('/provider/special-account/manage/details/'.concat(account_object.id))) : contextPath.concat('/provider/special-account/manage/add')}">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <input type="hidden" name="accountId" id="accountId"
                           value="${account_object.id}">
                    <input type="hidden" id="edit_type" name="edit_type" value="${edit_type}">

                    <!-- persional -->
                    <jsp:include page="../special_account_manage/edit_account_info.jsp"/>

                    <%--<jsp:include page="../special_account_manage/edit_account_personal.jsp"/>--%>

                    <%--<hr/>--%>
                    <!-- identity info -->
                    <%--<jsp:include page="../wallet_account_manage/edit_account_identity.jsp"/>--%>

                    <%--  <!-- edc -->
                      <jsp:include page="../wallet_account_manage/edit_account_edc.jsp"/>--%>

                    <!-- Thuộc tính component -->
                    <%--<jsp:include page="../wallet_account_manage/edit_account_attribute.jsp"/>--%>

                    <%--<jsp:include page="../special_account_manage/edit_account_roles.jsp"/>--%>

                    <%--<jsp:include page="../special_account_manage/edit_account_log_history.jsp"/>--%>

                  </form>
                  <!-- end form search -->
                </div>
              </div>


            </div>
          </section>
        </div>
      </div>
      <%--<jsp:include page="../include_component/action_grant_role.jsp"/>--%>
      <%--<jsp:include page="../include_component/action_grant_delete.jsp"/>--%>
      <%--<jsp:include page="../include_component/google_authenticator.jsp"/>--%>
      <!-- end: page -->
    </section>
    <%--<jsp:include page="trans_rule_delete.jsp"/>--%>
    <jsp:include page="../include_page/footer.jsp"/>
  </div>
</section>
<jsp:include page="../include_page/js_footer.jsp"/>

<script src="${contextPath}/assets/jquery.inputmask.bundle.min.js"></script>

<script type="text/javascript">
  (function ($) {
    'use strict';
    $(document).ready(function () {
      $(":input").inputmask();

//      var customerTypeTag = $("#customerType");
//      customerTypeTag.change(function (){
//        selectCustomerType(customerTypeTag.val());
//      });
    });

    var $limitNum = 255;
    $('textarea[name="account-about"]').keydown(function () {
      var $this = $(this);

      if ($this.val().length > $limitNum) {
        $this.val($this.val().substring(0, $limitNum));
      }
    });
  }(jQuery));

  jQuery('.dataTables_length').css('display', 'none');
  jQuery('.dataTables_filter').css('display', 'none');

  function editAccount() {
    jQuery('#displayName').attr('disabled', false);
    jQuery('#last-name').attr('disabled', false);
    jQuery('#customerType').attr('disabled', false);
//    jQuery('#notification').attr('disabled', false);
    jQuery('#phone').attr('disabled', false);
    jQuery('#email').attr('disabled', false);
    jQuery('#isActive').attr('disabled', false);
    jQuery('#description').attr('disabled', false);
    jQuery('#edit_type').attr('disabled', false);
    jQuery('#save_btn').attr('disabled', false);
  }

  function editAccountPersonal() {
    $('#btn-save-personal').attr('disabled', false);
    $('#account-nameAddr').attr('disabled', false);
    $('#account-living-address').attr('disabled', false);
    $('#account-gender').attr('disabled', false);
    $('#account-about').attr('disabled', false);
    $('#account-dateofbirth').attr('disabled', false);
    $('#account-country').attr('disabled', false);
    jQuery('#edit_type').attr('disabled', false);
  }
</script>
</body>

</html>
