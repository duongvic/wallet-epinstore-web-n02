package vn.mog.ewallet.contract.epin.store;

import vn.mog.ewallet.contract.epin.store.beans.SpecialCustomerItem;
import vn.mog.framework.contract.base.MobiliserRequestType;

public class AddOrUpdateSpecialCustomerRequestType extends MobiliserRequestType {

  private SpecialCustomerItem specialCustomerItem;

  public SpecialCustomerItem getSpecialCustomerItem() {
    return specialCustomerItem;
  }

  public void setSpecialCustomerItem(
      SpecialCustomerItem specialCustomerItem) {
    this.specialCustomerItem = specialCustomerItem;
  }
}
