<%@ page language="java" trimDirectiveWhitespaces="true" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../include_page/taglibs.jsp" %>


<!doctype html>
<html class="fixed" lang="${pageContext.response.locale.language}">

<head>
  <!-- Basic -->
  <meta charset="UTF-8">
  <title><spring:message code="dashboard.title"/></title>
  <jsp:include page="../include_page/head.jsp"/>
  <jsp:include page="../include_page/js.jsp"/>
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
                <li><a href="list" id="hight-title" class="hight-title"><spring:message code="common.purchase.order"/></a></li>
                <li><span class="nav-active"><spring:message code="purchase.display.verify.nav.verify" /></span></li>
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
                <li class="col-xs-4 pl-none pr-none"><a class="text-center"><span class="badge hidden-xs">1</span>&nbsp;<spring:message code="common.create.PO"/></a></li>
                <li class="col-xs-4 pl-none pr-none"><a class="text-center"><span class="badge hidden-xs">2</span>&nbsp;<spring:message code="common.upload.file"/></a></li>
                <li class="col-xs-4 pl-none pr-none active"><a class="text-center"><span class="badge hidden-xs">3</span>&nbsp;<spring:message code="common.btn.verify"/></a></li>
              </ul>
              <h3 class="col-xs-12 mt-xs" style="background-color: white;"><spring:message code="common.title.verify.purchase.order"/></h3>
            </div>

            <div class="tab-content">
              <div id="tab1" class="tab-pane active">
                <div class="row content-body-wrap">
                  <div class="col-md-12 col-lg-12 col-xl-12">
                    <section class="panel panel-default">
                      <div class="panel-title pl-none">
                        <h4 style="font-size: 18px;"><spring:message code="purchase.display.verify.label.po.number" />: ${param.poCode}</h4>
                      </div>
                      <div class="panel-body edit_profile">

                        <spring:message var="labelStep3" code="purchase.display.verify.label.step3"/>
                        <form action="" method="post">
                          <input type="hidden" name="poId" value="${param.id }">
                          <input type="hidden" name="poCode" value="${param.poCode }">
                          <div class="form-group">
                            <label class="col-md-1 control-label">*<spring:message code="common.note"/></label>
                            <div class="col-md-4 tertiary_color">
                              <spring:message code="common.title.guild"/>
                              <i class="fa  fa-question-circle text-muted m-xs "
                                 data-toggle="popover"
                                 data-trigger="hover"
                                 data-placement="top"
                                 data-content='${labelStep3}'
                                 data-html="true" data-original-title="" title=""></i>
                            </div>
                          </div>
                          <div class="form-group">
                            <label class="col-md-4 control-label"><span class="fr"><spring:message code="purchase.display.verify.label.password" /> :</span></label>
                            <div class="col-md-3">
                              <input type="password" name="password" class="form-control"/>
                              <br/>
                              <span><spring:message code="purchase.display.verify.label.userunlock" /></span>
                            </div>
                            <div class="col-md-4">
                              <button type="submit" class="btn btn-success"><spring:message code="purchase.display.verify.btn.unlock" /></button>
                            </div>
                          </div>
                          <sec:csrfInput/></form>
                      </div>
                    </section>
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
    $("form button:submit").click(function () {
      $("#mloading").modal('toggle');
    });
  });
</script>
<jsp:include page="../include_page/js_footer.jsp"/>
<script src="<c:url value='/assets/development/static/js/card-store.js'/>"></script>
</body>
</html>

