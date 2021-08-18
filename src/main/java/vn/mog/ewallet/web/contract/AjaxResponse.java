package vn.mog.ewallet.web.contract;

public class AjaxResponse {

  private int code;
  private String message;

  public AjaxResponse() {
  }

  public AjaxResponse(int code, String message) {
    super();
    this.code = code;
    this.message = message;
  }

  public int getCode() {
    return code;
  }

  public void setCode(int code) {
    this.code = code;
  }

  public String getMessage() {
    return message;
  }

  public void setMessage(String message) {
    this.message = message;
  }

}
