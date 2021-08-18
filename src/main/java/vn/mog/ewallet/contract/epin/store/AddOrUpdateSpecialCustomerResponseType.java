package vn.mog.ewallet.contract.epin.store;

import vn.mog.framework.contract.base.MobiliserResponseType;

public class AddOrUpdateSpecialCustomerResponseType extends MobiliserResponseType {

  protected Long itemId;

  public Long getItemId() {
    return itemId;
  }

  public void setItemId(Long itemId) {
    this.itemId = itemId;
  }
}
