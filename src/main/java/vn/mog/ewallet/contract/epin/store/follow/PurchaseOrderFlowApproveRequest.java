package vn.mog.ewallet.contract.epin.store.follow;

import java.io.Serializable;

public class PurchaseOrderFlowApproveRequest extends PurchaseOrderFlowApproveRequestType implements Serializable {

  public PurchaseOrderFlowApproveRequest(Long purchaseOrderId, String info) {
    this.purchaseOrderId = purchaseOrderId;
    this.info = info;
  }

  public PurchaseOrderFlowApproveRequest() {

  }
}
