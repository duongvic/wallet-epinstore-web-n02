<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:if test="${codeErr != null && codeErr ne ''}">
    <div class="row">
        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
            <div class="alert_das appear-animation fadeInRightBig appear-animation-visible">
                <div class="alert alert-danger">
                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                    <strong><spring:message code="label.notification.title"/>! </strong> ${mesErr}
                </div>
            </div>
        </div>
    </div>
</c:if>
<c:if test="${codeErr != null && codeErr eq '' && mesErr != null && mesErr ne ''}">
    <div class="row">
        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
            <div class="alert_das appear-animation fadeInRightBig appear-animation-visible">
                <div class="alert alert-success">
                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                    <spring:message code="${mesErr}" var="success_message"/>
                    <strong><spring:message code="label.notification.title"/>! ${success_message}</strong>
                </div>
            </div>
        </div>
    </div>
</c:if>