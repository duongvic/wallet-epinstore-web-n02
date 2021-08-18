package vn.mog.ewallet.contract.epin.store;

import vn.mog.ewallet.contract.epin.store.beans.PurchaseOrderItem;
import vn.mog.framework.contract.base.MobiliserResponseType;

@SuppressWarnings("serial")
public class GetPurchaseOrderResponseType extends MobiliserResponseType {

  protected PurchaseOrderItem purchaseOrder;

  public PurchaseOrderItem getPurchaseOrder() {
    return purchaseOrder;
  }

  public void setPurchaseOrder(PurchaseOrderItem purchaseOrder) {
    this.purchaseOrder = purchaseOrder;
  }

}
