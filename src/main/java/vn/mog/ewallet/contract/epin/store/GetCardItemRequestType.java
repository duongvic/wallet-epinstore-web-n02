package vn.mog.ewallet.contract.epin.store;

import vn.mog.framework.contract.base.MobiliserRequestType;

@SuppressWarnings("serial")
public class GetCardItemRequestType extends MobiliserRequestType {

  protected Long itemId;

  public Long getItemId() {
    return itemId;
  }

  public void setItemId(Long itemId) {
    this.itemId = itemId;
  }
}
