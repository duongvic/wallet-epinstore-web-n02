<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal fade" id="action-change-status-role" tabindex="-1" role="dialog"
     aria-labelledby="actionChangeStatusRole" aria-hidden="true">
    <%--<div class="modal-backdrop fade in"></div>--%>
    <div class="modal-dialog" role="document" style="width: 400px;">
        <input type="hidden" name="roleName" id="roleName">
        <input type="hidden" name="roleStatus" id="roleStatus">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">×</span></button>
                <h4 class="modal-title">Cảnh báo</h4>
            </div>
            <div class="modal-body">
                <!--tab1 -->
                <div class="row form-group">
                    <label class="control-label">Bạn có chắc là bạn muốn thay đổi trạng
                        thái?</label>
                </div>
                <div id="wrapper-chk-customer-confirm">
                    <input type="checkbox" name="chk-account-confirm" id="chk-account-confirm">
                    <label for="chk-account-confirm">Tôi đồng ý với các điều khoản và điều kiện sử
                        dụng.</label>
                </div>
                <div id="msg-change-role"></div>
                <!--end tab1 -->
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-sm btn-primary" id="btnChangeStatusRole"
                        onclick="changeStatusRole();">Đổi
                </button>
                <button type="button" class="btn btn-sm btn-default" data-dismiss="modal">Hủy
                </button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>