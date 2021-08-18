package vn.mog.ewallet.contract.epin.store.follow;

import java.io.Serializable;

public class PurchaseOrderFlowRejectRequest extends PurchaseOrderFlowRejectRequestType implements Serializable {

  public PurchaseOrderFlowRejectRequest(Long purchaseOrderId, String info) {
    this.purchaseOrderId = purchaseOrderId;
    this.info = info;
  }

  public PurchaseOrderFlowRejectRequest() {

  }
}
