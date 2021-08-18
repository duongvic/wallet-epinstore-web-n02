<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<style>
  .downloadFile:hover { cursor: pointer; } .downloadFile { color: #38b449; }
</style>
<div class="form-group">
  <label class="col-md-3 control-label"><spring:message code="common.tile.file.system.template.for.card"/></label>
  <div class="col-md-6">
    <p>
      <a class="downloadFile" href="${contextPath}/provider/purchase-order/files/IMEDIA">IMEDIA</a> |
      <a class="downloadFile" href="${contextPath}/provider/purchase-order/files/IOMEDIA">IOMEDIA</a> |
      <a class="downloadFile" href="${contextPath}/provider/purchase-order/files/VNTP">Vinatopup</a> |
      <a class="downloadFile" href="${contextPath}/provider/purchase-order/files/VTC">VTC Intecom</a> |
      <a class="downloadFile" href="${contextPath}/provider/purchase-order/files/ZOTA">ZO-TA JSC</a> |
      <a class="downloadFile" href="${contextPath}/provider/purchase-order/files/ZOPAY">ZOPAY</a> |
      <a class="downloadFile" href="${contextPath}/provider/purchase-order/files/THANHSON">THANHSON</a> |
      <a class="downloadFile" href="${contextPath}/provider/purchase-order/files/VPAY">VPAY</a> |

    </p>
  </div>
</div>