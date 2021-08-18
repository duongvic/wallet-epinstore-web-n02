package vn.mog.ewallet.exception;

public class MessageNotify {
  /*
   * SUCCESS(0, "Success!"), SUCCESS_VERIFY(100,
   * "Process Verify successfullly"),
   *
   *
   * ERROR(1, "Unknown exception!"), ERROR_API(2, "API Client exception!"),//
   * API Client ERROR_SERVICE(3, "Service Client exception!"),// Service
   * Client
   */

  public static final int SUCCESS_CODE = 0;
  public static final String SUCCESS_NAME = "Success!";

  public static final int ERROR_CODE = 1;
  public static final String ERROR_NAME = "Error!";

  public static final String codeErr = "codeErr";
  public static final String mesErr = "mesErr";
  public static final String SESSION_MESSAGE_NOTIFY = "message_notify";
  private String message;
  private int code;

  public MessageNotify(int code, String message) {
    this.code = code;
    this.message = message;
  }

  public MessageNotify() {

  }

  public String getMessage() {
    return message;
  }

  public void setMessage(String message) {
    this.message = message;
  }

  public int getCode() {
    return code;
  }

  public void setCode(int code) {
    this.code = code;
  }
}
