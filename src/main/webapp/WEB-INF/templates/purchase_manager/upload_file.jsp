<%@ page language="java" trimDirectiveWhitespaces="true" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../include_page/taglibs.jsp" %>


<!doctype html>
<html class="fixed" lang="${pageContext.response.locale.language}">
<c:set var="locale" value="${pageContext.response.locale}"/>
<head>
  <!-- Basic -->
  <meta charset="UTF-8">
  <title><spring:message code="dashboard.title"/></title>
  <jsp:include page="../include_page/head.jsp"/>
</head>

<body>
<section class="body">

  <jsp:include page="../include_page/header.jsp"/>

  <div class="inner-wrapper">

    <!-- start: sidebar -->
    <jsp:include page="../include_page/navigation.jsp">
      <jsp:param value="purchase_order" name="nav"/>
    </jsp:include>
    <!-- end: sidebar -->

    <section role="main" class="content-body">
      <header class="page-header">
        <div class="row">
          <div class="pl-md ">
            <div class="page-header-left">
              <ol class="breadcrumbs">
                <li><a href="#"><i class="fa fa-home"></i></a></li>
                <li><a href="list"><spring:message code="common.purchase.order"/></a></li>
                <li><span><spring:message code="common.create.PO"/></span></li>
              </ol>
            </div>
          </div>
        </div>

      </header>

      <!-- start: page -->
      <jsp:include page="../include_page/message.jsp"/>

      <div class="row content-body-wrap">
        <div class="col-md-12 col-lg-12 col-xl-12 quantrisanpham ">
          <div class="mb-md">
            <div class="wizard-tabs">
              <ul class="wizard-steps">
                <li class="col-xs-4 pl-none pr-none"><a class="text-center"><span class="badge hidden-xs">1</span>&nbsp;<spring:message code="common.title.declared.PO"/></a></li>
                <li class="col-xs-4 pl-none pr-none active"><a href="#tab2" data-toggle="tab" class="text-center"><span class="badge hidden-xs">2</span>&nbsp;<spring:message code="common.upload.file"/></a></li>
                <li class="col-xs-4 pl-none pr-none"><a class="text-center"><span class="badge hidden-xs">3</span>&nbsp;<spring:message code="common.btn.verify"/></a></li>
              </ul>
            </div>

            <div class="tab-content">
              <div id="tab1" class="tab-pane active">

                <!-- form -->
                <form action="${pageContext.request.contextPath}/provider/purchase-order/upload" method="post" enctype="multipart/form-data">
                  <div class="row content-body-wrap">
                    <div class="col-md-12 col-lg-12 col-xl-12">
                      <section class="panel panel-default">
                        <div class="panel-title">
                          <h4 style="font-size: 18px;"><spring:message code="common.PO.number"/> ${param.poCode}</h4>
                        </div>
                      </section>

                      <div class="panel-body edit_profile">
                        <input type="hidden" name="id" value="${param.id }"/>
                        <div class="form-group">
                          <label class="col-md-1 control-label">*<spring:message code="common.note"/></label>
                          <div class="col-md-4 tertiary_color">
                            <spring:message code="common.title.guild"/> <i class="fa  fa-question-circle text-muted m-xs " data-toggle="popover" data-trigger="hover" data-placement="top"
                                     data-content='<spring:message code="common.title.step1.choose.file.format.file"/>.<br />
																				<spring:message code="common.title.step2.fill.the.content.in.more.information"/><br />
																				<spring:message code="common.title.step3.click.confirm.to.create.receipt"/><br />
																				<spring:message code="common.title.step4.click.confirm.to.moving.step.verify"/>' data-html="true" data-original-title="" title=""></i>
                          </div>
                        </div>
                        <div class="form-group mb-none">
                          <label class="col-md-3 control-label"><spring:message code="common.files"/> </label>
                          <div class="col-md-6">
                            <input type="file" name="file" id="file-2" class="inputfile inputfile-2" data-multiple-caption="{count} files selected" multiple/>
                            <label for="file-2"><i class="fa fa-upload" aria-hidden="true"></i> <span><spring:message code="common.btn.choose.file"/> </span></label>
                            <p><strong class="secondary_color"><5mb </strong>(*.xls,*.xlsx,*.txt,*.dat)</p>
                          </div>
                        </div>
                        <!-- div show file -->
                        <div class="form-group">
                          <div class="col-md-3"></div>
                          <div class="col-md-6 fileshow"></div>
                        </div>
                        <jsp:include page="dowloadTemplete.jsp"/>

                        <div class="form-group">
                          <label class="col-md-3 control-label"><spring:message code="common.reason"/></label>
                          <div class="col-md-4">
                            <textarea name="note" class="form-control" rows="3" id="textareaDefault"></textarea>
                          </div>
                        </div>
                        <div class="alert alert-default mb-none mt-md p-sm">
                          <div class="checkbox-custom checkbox-success">
                            <input type="checkbox" name="ckaccess" id="checkboxExample3">
                            <label for="checkboxExample3"><spring:message code="common.confirm.to.upload.file"/></label>
                          </div>

                        </div>
                        <button type="submit" class=" mt-md btn btn-success fr po-next-step">Xác nhận</button>


                      </div>
                    </div>
                  </div>
                <sec:csrfInput />
                </form>
              </div>
              <div id="tab2" class="tab-pane"></div>
            </div>
          </div>
        </div>
      </div>
      <!-- end: page -->
    </section>
    <jsp:include page="../include_page/footer.jsp"/>
  </div>
</section>
<script>
  $(document).ready(function () {
    $('form').submit(function () {
      if (!$('#checkboxExample3').is(':checked')) {
        $.MessageBox({message: "<spring:message code="common.unconfirmed.upload.file"/>"});
        return false;
      }
    });
    $('form input:file').change(function (click) {
      var files = $(this)[0].files;
      var exts = ['txt', 'xls', 'xlsx', 'dat'];
      var extsExcel = ['xls', 'xlsx'];
      var checkExt = true;
      var iExcel = 0;
      if (files.length > 0) {
        //console.log(files);
        for (var i = 0; i < files.length; i++) {
          if (files[i].name.length < 71) {
            var get_ext = files[i].name.split('.');
            // reverse name to check extension
            get_ext = get_ext.reverse();
            // check file type is valid as given in 'exts' array
            if ($.inArray(get_ext[0].toLowerCase(), exts) < 0) {
              checkExt = false;
            }
            if ($.inArray(get_ext[0].toLowerCase(), extsExcel) > -1) {
              iExcel++;
            }
          }
          else {
            $.MessageBox({message: '<spring:message code="message.file.name.can.not.be.longer.than.70.characters"/>'});
            $(this).val('');
          }
        }
        if (!checkExt) {
          $.MessageBox({message: '<spring:message code="common.upload.file.not.format"/>'});
          $(this).val('');
        }
        else {
          if (iExcel > 1) {
            $.MessageBox({message: '<spring:message code="common.only.1.execl.file.uploaded"/>'});
            $(this).val('');
          }
        }
      }
    });
    var inputs = document.querySelectorAll('.inputfile');
    Array.prototype.forEach.call(inputs, function (input) {
      var label = input.nextElementSibling,
          labelVal = label.innerHTML;
      input.addEventListener('change', function (e) {
        $('div.fileshow').html('');
        var fileName = '';
        if (this.files && this.files.length > 1)
          fileName = ( this.getAttribute('data-multiple-caption') || '' ).replace('{count}', this.files.length);
        else
          fileName = e.target.value.split('\\').pop();
        if (fileName)
          label.querySelector('span').innerHTML = fileName;
        else
          label.innerHTML = labelVal;
        if (this.files && this.files.length > 0) {
          $.each(e.target.files, function (idx, elm) {
            var size = elm.size / 1024;
            $('div.fileshow').append('<p class="primary_color">' + elm.name + ' - size : ' + size + 'KB</p>')
          });
        }
      });
    });
  });
</script>
</body>
</html>




