<%@ page language="java" trimDirectiveWhitespaces="true" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../include_page/taglibs.jsp" %>

<!doctype html>
<html class="fixed" lang="${pageContext.response.locale.language}">

<head>
  <meta charset="UTF-8">
  <title>Error</title>
  <jsp:include page="../include_page/head.jsp"/>
</head>

<body>
<section class="body">
  <jsp:include page="../include_page/header.jsp"/>

  <div class="inner-wrapper">
    <!-- start: sidebar -->
    <jsp:include page="../include_page/navigation.jsp"/>
    <!-- end: sidebar -->
    <section role="main" class="content-body">
      <header class="page-header">
        <div class="row">
          <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
            <div class="page-header-left">
              <ol class="breadcrumbs">
                <li><a href="#"><i class="fa fa-home"></i></a></li>
                <li><span>Error</span></li>
              </ol>
            </div>
          </div>
        </div>
      </header>
      <!-- start: page -->
      <div class="row content-body-wrap">
        <div class="col-md-12 col-lg-12 col-xl-12">
          <div class="tabs">
            <div class="tab-content">
              <div class="row">
                <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
                  <div class="page-header-left" style="color: #33353f; display: inline-block; font-size: 20px; line-height: 20px; vertical-align: middle; font-weight: 500;padding: 0; margin-left: 0 !important;">
                    &nbsp;
                  </div>
                </div>
              </div>
              <div id="tab1" class="tab-pane active">
                <div class="clearfix"></div>
                <div class="container-fluid text-center" style="position: relative; top: 50%; transform: translateY(-50%);">
                  <c:choose>
                    <c:when test="${errorCode eq 401}">
                      <h1 class="mb-xl">Bạn không có quyền truy cập hành động !</h1>
                    </c:when>
                    <c:otherwise>
                      <h1 class="mb-xl">Bạn thực hiện hành động không đúng, xin thực hiện lại thao tác ... !</h1>
                    </c:otherwise>
                  </c:choose>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <!-- end: page -->
    </section>
    <jsp:include page="../include_page/footer.jsp"/>
  </div>
</section>
</body>
</html>
