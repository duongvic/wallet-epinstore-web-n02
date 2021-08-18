package vn.mog.ewallet.contract.epin.store.follow;

import java.io.Serializable;
import vn.mog.framework.contract.base.MobiliserResponseType;

public class PurchaseOrderFlowRejectResponseType extends MobiliserResponseType implements Serializable {

  protected Long purchaseOrderId;

  public Long getPurchaseOrderId() {
    return purchaseOrderId;
  }

  public void setPurchaseOrderId(Long purchaseOrderId) {
    this.purchaseOrderId = purchaseOrderId;
  }
}
