<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal fade" id="transfer" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <form name="transfer" action="transfer-po" method="post">
        <input type="hidden" name="poid" value=""/>
        <input type="hidden" name="poCode" value=""/>
        <input type="hidden" name="checkBoxSpecialCard"
               id="hidden_checkBoxSpecialCard" value=""/>
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">
            <span aria-hidden="true">&times;</span><span class="sr-only"><spring:message code="common.btn.close"/></span>
          </button>
          <h4 class="modal-title" id="myModalLabel"><spring:message code="common.information.PO.transfer"/></h4>
        </div>
        <div class="modal-body">
          <div class="title-bo-box">
            <spring:message code="common.title.information"/>
          </div>
          <div class="bo-box" id="bo-box">
            <div class="form-group">
              <label class="col-md-4 control-label"><spring:message code="common.PO.number"/></label>
              <div class="col-md-6">
                <p class="primary_color po-number">Viettorrent</p>
              </div>
            </div>
            <div class="form-group">
              <label class="col-md-4 control-label"><spring:message code="common.provider"/></label>
              <div class="col-md-6">
                <p class="primary_color provider">Viettorrent</p>
              </div>
            </div>
            <div class="form-group">
              <label class="col-md-4 control-label">Total money (VND) :</label>
              <div class="col-md-6">
                <p class="primary_color card-am">Viettorrent</p>
              </div>
            </div>
            <div class="form-group">
              <label class="col-md-4 control-label"><spring:message code="common.quantity"/></label>
              <div class="col-md-6">
                <p class="primary_color total-am">Viettorrent</p>
              </div>
            </div>
            <div class="form-group">
              <label class="col-md-4 control-label"><spring:message code="common.create.time"/></label>
              <div class="col-md-6">
                <p class="primary_color time">Viettorrent</p>
              </div>
            </div>
            <div class="form-group">
              <label class="col-md-4 control-label"><spring:message code="common.files"/></label>
              <div class="col-md-6 files">
                <p class="primary_color note">Viettorrent</p>
              </div>
            </div>
            <div class="form-group">
              <label class="col-md-4 control-label" style="width: 35.5%;"><spring:message code="common.note"/></label>
              <div class="note">
                <p class="primary_color">Viettorrent</p>
              </div>
            </div>
            <div class="form-group">
              <label class="col-md-4 control-label"><spring:message code="label.warehouses.own.card"/></label>
              <div class="col-md-6">
                <p class="primary_color is-private">Viettorrent</p>
              </div>
            </div>
            <div class="form-group">
              <label class="col-md-4 control-label"><spring:message code="label.special.customer"/></label>
              <div class="col-md-6">
                <p class="primary_color special-customer">Viettorrent</p>
              </div>
            </div>
          </div>
          <div class="form-group alert alert-default mb-none mt-md p-sm divShowGroupChkSpecialCard">
            <div class="col-md-3 divCheckBoxSpecialCard"
                 style="padding-left: 0px">
              <div class="checkbox-custom checkbox-success">
                <input type="checkbox" name="ckSpecialCard" id="ckSpecialCard">
                <label for="ckSpecialCard"><spring:message
                        code="common.special.card.private"/></label>
              </div>
            </div>
            <div class="col-md-6 show-customer-special-1">
              <c:set var="allSpecialCustomer" value=","/>
              <c:forEach var="st" items="${specialCustomer}">
                <c:set var="allSpecialCustomer"
                       value="${allSpecialCustomer}${st},"/>
              </c:forEach>
              <select class="form-control multiple-select hidden"
                      multiple="multiple" id="specialCustomer1"
                      name="specialCustomer">
                <c:choose>
                  <c:when
                          test="${not empty listSpecialCustomer && listSpecialCustomer.size() > 0 }">
                    <c:forEach var="item" items="${listSpecialCustomer}">
                      <option
                              value="${item.cif}" ${fn:contains(allSpecialCustomer, item.cif) ? 'selected' : ''}>${item.displayName}
                        (${item.cif})
                      </option>
                    </c:forEach>
                  </c:when>
                  <c:otherwise>
                    <option value="">N/A</option>
                  </c:otherwise>
                </c:choose>
              </select>
            </div>
          </div>

          <div class="form-group alert alert-default mb-none mt-md p-sm divShowGroupChkSpecialCard">
            <div class="col-md-3 divCheckBoxGeneralStore"
                 style="padding-left: 0px">
              <div class="checkbox-custom checkbox-success">
                <input type="checkbox" name="ckGeneralStore" id="ckGeneralStore">
                <label for="ckGeneralStore"><spring:message code="common.special.card.general"/></label>
              </div>
          </div>
          </div>

          <div class="alert alert-default mb-none mt-md p-sm">
            <div class="checkbox-custom checkbox-success">
              <input type="checkbox" name="ckaccess" id="checkboxExample2">
              <label for="checkboxExample2"><spring:message code="common.are.u.want.to.request"/></label>
            </div>
          </div>
        </div>
        <div class="modal-footer">
          <input type="hidden" name="action" value=""/>
          <button type="button" class="btn btn-default dismissBtn" data-dismiss="modal"><spring:message code="common.btn.cancel"/></button>
          <button type="submit" class="btn btn-success btnActive btnTransfer" data-loading-text="<i class='fa fa-spinner fa-spin '></i> <spring:message code="common.waiting.pl"/>"><spring:message code="common.btn.transfer"/></button>
        </div>
      <sec:csrfInput /></form>
    </div>
  </div>
</div>
