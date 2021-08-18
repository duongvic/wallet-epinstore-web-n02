<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal fade" id="resend-info" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
            <div class="modal-body">
                <input type="hidden" name="resend-customer-id" id="resend-customer-id">
                <p style="font-size: 14px;">Xác nhận gửi lại thông tin kết nối</p>
                <div id="msg-resend"></div>
            </div>
            <div class="modal-footer">
                <button id="btn-resend-info" type="button" class="btn btn-primary" onclick="actionResendInfo()">Có</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">Không</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>