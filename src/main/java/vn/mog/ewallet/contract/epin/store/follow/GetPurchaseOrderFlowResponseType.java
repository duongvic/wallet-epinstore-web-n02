package vn.mog.ewallet.contract.epin.store.follow;

import java.io.Serializable;
import vn.mog.ewallet.contract.epin.store.follow.beans.PurchaseOrderFlow;
import vn.mog.framework.contract.base.MobiliserResponseType;

public class GetPurchaseOrderFlowResponseType extends MobiliserResponseType implements Serializable {

  protected PurchaseOrderFlow purchaseOrderFlow;

  public PurchaseOrderFlow getPurchaseOrderFlow() {
    return purchaseOrderFlow;
  }

  public void setPurchaseOrderFlow(PurchaseOrderFlow purchaseOrderFlow) {
    this.purchaseOrderFlow = purchaseOrderFlow;
  }

}
