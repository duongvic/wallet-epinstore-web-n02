package vn.mog.ewallet.contract.epin.store;

import vn.mog.framework.contract.base.MobiliserRequestType;

@SuppressWarnings("serial")
public class VerifyPurchaseOrderFileRequestType extends MobiliserRequestType {

  public static final String CONFIRMED = "CONFIRMED";
  public static final String REJECTED = "REJECTED";

  protected Long poId;
  protected String password;

  public Long getPoId() {
    return poId;
  }

  public void setPoId(Long poId) {
    this.poId = poId;
  }

  public String getPassword() {
    return password;
  }

  public void setPassword(String password) {
    this.password = password;
  }

}
