package vn.mog.ewallet.exception;

public class FrontEndException extends RuntimeException {

  /**
   *
   */
  private static final long serialVersionUID = 1L;
  private Integer errorCode;
  private String errorMessage;
  private String source;

  public FrontEndException(Integer errorCode, String errorMessage) {
    this.setErrorCode(errorCode);
    this.setErrorMessage(errorMessage);
  }

  public FrontEndException(Integer errorCode, String source, String errorMessage) {
    this.setErrorCode(errorCode);
    this.setSource(source);
    this.setErrorMessage(errorMessage);
  }

  public String getSource() {
    return source;
  }

  public void setSource(String source) {
    this.source = source;
  }

  public Integer getErrorCode() {
    return errorCode;
  }

  /**
   *
   * @param newVal
   */
  public void setErrorCode(Integer newVal) {
    errorCode = newVal;
  }

  public String getErrorMessage() {
    return errorMessage;
  }

  /**
   *
   * @param newVal
   */
  public void setErrorMessage(String newVal) {
    errorMessage = newVal;
  }

}