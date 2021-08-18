<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal fade" id="ready-verify" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <form name="ready-verify" action="submit-po" method="post">
        <input type="hidden" name="poid" value=""/>
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">
            <span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
          </button>
          <h4 class="modal-title" id="myModalLabel"><spring:message code="common.information.PO.detail"/></h4>
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
              <label class="col-md-4 control-label"><spring:message code="common.title.total.money.VND"/> </label>
              <div class="col-md-6">
                <span class="primary_color card-am">Viettorrent</span>&nbsp;<span>(VND)</span>
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
                <p class="time">Viettorrent</p>
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
                <p>Viettorrent</p>
              </div>
            </div>
            <div class="form-group">
              <label class="col-md-4 control-label"><spring:message code="label.warehouses.own.card"/></label>
              <div class="col-md-6">
                <p class="primary_color special-customer">Viettorrent</p>
              </div>
            </div>
            <div class="form-group">
              <label class="col-md-4 control-label"><spring:message code="label.special.customer"/></label>
              <div class="col-md-6">
                <p class="primary_color is-private">Viettorrent</p>
              </div>
            </div>
          </div>
          <div class="form-group">
            <label class="col-md-4 control-label"><spring:message code="common.note"/></label>
            <div class="col-md-6">
              <textarea name="note" class="form-control" rows="3" cols="3"></textarea>
            </div>
          </div>
          <div class="alert alert-default mb-none mt-md p-sm">
            <div class="checkbox-custom checkbox-success">
              <input type="checkbox" name="ckaccess" id="checkboxExample3">
              <label for="checkboxExample3"><spring:message code="purchase.verify.checkbox.label.checked"/></label>
            </div>
          </div>
        </div>
        <div class="modal-footer">
          <input type="hidden" name="action" value="READY_TO_VERIFY"/>
          <button type="button" class="btn btn-default dismissBtn" data-dismiss="modal"> <spring:message code="common.btn.cancel"/></button>
          <button type="submit" class="btn btn-success btnActive btnReady" data-loading-text="<i class='fa fa-spinner fa-spin '></i> <spring:message code="common.waitting.pl"/>"> <spring:message code="common.confirm.information"/></button>
        </div>
      <sec:csrfInput />
      </form>
    </div>
  </div>
</div>