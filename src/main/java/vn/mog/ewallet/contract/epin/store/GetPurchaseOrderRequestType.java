package vn.mog.ewallet.contract.epin.store;

import vn.mog.framework.contract.base.MobiliserRequestType;

@SuppressWarnings("serial")
public class GetPurchaseOrderRequestType extends MobiliserRequestType {

  protected Long purchaseOrderId;
  protected boolean includePODetail;

  public Long getPurchaseOrderId() {
    return purchaseOrderId;
  }

  public void setPurchaseOrderId(Long purchaseOrderId) {
    this.purchaseOrderId = purchaseOrderId;
  }

  public boolean getIncludePODetail() {
    return includePODetail;
  }

  public boolean isIncludePODetail() {
    return includePODetail;
  }

  public void setIncludePODetail(boolean includePODetail) {
    this.includePODetail = includePODetail;
  }

}
