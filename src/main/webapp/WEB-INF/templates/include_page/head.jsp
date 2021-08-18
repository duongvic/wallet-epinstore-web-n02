<%@ page language="java" trimDirectiveWhitespaces="true" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<meta http-equiv='Content-Type' content='text/html; charset=UTF-8' />
<meta name="keywords" content="Zo-Ta Acquire Agent">
<meta name="description" content="Zo-Ta Acquire Agent">
<meta name="author" content="ZO-TA">

<sec:csrfMetaTags />

<!-- Mobile Metas -->
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
<link href="<c:url value='/assets/favicon.ico' />" rel="icon" type="image/x-icon"/>
<!-- Web Fonts -->
<link href="//fonts.googleapis.com/css?family=Open+Sans:300,400,600,700,800|Shadows+Into+Light" rel="stylesheet" type="text/css" media="none" onload="if(media!='all')media='all'">
<%--<link href="<c:url value='/assets/development/static/css/font-awesome.min.css'/>" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">--%>
<link rel="stylesheet" href="<c:url value='/assets/development/static/css/font-awesome.min.css'/>" media="none" onload="if(media!='all')media='all'">

<!-- Vendor CSS -->
<%--<link rel="stylesheet" href="<c:url value='/assets/vendor/bootstrap/css/bootstrap.min.css'/>">--%>
<link rel="stylesheet" href="<c:url value='/assets/development/static/css/bootstrap.min.css'/>">

<%--<link rel="stylesheet" href="<c:url value='/assets/vendor/magnific-popup/magnific-popup-min.css'/>">--%>
<%--<link rel="stylesheet" href="<c:url value='/assets/development/static/css/oneweek/magnific-popup-min.css'/>" media="none" onload="if(media!='all')media='all'">--%>

<!-- Specific Page Vendor CSS -->
<%--<link rel="stylesheet" href="<c:url value='/assets/vendor/jquery-ui/css/ui-lightness/jquery-ui-1.10.4.custom.min.css'/>">--%>
<link rel="stylesheet" href="<c:url value='/assets/development/static/css/jquery-ui-1.10.4.custom.min.css'/>" media="none" onload="if(media!='all')media='all'">


<%--<link rel="stylesheet" href="<c:url value='/assets/vendor/morris/morris.css'/>">--%>
<link rel="stylesheet" href="<c:url value='/assets/development/static/css/morris.css'/>" media="none" onload="if(media!='all')media='all'">

<%--<link rel="stylesheet" href="<c:url value='/assets/vendor/pnotify/pnotify.custom.css'/>"/>--%>
<%--<link rel="stylesheet" href="<c:url value='/assets/development/static/css/oneweek/pnotify.custom.css'/>" media="none" onload="if(media!='all')media='all'">--%>

<%--<link rel="stylesheet" href="<c:url value='/assets/stylesheets/messagebox.css'/>"/>--%>
<link rel="stylesheet" href="<c:url value='/assets/development/static/css/messagebox.css'/>" media="none" onload="if(media!='all')media='all'">



<%-- -----------select------------- --%>
<%--<link rel="stylesheet" href="<c:url value='/assets/vendor/bootstrap-multiselect/bootstrap-multiselect.css'/>">--%>
<link rel="stylesheet" href="<c:url value='/assets/development/static/css/bootstrap-multiselect.css'/>" media="none" onload="if(media!='all')media='all'">

<%--<link rel="stylesheet" href="<c:url value='/assets/vendor/select2/4.0.1/select2.min.css'/>">--%>
<link rel="stylesheet" href="<c:url value='/assets/development/static/css/select2.min.css'/>" media="none" onload="if(media!='all')media='all'">

<%--<link rel="stylesheet" href="<c:url value='/assets/stylesheets/skins/1pay_skin/bootstrap-select.min.css'/>" type="text/css">--%>
<link rel="stylesheet" href="<c:url value='/assets/development/static/css/bootstrap-select.min.css'/>" media="none" onload="if(media!='all')media='all'">



<%--   CUSTOEM THEME    --%>
<%--<link rel="stylesheet" href="<c:url value='/assets/stylesheets/skins/1pay_skin/navbar-min.css'/>">--%>
<link rel="stylesheet" href="<c:url value='/assets/development/static/css/navbar-min.css'/>">

<%--<link rel="stylesheet" href="<c:url value='/assets/stylesheets/theme-min.css'/>">--%>
<link rel="stylesheet" href="<c:url value='/assets/development/static/css/theme-min.css'/>">

<%--<link rel="stylesheet" href="<c:url value='/assets/stylesheets/skins/1pay_skin/zota-min.css'/>">--%>
<link rel="stylesheet" href="<c:url value='/assets/development/static/css/zota-min.css'/>">

<%--<link rel="stylesheet" href="<c:url value='/assets/stylesheets/new-custom-min.css'/>">
<link rel="stylesheet" href="<c:url value='/assets/development/static/css/oneday.1.0.4/new-custom-min.css'/>"> into truemoney-min
<link rel="stylesheet" href="<c:url value='/assets/vendor/panel_tool/panel_tool-min.css'/>">
<link rel="stylesheet" href="<c:url value='/assets/development/static/css/oneday.1.0.4/panel_tool-min.css'/>"> into navbar-min
<link rel="stylesheet" href="<c:url value='/assets/development/static/css/oneday.1.0.4/daterangepicker_custom-min.css'/>" media="none" onload="if(media!='all')media='all'">--%>

<c:if test="${param.dateLib eq 'true'}">
  <%--<link rel="stylesheet" href="<c:url value='/assets/vendor/bootstrap-datepicker/css/datepicker3-min.css'/>">--%>
  <link rel="stylesheet" href="<c:url value='/assets/development/static/css/datepicker3-min.css'/>" media="none" onload="if(media!='all')media='all'">

  <%--<link rel="stylesheet" href="<c:url value='/assets/vendor/jquery-datatables-bs3/assets/css/datatables-min.css'/>">--%>
  <link rel="stylesheet" href="<c:url value='/assets/development/static/css/datatables-min.css'/>" media="none" onload="if(media!='all')media='all'">

  <%--<link rel="stylesheet" href="<c:url value='/assets/vendor/daterangepicker/daterangepicker-min.css'/>" type="text/css" media="all">--%>
  <link rel="stylesheet" href="<c:url value='/assets/development/static/css/daterangepicker-min.css'/>" media="none" onload="if(media!='all')media='all'">
</c:if>


<c:if test="${param.switchLib eq 'true'}">
  <%--<link rel="stylesheet" href="<c:url value='/assets/vendor/switchery/switchery.css'/>"/>--%>
  <link rel="stylesheet" href="<c:url value='/assets/development/static/css/switchery.css'/>">
</c:if>

<!-- dev custom -->
<link rel="stylesheet" href="<c:url value='/assets/development/static/css/dev-theme-custom.1.0.0.css'/>" media="none" onload="if(media!='all')media='all'">
<link rel="stylesheet" href="<c:url value='/assets/development/static/css/switch-custom.css'/>" media="none" onload="if(media!='all')media='all'">
<link rel="stylesheet" href="<c:url value='/assets/development/static/css/dev-responsive.css'/>" media="none" onload="if(media!='all')media='all'">
<style type="text/css">
  .group-apps {background: #fff;margin: 0;min-height: 100px;padding: 10px;text-align: left;white-space: normal;width: 200px;}
  .group-apps:before {left: 12.5em !important;}

  .item-apps:hover {z-index: 1001;}
  .item-apps {padding: 1px;display: inline-block;vertical-align: top;color: black;z-index: 999;height: 86px;width: 86px;}
  .item-apps a {padding-left: 15px;}
  .item-app-image {background-image: url('data:image/png;base64,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');background-repeat: no-repeat;display: inline-block;vertical-align: top;height: 64px;width: 64px;}

  .gb_Z {display: block;line-height: 20px;overflow: hidden;white-space: nowrap;width: 84px;text-overflow: ellipsis;}
</style>
