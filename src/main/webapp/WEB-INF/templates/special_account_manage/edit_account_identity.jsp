<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="panel-title">
  <h4 style="margin-bottom: 1.5rem">Identity info</h4>
  <div class="panel-tools hidden">
    <a class="mb-xs mt-xs btn btn-success" style="line-height: 28px" href="#"><i class="fa fa-plus"></i>&nbsp;</a>
  </div>
</div>

<div class="panel-body">

  <div class="row">
    <!-- identity info -->
    <div class="col-sm-6">
      <div class="col-sm-12" style="margin-bottom: 10px;">
        <label class="col-sm-4 control-label nowrap">Identity type&nbsp; *</label>
        <div class="col-sm-8 double-input">

          <select class="form-control w100" data-plugin-selectTwo id="identity-type" name="identity-type" required style="width: 100%">
            <option value="1" ${identityDataForm.identityType eq 1 ? 'selected' : ''}>Căn cước công dân</option><!-- Citizenship Card -->
            <option value="7" ${identityDataForm.identityType eq 7 ? 'selected' : ''}>Hộ chiếu</option><!-- Passport -->
            <option value="2" ${identityDataForm.identityType eq 2 ? 'selected' : ''}>Chứng minh thư</option><!-- Identity Card -->
          </select>
        </div>
      </div>

      <div class="col-sm-12" style="margin-bottom: 10px;">
        <label class="col-sm-4 control-label nowrap">Identity number&nbsp; *</label>
        <div class="col-sm-8 double-input">
          <input type="text" name="identity-number" class="form-control w100" value="${identityDataForm.identityNumber}" placeholder="Identity number" style="width: 100%;">
        </div>
      </div>

      <div class="col-sm-12" style="margin-bottom: 10px;">
        <label class="col-sm-4 control-label nowrap">Issue date&nbsp; *</label>
        <div class="col-sm-8 double-input">
          <input type="text" name="issue-date" class="form-control" value="${identityDataForm.textIssueDate()}" placeholder="Issue date" style="width: 100%;">
        </div>
      </div>

      <div class="col-sm-12" style="margin-bottom: 10px;">
        <label class="col-sm-4 control-label nowrap">Expire date&nbsp; *</label>
        <div class="col-sm-8 double-input">
          <input type="text" name="expire-date" class="form-control" value="${identityDataForm.textExpireDate()}" placeholder="Expire date" style="width: 100%;">
        </div>
      </div>

      <div class="col-sm-12" style="margin-bottom: 10px;">
        <label class="col-sm-4 control-label nowrap">Place of issue&nbsp; *</label>
        <div class="col-sm-8 double-input">
          <input type="text" name="place-of-issue" class="form-control" value="${identityDataForm.placeOfIssue}" placeholder="Place of issue" style="width: 100%;">
        </div>
      </div>
    </div>

    <!-- identity images -->
    <div class="col-sm-6">
      <div class="col-sm-12">
        <label class="col-sm-4 control-label nowrap">Identity images</label>
        <div class="col-sm-8 double-input">
          <div class="row">
            <c:set var="imageDefault" ><c:url value="/assets/images/ava-blank.png" /></c:set>
            <img src="${identityDataForm.frontFaceImage eq null ? imageDefault : identityDataForm.frontFaceImage.getBase64Image()}" class="col-sm-6" style="margin-bottom: 5px; height: 140px;">
            <img src="${identityDataForm.backFaceImage eq null ? imageDefault : identityDataForm.backFaceImage.getBase64Image()}" class="col-sm-6" style="margin-bottom: 5px; height: 140px;">
            <img src="${identityDataForm.selfieImage eq null ? imageDefault : identityDataForm.selfieImage.getBase64Image()}" class="col-sm-6" style="margin-bottom: 5px; height: 140px;">
          </div>
        </div>
      </div>
    </div>
  </div>

  <div class="row">
    <div class="form-group">
      <div class="col-sm-12 text-right">
        <%--<button class="btn btn-sm btn-success" type="button" id="edit_btn" name="edit" onclick="editAccount()" value="create"><i class="fa fa-pencil"></i> Chỉnh sửa</button>
        <button class="btn btn-sm btn-primary" type="submit" value="Save" name="edit" id="save_btn" disabled=""><i class="fa fa-save"></i>Lưu</button>--%>
      </div>
    </div>
  </div>

</div>