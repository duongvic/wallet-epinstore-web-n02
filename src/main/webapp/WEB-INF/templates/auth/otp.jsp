<%@ page language="java" trimDirectiveWhitespaces="true" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="display" uri="http://displaytag.sf.net/el" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!doctype html>
<html class="fixed" lang="${pageContext.response.locale.language}">
<head>
  <jsp:include page="../include_page/head.jsp"></jsp:include>
  <jsp:include page="../include_page/js.jsp"/>
  <script type="text/javascript">
    function clear(x) {
      x.val = '';
    }

    $(document).ready(function () {
      $('form[name=otpAuth] input[name=code]').focus();
    });
  </script>
  <style type="text/css">
    .form-control {
      height: 50px;
      border-radius: 7px;
      border: 2px solid #eaebec;
      box-shadow: none;
      outline: none;
      color: #aaa;
      font-size: 17px;
    }

    .form-control:focus {
      border-color: #38B449;
      box-shadow: none;
    }

    .report_search_bt .submit_bt {
      border-radius: 7px;
    }

    input[type=number]::-webkit-inner-spin-button {
      -webkit-appearance: none;
      cursor: pointer;
      display: block;
      text-align: center;
      position: relative;
    }
  </style>
  <title>OTP Authenticator</title>
</head>
<body>
<section class="body">

  <jsp:include page="../include_page/header.jsp"></jsp:include>
  <div class="inner-wrapper">

    <section role="main" class="content-body" style="margin-left: 0px;">
      <header class="page-header">
        <div class="row">
          <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
            <div class="page-header-left">
              <ol class="breadcrumbs">
                <li><a href="dashboard.html"> <i class="fa fa-home"></i> </a></li>
                <li><span> OTP Authenticator </span></li>
              </ol>
            </div>
          </div>

        </div>
      </header>

      <jsp:include page="../include_page/message.jsp"/>

      <div class="row content-body-wrap">
        <div class="col-md-12 col-lg-12 col-xl-12">
          <form name="otpAuth" action="" method="post" >
            <section class="panel panel-default">

              <div class="panel-body edit_profile">
                <div class="form-group">
                  <div class="col-md-12" align="center">
                    <input name="code" type="number" onfocus="clear(this)" class="form-control" title="OTP Authenticator" placeholder="OTP Authenticator" style="max-width:360px; text-align: center"/>
                    <input type="hidden" name="backUrl"/>
                  </div>
                </div>

                <div class="form-group report_search_bt" style="text-align: center;">
                  <spring:message code="button.cancel" var="btnCancel"/>
                  <spring:message code="button.confirm" var="btnConfirm"/>
                  <input type="submit" class="submit_bt" name="submit" value="${btnConfirm }"/>
                  <input type="reset" class="submit_bt nomal_color_bk" name="cancel" value="${btnCancel}"/>
                </div>
              </div>
            </section>
          <sec:csrfInput /></form>
        </div>
      </div>
      <!-- end: page -->
    </section>


    <footer class="main-footer m-none footer-fixed">

      <div class="container_footer">
        <div class="row">
          <!--country-selector-->
          <div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
            <div class="country-selector ">
              <div id="navbar-main-3" class="dropup">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                  <img width="23" height="23" alt="" src="assets/images/navbar/flags/vn.png">&nbsp; Vietnam</a>
                <ul class="dropdown-menu animated" data-animation="fadeInUp-1">
                  <li><a href="#"> <img width="23" height="23" alt="" src="assets/images/navbar/flags/vn.png">Vietnam</a></li>
                  <li><a href="#"> <img width="23" height="23" alt="" src="assets/images/navbar/flags/id.png">Indonesia</a></li>
                </ul>
              </div>
            </div>
          </div>
          <!--end-country-selector-->

          <!--footer-navbar-->
          <div class="col-xs-12 col-sm-11 col-md-8 col-lg-8">
            <div class="footer-navbar">
              <div class="footer-navbar-bottom">
                <ul>
                  <li><a href="#">About Us</a></li>
                  <li><a href="#">Tearms of Service</a></li>
                  <li><a href="#">Privac Policy</a></li>
                  <li><a href="#">Contact us</a></li>
                </ul>
              </div>
            </div>
          </div>
        </div>
      </div>
    </footer>
  </div>
</section>
<jsp:include page="../include_page/js_footer.jsp"/>
</body>
</html>