package vn.mog.ewallet.contract.epin.store.follow;

import java.io.Serializable;
import vn.mog.framework.contract.base.MobiliserRequestType;

public class PurchaseOrderFlowApproveRequestType extends MobiliserRequestType implements Serializable {

  protected Long purchaseOrderId;
  protected String info;

  public Long getPurchaseOrderId() {
    return purchaseOrderId;
  }

  public void setPurchaseOrderId(Long purchaseOrderId) {
    this.purchaseOrderId = purchaseOrderId;
  }

  public String getInfo() {
    return info;
  }

  public void setInfo(String info) {
    this.info = info;
  }
}
