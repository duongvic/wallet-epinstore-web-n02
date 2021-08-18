package vn.mog.ewallet.contract.epin.store.beans;

import java.io.Serializable;

public class POFileCompareResult implements Serializable, Comparable<POFileCompareResult> {

  private PurchaseOrderDetailItem file;
  private PurchaseOrderDetailItem declared;
  private boolean match;

  public POFileCompareResult() {

  }

  public PurchaseOrderDetailItem getFile() {
    return file;
  }

  public void setFile(PurchaseOrderDetailItem file) {
    this.file = file;
  }

  public PurchaseOrderDetailItem getDeclared() {
    return declared;
  }

  public void setDeclared(PurchaseOrderDetailItem declared) {
    this.declared = declared;
  }

  public boolean isMatch() {
    return match;
  }

  public void setMatch(boolean match) {
    this.match = match;
  }

  /*
   * (non-Javadoc) 6 is maxlength of faceValue
   *
   * @see java.lang.Comparable#compareTo(java.lang.Object)
   */
  public int compareTo(POFileCompareResult cmp) {
    String strToCmp = this.getFile().getCardType() + String.format("%6s", this.getFile().getFaceValue()).replace(' ', '0');
    String strCmp = cmp.getFile().getCardType() + String.format("%6s", cmp.getFile().getFaceValue()).replace(' ', '0');
    return strToCmp.compareTo(strCmp);
  }
}
