<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


<div id="mloading" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
  <div class="modal-dialog modal-sm" role="document">
    <div class="modal-content">
      <div class="modal-body">
        <spring:message code="common.waitting.pl"/>
        <%--<div class="progress progress-striped light active m-md">--%>
          <%--<div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 100%;">--%>
            <%----%>
          <%--</div>--%>
        <%--</div>--%>
      </div>

    </div>
  </div>
</div>

<footer class="main-footer">
  <div class="container-fluid pt-sm">
    <div class="row">
      <div class="col-xs-12 col-md-6 col-md-offset-6">
        <div class="footer-info"><span>© 2019 by ZO-TA JSC</span></div>
      </div>
    </div>
  </div>
</footer>