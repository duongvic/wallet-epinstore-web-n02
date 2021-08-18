<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="taglibs.jsp" %>

<script type="text/javascript" src="<c:url value='/assets/development/static/js/jquery.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/assets/development/static/js/bootstrap.min.js'/>"></script>

<script type="text/javascript" src="<c:url value='/assets/development/static/js/bootstrap-multiselect.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/assets/development/static/js/select2.full.min.js'/>"></script>

<script type="text/javascript" src="<c:url value='/assets/development/static/js/jquery.dataTables.min.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/assets/development/static/js/datatables.min.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/assets/development/static/js/dataTables.tableTools.min.js'/>" ></script>

<c:if test="${param.dateLib eq 'true'}">
  <!-- date time -->
  <script type="text/javascript" src="<c:url value='/assets/development/static/js/moment-min.js'/>"></script>
  <script type="text/javascript" src="<c:url value='/assets/development/static/js/daterangepicker.min.js'/>" ></script>
</c:if>

<c:if test="${param.switchLib eq 'true'}">
  <script type="text/javascript" src="<c:url value='/assets/development/static/js/ios7-switch-min.js'/>" async></script>
  <script type="text/javascript" src="<c:url value='/assets/development/static/js/switchery-min.js'/>"></script>
</c:if>

<!-- ------------lib for true_Service------------ -->
<%--<link rel="stylesheet" href="<c:url value='/assets/development/static/css/serviceCharge.css'/>" media="none" onload="if(media!='all')media='all'">--%>
<%--<link rel="stylesheet" href="<c:url value='/assets/development/static/css/bootstrap-treefy.min.css'/>" media="none" onload="if(media!='all')media='all'">--%>
<link rel="stylesheet" href="<c:url value='/assets/development/static/css/select2.min.css'/>" media="none" onload="if(media!='all')media='all'">

<%--<script type="text/javascript" src="<c:url value='/assets/development/static/js/oneweek/bootstrap-treefy.min.js'/>" async></script>--%>
<%--<script type="text/javascript" src="<c:url value='/assets/development/static/js/jquery.treetable.js'/>" async></script>--%>

<script type="text/javascript" src="<c:url value='/assets/development/static/js/theme-min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/assets/development/static/js/theme.init-min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/assets/development/static/js/plugins-min.js'/>"></script>

<script>
  var ctx = "${pageContext.request.contextPath}";
  $(document).ready(function () {
    var token = $("meta[name='_csrf']").attr("content");
    var header = $("meta[name='_csrf_header']").attr("content");
    $.ajaxSetup({
      beforeSend: function(xhr) {
        xhr.setRequestHeader(header, token);
      }
    });
  });
</script>
