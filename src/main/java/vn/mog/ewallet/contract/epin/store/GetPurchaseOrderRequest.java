package vn.mog.ewallet.contract.epin.store;

@SuppressWarnings("serial")
public class GetPurchaseOrderRequest extends GetPurchaseOrderRequestType {

  public GetPurchaseOrderRequest(Long purchaseOrderId) {
    this.purchaseOrderId = purchaseOrderId;
  }

  public GetPurchaseOrderRequest() {

  }
}
