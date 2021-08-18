package vn.mog.ewallet.contract.epin.store;

import vn.mog.ewallet.contract.epin.store.beans.PurchaseOrderItem;
import vn.mog.framework.contract.base.MobiliserRequestType;

@SuppressWarnings("serial")
public class CreatePurchaseOrderRequestType extends MobiliserRequestType {

  protected PurchaseOrderItem purchaseOrder;
  protected boolean includePODetail;

  public boolean getIncludePODetail() {
    return includePODetail;
  }

  public boolean isIncludePODetail() {
    return includePODetail;
  }

  public void setIncludePODetail(boolean includePODetail) {
    this.includePODetail = includePODetail;
  }

  public PurchaseOrderItem getPurchaseOrder() {
    return purchaseOrder;
  }

  public void setPurchaseOrder(PurchaseOrderItem purchaseOrder) {
    this.purchaseOrder = purchaseOrder;
  }

}
