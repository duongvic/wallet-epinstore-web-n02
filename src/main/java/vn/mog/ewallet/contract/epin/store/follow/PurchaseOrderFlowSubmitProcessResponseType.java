package vn.mog.ewallet.contract.epin.store.follow;

import vn.mog.framework.contract.base.MobiliserResponseType;

public class PurchaseOrderFlowSubmitProcessResponseType extends MobiliserResponseType {

  protected Long purchaseOrderId;

  public Long getPurchaseOrderId() {
    return purchaseOrderId;
  }

  public void setPurchaseOrderId(Long purchaseOrderId) {
    this.purchaseOrderId = purchaseOrderId;
  }
}
