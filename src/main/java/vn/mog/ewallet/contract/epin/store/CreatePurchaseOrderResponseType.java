package vn.mog.ewallet.contract.epin.store;

import vn.mog.framework.contract.base.MobiliserResponseType;

@SuppressWarnings("serial")
public class CreatePurchaseOrderResponseType extends MobiliserResponseType {

  private Long purchaseOrderId;
  private String purchaseOrderCode;

  public Long getPoId() {
    return purchaseOrderId;
  }

  public void setPoId(Long poId) {
    this.purchaseOrderId = poId;
  }

  public String getPoCode() {
    return purchaseOrderCode;
  }

  public void setPoCode(String poCode) {
    this.purchaseOrderCode = poCode;
  }
}
