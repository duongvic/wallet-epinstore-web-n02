<%@ page language="java" trimDirectiveWhitespaces="true" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="display" uri="http://displaytag.sf.net/el" %>
<display:setProperty name="paging.banner.placement" value="bottom"/>
<display:setProperty name="paging.banner.group_size">4</display:setProperty>
<display:setProperty name="paging.banner.page.separator"> </display:setProperty>
<display:setProperty name="paging.banner.item_name">
  <span class="pagebanner"> <spring:message code="table.paging.banner.item_name"/> </span>
</display:setProperty>
<display:setProperty name="paging.banner.items_name">
  <span class="pagebanner"> <spring:message code="table.paging.banner.items_name"/> </span>
</display:setProperty>
<display:setProperty name="paging.banner.no_items_found">
  </div>
  <div class="row datatables-footer">
  <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
    <div class="dataTables_info_footer">
      <div class="dataTables_info" id="datatable-default_info" role="status" aria-live="polite"><spring:message code="table.paging.banner.no_items_found"/></div>
    </div>
  </div>
</display:setProperty>
<display:setProperty name="paging.banner.one_item_found">
  </div>
  <div class="row datatables-footer">
  <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
    <div class="dataTables_info_footer">
      <div class="dataTables_info" id="datatable-default_info" role="status" aria-live="polite"><spring:message code="table.paging.banner.one_item_found"/></div>
    </div>
  </div>
</display:setProperty>
<display:setProperty name="paging.banner.all_items_found">
  </div>
  <div class="row datatables-footer">
  <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
    <div class="dataTables_info_footer">
      <div class="dataTables_info" id="datatable-default_info" role="status" aria-live="polite"><spring:message code="table.paging.banner.all_items_found"/></div>
    </div>
  </div>
  <!-- <span class="pagebanner"></span> -->
</display:setProperty>
<display:setProperty name="paging.banner.some_items_found">
  </div>
  <div class="row datatables-footer">
  <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
    <div class="dataTables_info_footer">
      <div class="dataTables_info" id="datatable-default_info" role="status" aria-live="polite"><spring:message code="table.paging.banner.some_items_found"/></div>
    </div>
  </div>
  <!-- <span class="pagebanner"></span> -->
</display:setProperty>
<display:setProperty name="paging.banner.full">
  <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
    <div class="pagination_footer">
      <ul class="pagination">
        <li><a href="{1}"><spring:message code="table.paging.banner.first"/></a></li>
        <li><a href="{2}"><spring:message code="table.paging.banner.prev"/></a></li>
        {0}
        <li><a href="{3}"><spring:message code="table.paging.banner.next"/></a></li>
        <li><a href="{4}"><spring:message code="table.paging.banner.last"/></a></li>
      </ul>
    </div>
  </div>
</display:setProperty>
<display:setProperty name="paging.banner.first">
  <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
    <div class="pagination_footer">
      <ul class="pagination">
        {0}
        <li><a href="{3}"><spring:message code="table.paging.banner.next"/></a></li>
        <li><a href="{4}"><spring:message code="table.paging.banner.last"/></a></li>
      </ul>
    </div>
  </div>
</display:setProperty>
<display:setProperty name="paging.banner.last">
  <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
    <div class="pagination_footer">
      <ul class="pagination">
        <li><a href="{1}"><spring:message code="table.paging.banner.first"/></a></li>
        <li><a href="{2}"><spring:message code="table.paging.banner.prev"/></a></li>
        {0}
      </ul>
    </div>
  </div>
</display:setProperty>
<display:setProperty name="paging.banner.page.selected">
  <li class="active"><a href="javascript:;">{0}</a></li>
</display:setProperty>
<display:setProperty name="paging.banner.page.link">
  <li><a href="{1}">{0}</a></li>
</display:setProperty>
<display:setProperty name="paging.banner.onepage">
  <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
    <div class="pagination_footer">
      <ul class="pagination">
        {0}
      </ul>
    </div>
  </div>
</display:setProperty>
<display:setProperty name="export.banner">
  <div class="exportlinks"><spring:message code="table.export.banner"/></div>
</display:setProperty>
<display:setProperty name="basic.msg.empty_list_row">
  <tr class="empty">
    <td colspan="{0}"><spring:message code="table.basic.msg.empty"/></td>
  </tr>
</display:setProperty>
<display:setProperty name="basic.msg.empty_list">
  <spring:message code="table.basic.msg.empty"/>
</display:setProperty>
