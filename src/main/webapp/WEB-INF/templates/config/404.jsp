<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>Page Not Found</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <style>
    * {line-height: 1.2;margin: 0;}
    html {color: #888;display: table;font-family: sans-serif;height: 100%;text-align: center;width: 100%;}
    body {display: table-cell;vertical-align: middle;margin: 2em auto;}
    h1 {color: #555;font-size: 2em;font-weight: 400;}
    p {margin: 0 auto;width: 280px;}
    @media only screen and (max-width: 280px) {
      body, p {width: 95%;}
      h1 {font-size: 1.5em;margin: 0 0 0.3em;}
    }
  </style>
</head>
<body>
<h1>Page Not Found</h1>
<p>Sorry, but the page you were trying to view does not exist.</p>
<security:authorize access="isAuthenticated()" var="isAuthen"/>
<c:choose>
  <c:when test="${isAuthen}"><a href="${contextPath}/provider/cardstore/dashboard" class="verify return"><spring:message code="button.return.home"/></a></c:when>
  <c:otherwise><a href="${contextPath}/logout" class="verify return"><spring:message code="button.return.home"/></a></c:otherwise>
</c:choose>
</body>
</html>
<!-- IE needs 512+ bytes: https://blogs.msdn.microsoft.com/ieinternals/2010/08/18/friendly-http-error-pages/ -->
