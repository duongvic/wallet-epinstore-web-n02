<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="panel-title">
  <h4 style="margin-bottom: 1.5rem">Lịch sử truy cập</h4>
  <div class="panel-tools"></div>
</div>
<div class="panel-body">
  <table class="table table-responsive table-striped mb-none" id="datatable-role">
    <%--<thead style="line-height: 22px; cursor: pointer;"></thead>--%>
    <tbody>
    <c:set var="row" value="2"/>
    <c:forEach var="item" items="${accessHistories}">
      <tr class="${(row % 2 eq 0) ? 'backgr' : ''}">
        <td class="img"><img src="${contextPath}/assets/images/icon/login-${item.deviceName}.png"></td>
        <td class="local">
            ${item.deviceOs} - ${item.location}
          <span class="hidden-md hidden-lg">${item.stie} - ${item.formatLoginDate()}</span>
        </td>
        <td class="hidden-xs hidden-sm" style="min-width: 300px;">${item.stie} - ${item.formatLoginDate()}</td>
        <td class="icon-login"><span class="icon"></span></td>
        <c:set var="row" value="${row + 1}"/>
      </tr>
    </c:forEach>
    <input type="hidden" id="countRow" value="${row}">
    </tbody>
    <tfoot>
    <c:if test="${row gt 5}">
      <tr class="more-less" style="height: 42px;">
        <td colspan="2">
          <span class="see-less" id="see-more" data-context-path="${contextPath}" data-url="${contextPath}/my-profile/history/">Xem tiếp</span>
          <input type="hidden" id="current-offset" value="1"/>
        </td>
        <td colspan="2" class="right"><a href="#" class="link">&nbsp;</a></td>
      </tr>
    </c:if>
    </tfoot>
  </table>
</div>