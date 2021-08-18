package vn.mog.ewallet.contract.epin.store;

import java.io.Serializable;
import vn.mog.ewallet.contract.epin.store.beans.PurchaseOrderItem;

@SuppressWarnings("serial")
public class CreateFullPurchaseOrderRequest extends CreateFullPurchaseOrderRequestType implements Serializable {

  public CreateFullPurchaseOrderRequest(PurchaseOrderItem purchaseOrder) {
    this.purchaseOrder = purchaseOrder;
  }

  public CreateFullPurchaseOrderRequest() {

  }
}
