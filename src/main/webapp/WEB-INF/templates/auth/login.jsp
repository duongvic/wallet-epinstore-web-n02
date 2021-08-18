<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!doctype html>
<html class="fixed" lang="${pageContext.response.locale.language}">
<head>
  <!-- Basic -->
  <meta charset="UTF-8">
  <title><spring:message code="login.title.page"/></title>
  <jsp:include page="../include_page/head.jsp"/>
  <jsp:include page="../include_page/js.jsp"/>
  <style>
    .footer-navbar-bottom ul li { display: inline-block; float: none; } .footer-navbar-bottom ul { text-align: center; } .footer-navbar-bottom { text-align: center; } .body-sign { height: calc(100vh - 50px - 65px); padding-top: 50px; }
  </style>
</head>

<body>
<section class="body">
  <header class="header navbar navbar-secondary">
    <div class="container-fluid navbar-container">
      <div class="row">
        <div class="col-md-12">
          <nav class="navbar navbar-default navbar-default-normal" role="navigation">
            <div class="navbar-header">
              <div class="navbar-brand sprite-img-logo2x_150_50"></div>
            </div>
            <div class="collapse navbar-collapse navbar-ex1-collapse">
              <ul id="navbar-main-1" class="nav navbar-nav">
                <li class="navbar-nav-title"><a href="#"></a></li>
              </ul>
              <ul id="navbar-main-2" class="nav navbar-nav navbar-right mr-xlg">
                <li><a href="#" data-toggle="tooltip" data-placement="bottom" title="<spring:message code="common.call.customer.care"/>"><spring:message code="login.nav.helpdes"/></a></li>
                <li class="dropdown mr-xlg">
                  <a href="#" class="dropdown-toggle mr-xlg" data-toggle="dropdown">${pageContext.response.locale.language eq 'en' ? 'English' : 'Tiếng Việt'}<b class="caret"></b></a>
                  <ul class="dropdown-menu animated" data-animation="fadeInDown-1">
                      <li><a href="lang=en" id="langEn"><div class="sprite-img-en"></div><span style="vertical-align: top;">&nbsp;English</span></a></li>
                      <li><a href="lang=vi" id="langVi"><div class="sprite-img-vn"></div><span style="vertical-align: top;">&nbsp;Tiếng Việt</span></a></li>
                  </ul>
                </li>
              </ul>
            </div>
          </nav>

          <nav class="navbar navbar-default navbar-default-responsive" role="navigation">
            <div class="navbar-header">
              <a class="navbar-brand navbar-brand-secondary" href="#">Zo-Ta</a>
            </div>
            <div class="collapse navbar-collapse navbar-ex1-collapse-1">
              <%--<ul class="nav navbar-nav navbar-nav-language navbar-nav-logout">
                <li class="dropdown dropdown-res navbar-account">
                  <a href="#" class="btn-signup ga-signup button secondary dropdown-toggle" data-toggle="dropdown">
                    <img class="account_img"
                         src="<c:url value="/assets/images/navbar/avatar/av4.jpg"/>"
                         alt="">&nbsp;zo-ta&nbsp;<b class="caret"></b>
                  </a>
                  <ul class="dropdown-menu">
                    <li><a href="#">Dashboard</a></li>
                    <li><a href="#">Settings</a></li>
                    <li><a href="#">Sign out</a></li>
                  </ul>
                </li>
                <li><a href="#"> 20,127,612 <span>VND</span> </a></li>
                <li class="dropdown dropdown-res">
                  <a href="#" class="dropdown-toggle" data-toggle="dropdown">Language<b class="caret"></b></a>
                  <ul class="dropdown-menu">
                    <li><a href="?lang=en"><div class="sprite-img-en"></div><label style="vertical-align: top;">&nbsp;English</label></a></li>
                    <li><a href="?lang=vi"><div class="sprite-img-vn"></div><label style="vertical-align: top;">&nbsp;Tiếng Việt</label></a></li>
                  </ul>
                </li>
              </ul>--%>
            </div>
          </nav>
        </div>
      </div>
    </div>
  </header>

  <div class="inner-wrapper">
    <section class="body-sign">
      <div class="center-sign">

        <div class="panel panel-sign">
          <div class="panel-body">
            <p class="tit-login h4 text-bold" align="center"><spring:message code="login.form.title"/></p>
            <form name="loginForm" method="post"  action="/store/login" class="login-form" id="login-form">
              <input type="hidden" value="${callbackUrl}" name="callbackUrl"/>
              <div class="mb-lg">
                <label class="text-bold"><spring:message code="login.form.username"/></label>
                <input name="username" id="username" type="text" class="form-control input-lg"/>
              </div>
              <div class="mb-lg">
                <div class="clearfix"><label class="text-bold pull-left"><spring:message code="login.form.pass"/></label></div>
                <input name="password" id="password" type="password" class="form-control input-lg"/>
              </div>

              <c:if test="${not empty error}">
                <div class="form-control ipc alert alert-danger">${error}</div>
              </c:if>

              <div class="mb-lg">
                <div class="clearfix">
                  <div class="checkbox-custom checkbox-default pull-left m-none">
                    <input id="RememberMe" name="rememberme" type="checkbox" checked="checked"/>
                    <label for="RememberMe"><spring:message code="login.form.remember"/></label>
                  </div>
                  <a href="#" class="pull-right"><spring:message code="login.form.lost.pass"/></a>
                </div>
              </div>
              <button type="submit" onclick="document.forms['loginForm'].submit(); return false;" class="btn btn-warning btn-block mb-md  mb-lg sign-in"><spring:message code="login.form.btn.signin"/></button>
              <p class="text-center"><spring:message code="login.form.question"/>&nbsp;<a href="#" class="primary_color"><spring:message code="login.form.btn.signup"/></a></p>
              <sec:csrfInput/>
            </form>
          </div>
        </div>
      </div>
    </section>
    <footer class="main-footer m-none">

      <div class="container_footer">
        <div class="row">
          <!--country-selector-->
          <div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
            <div class="country-selector ">
              <div id="navbar-main-3" class="dropup">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                  <div class="sprite-img-vn"></div><label style="vertical-align: top;">&nbsp;Tiếng Việt</label>
                </a>
                <ul class="dropdown-menu animated" data-animation="fadeInUp-1">
                  <li><a href="?lang=en"><div class="sprite-img-en"></div><label style="vertical-align: top;">&nbsp;English</label></a></li>
                  <li><a href="?lang=vi"><div class="sprite-img-vn"></div><label style="vertical-align: top;">&nbsp;Tiếng Việt</label></a></li>
                </ul>
              </div>
            </div>
          </div>
          <!--end-country-selector-->

          <!--footer-navbar-->
          <div class="col-xs-12 col-sm-11 col-md-11 col-lg-11">
            <div class="footer-navbar">
              <div class="footer-navbar-bottom">
                <ul>
                  <li><a href="#"><spring:message code="login.footer.aboutus"/></a></li>
                  <li><a href="#"><spring:message code="login.footer.service"/></a></li>
                  <li><a href="#"><spring:message code="login.footer.policy"/></a></li>
                  <li><a href="#"><spring:message code="login.footer.contactus"/></a></li>
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
<script type="text/javascript">
  var buttons = document.getElementsByTagName('button');

  Array.prototype.forEach.call(buttons, function (b) {
    b.addEventListener('click', createRipple);
  });

  function createRipple (e) {
    var circle = document.createElement('div');
    this.appendChild(circle);

    var d = Math.max(this.clientWidth, this.clientHeight);

    circle.style.width = circle.style.height = d + 'px';

    var rect = this.getBoundingClientRect();
    circle.style.left = e.clientX - rect.left -d/2 + 'px';
    circle.style.top = e.clientY - rect.top - d/2 + 'px';

    circle.classList.add('ripple');
  }

</script>
</body>
</html>