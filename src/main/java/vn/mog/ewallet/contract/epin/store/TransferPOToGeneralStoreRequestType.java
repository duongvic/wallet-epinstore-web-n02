package vn.mog.ewallet.contract.epin.store;

import vn.mog.framework.contract.base.MobiliserRequestType;

public class TransferPOToGeneralStoreRequestType extends MobiliserRequestType {

  private static final long serialVersionUID = 1L;

  private Long purchaseOrderId;

  public Long getPurchaseOrderId() {
    return purchaseOrderId;
  }

  public void setPurchaseOrderId(Long purchaseOrderId) {
    this.purchaseOrderId = purchaseOrderId;
  }

}
