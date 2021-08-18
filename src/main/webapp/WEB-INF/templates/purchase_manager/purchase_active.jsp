<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal fade" id="status" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <form name="status" action="update-status" method="post">
        <input type="hidden" name="poid" value=""/>
        <input type="hidden" name="poCode" value=""/>
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">
            <span aria-hidden="true">&times;</span><span class="sr-only"><spring:message code="common.btn.close"/></span>
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
          <div class="form-group">
            <label class="col-md-4 control-label"><spring:message code="common.note"/> </label>
            <div class="col-md-6">
              <textarea name="note" class="form-control" rows="3" cols="3"></textarea>
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
          <button type="button" class="btn btn-default dismissBtn" data-dismiss="modal"> <spring:message code="common.btn.cancel"/></button>
          <button type="submit" class="btn btn-warning btnInactive btnStatus" data-loading-text="<i class='fa fa-spinner fa-spin '></i> <spring:message code="common.waiting.pl"/> "> <spring:message code="common.btn.inactive" /></button>
          <button type="submit" class="btn btn-success btnActive btnStatus" data-loading-text="<i class='fa fa-spinner fa-spin '></i> <spring:message code="common.waiting.pl"/>"> <spring:message code="common.btn.active"/></button>
        </div>
      <sec:csrfInput /></form>
    </div>
  </div>
</div>