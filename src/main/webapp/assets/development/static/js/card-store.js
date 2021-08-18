/*$(document).ready(function(){
	$.validator.addMethod("inputdigits", $.validator.methods.digits, "Hãy nhập số nguyên (Không nhập các ký tự đặc biệt (\<\>\?\.\:\"\(\),cách trống).)");
	$.validator.addClassRules("inputtelco", { inputdigits: true });
});*/

function formatNumberSeparator(x, locale) {
	var locale = "vi";
	var separator = ",";
	if (locale == "vi") {
		separator = ".";
	}
	return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, separator);
}

function disagree() {
	$.MessageBox({message: 'Bạn không có quyền thao tác!'});
}

function messageInfor(message) {
    $.MessageBox({message: message});
}

