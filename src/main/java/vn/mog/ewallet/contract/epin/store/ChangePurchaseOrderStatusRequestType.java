package vn.mog.ewallet.contract.epin.store;

import vn.mog.framework.contract.base.MobiliserRequestType;

@SuppressWarnings("serial")
public class ChangePurchaseOrderStatusRequestType extends MobiliserRequestType {

  protected String poCode;
  protected boolean activeOrInactive;
  protected String note;

  public String getPoCode() {
    return poCode;
  }

  public void setPoCode(String poCode) {
    this.poCode = poCode;
  }

  public boolean getActiveOrInactive() {
    return activeOrInactive;
  }

  public void setActiveOrInactive(boolean activeOrInactive) {
    this.activeOrInactive = activeOrInactive;
  }

  public String getNote() {
    return note;
  }

  public void setNote(String note) {
    this.note = note;
  }

}
