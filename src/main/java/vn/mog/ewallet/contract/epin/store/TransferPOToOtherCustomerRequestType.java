package vn.mog.ewallet.contract.epin.store;

import java.util.List;
import vn.mog.framework.contract.base.MobiliserRequestType;

public class TransferPOToOtherCustomerRequestType extends MobiliserRequestType {
  private static final long serialVersionUID = 1L;

  private Long purchaseOrderId;
  private List<String> customerLists;

  public Long getPurchaseOrderId() {
    return purchaseOrderId;
  }

  public List<String> getCustomerLists() {
    return customerLists;
  }

  public void setCustomerLists(List<String> customerLists) {
    this.customerLists = customerLists;
  }

  public void setPurchaseOrderId(Long purchaseOrderId) {
    this.purchaseOrderId = purchaseOrderId;
  }

}
