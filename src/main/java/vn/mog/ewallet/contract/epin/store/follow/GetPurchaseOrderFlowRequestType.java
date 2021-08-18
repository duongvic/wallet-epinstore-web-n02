package vn.mog.ewallet.contract.epin.store.follow;

import java.io.Serializable;
import vn.mog.framework.contract.base.MobiliserRequestType;

public class GetPurchaseOrderFlowRequestType extends MobiliserRequestType implements Serializable {

  protected Long id;
  protected Long purchaseOrderId;
  protected Integer stage;

  public Long getId() {
    return id;
  }

  public void setId(Long id) {
    this.id = id;
  }

  public Long getPurchaseOrderId() {
    return purchaseOrderId;
  }

  public void setPurchaseOrderId(Long purchaseOrderId) {
    this.purchaseOrderId = purchaseOrderId;
  }

  public Integer getStage() {
    return stage;
  }

  public void setStage(Integer stage) {
    this.stage = stage;
  }

}
