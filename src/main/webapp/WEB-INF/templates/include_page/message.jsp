<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<c:if test="${(codeErr != null && codeErr >= 1) || (param.codeErr != null && param.codeErr >= 1) }">
  <div class="row">
    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
      <div class="alert_das appear-animation fadeInRightBig appear-animation-visible">
        <div class="alert alert-danger">
          <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
          <c:choose>
            <c:when test="${param.codeErr eq 201}">
              <strong><spring:message code="message.notification.title"/> ! </strong> <spring:message text="Giá trị lô thẻ ${param.poCode} nhập kho vượt quá giá trị cho phép trong ngày!"/>
            </c:when>
            <c:otherwise>
              <strong><spring:message code="message.notification.title"/> ! </strong> <spring:message code="${mesErr != null ? mesErr : param.mesErr}" text="${mesErr != null ? mesErr : param.mesErr}" />
            </c:otherwise>
          </c:choose>

        </div>
      </div>
    </div>
  </div>
</c:if>
<c:if test="${(codeErr != null && codeErr == 0) || (param.codeErr != null && param.codeErr == 0) }">
  <div class="row">
    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
      <div class="alert_das appear-animation fadeInRightBig appear-animation-visible">
        <div class="alert alert-success">
          <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
          <strong><spring:message code="message.notification.title"/> ! </strong> <spring:message code="${mesErr != null ? mesErr : param.mesErr}" text="${mesErr != null ? mesErr : param.mesErr}" />
        </div>
      </div>
    </div>
  </div>
</c:if>

<%--<c:if test="${(codeErr != null && codeErr != 0) || (param.codeErr != null && param.codeErr != 0) }">
  <div class="row">
    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
      <div class="alert_das appear-animation fadeInRightBig appear-animation-visible">
        <div class="alert alert-danger">
          <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
          <strong>Thông báo !</strong>
          <c:if test="${param.codeErr != null }">
            <c:choose>
              <c:when test="${param.codeErr eq 201}">
                <spring:message text="Giá trị lô thẻ ${param.poCode} nhập kho vượt quá giá trị cho phép trong ngày!"/>
              </c:when>
              <c:otherwise>
                <spring:message code="${param.codeErr}"/>
              </c:otherwise>
            </c:choose>
          </c:if>
          <c:if test="${unstructuredData.size() > 0 }">
            <spring:message code="${codeErr}" arguments="${unstructuredData[0].value }" argumentSeparator=";"/>
          </c:if>
          <c:if test="${unstructuredData.size() < 1}">
            ${mesErr != null ? mesErr : param.mesErr}
          </c:if>
        </div>
      </div>
    </div>
  </div>
</c:if>
<c:if test="${(codeErr != null && codeErr == 0) || (param.codeErr != null && param.codeErr == 0) }">
  <div class="row">
    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
      <div class="alert_das appear-animation fadeInRightBig appear-animation-visible">
        <div class="alert alert-success">
          <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
          <strong><spring:message code="message.notification.title"/> ! </strong> <spring:message code="${mesErr != null ? mesErr : param.mesErr}" text="${mesErr != null ? mesErr : param.mesErr}" />
        </div>
      </div>
    </div>
  </div>
</c:if>--%>
