<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal fade" id="detail" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <form name="detail" action="getPoDetail" method="post">
        <input type="hidden" name="poid" value=""/>
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">
            <span aria-hidden="true">&times;</span><span class="sr-only"><spring:message code="common.btn.close"/> </span>
          </button>
          <h4 class="modal-title" id="myModalLabel"><spring:message code="common.information.PO.detail"/></h4>
        </div>
        <div class="modal-body">
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
            <label class="col-md-4 control-label"><spring:message code="common.title.total.money.VND"/></label>
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
            <label class="col-md-4 control-label"><spring:message code="common.title.capital.value"/></label>
            <div class="col-md-6">
              <p class="primary_color total-cc">Viettorrent</p>
            </div>
          </div>
          <div class="form-group">
            <label class="col-md-4 control-label"><spring:message code="common.create.time"/></label>
            <div class="col-md-6">
              <p class="primary_color time">Viettorrent</p>
            </div>
          </div>
          <div class="form-group">
            <label class="col-md-4 control-label"><spring:message code="common.status"/></label>
            <div class="col-md-6">
              <p class="primary_color status">Viettorrent</p>
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
          <div class="title-bo-box">
            <spring:message code="common.detail.information"/>
          </div>

          <div class="bo-box" id="bo-box">
            <div class="table-responsive qlsp">
              <table class="table table-bordered table-striped mb-none datatable-default">
                <thead>
                <tr>
                  <th><spring:message code="purchase.table.no"/></th>
                  <th style="width:10%"><spring:message code="purchase.table.card.type"/></th>
                  <th class="text-right"><spring:message code="purchase.table.face.value"/></th>
                  <th class="text-right"><spring:message code="purchase.table.col.quantity"/></th>
                  <th class="text-right"><spring:message code="purchase.table.discount"/></th>
                  <th class="text-right"><spring:message code="purchase.table.capital.value"/></th>
                </tr>
                </thead>
                <tbody>
                </tbody>
              </table>
            </div>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default dismissBtn" data-dismiss="modal"><spring:message code="common.btn.cancel"/></button>
        </div>
      <sec:csrfInput />
      </form>
    </div>
  </div>
</div>