package vn.mog.ewallet.contract.epin.store;

import vn.mog.framework.contract.base.MobiliserResponseType;

@SuppressWarnings("serial")
public class CreateFullPurchaseOrderResponseType extends MobiliserResponseType {

  protected Long purchaseOrderId;
  protected String purchaseOrderCode;

  public Long getPurchaseOrderId() {
    return purchaseOrderId;
  }

  public void setPurchaseOrderId(Long purchaseOrderId) {
    this.purchaseOrderId = purchaseOrderId;
  }

  public String getPurchaseOrderCode() {
    return purchaseOrderCode;
  }

  public void setPurchaseOrderCode(String purchaseOrderCode) {
    this.purchaseOrderCode = purchaseOrderCode;
  }

}
