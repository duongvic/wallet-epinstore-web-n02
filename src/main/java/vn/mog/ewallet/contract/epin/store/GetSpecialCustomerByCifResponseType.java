package vn.mog.ewallet.contract.epin.store;

import vn.mog.ewallet.contract.epin.store.beans.SpecialCustomerItem;
import vn.mog.framework.contract.base.MobiliserRequestType;

public class GetSpecialCustomerByCifResponseType extends MobiliserRequestType {

  private SpecialCustomerItem specialCustomer;

  public SpecialCustomerItem getSpecialCustomer() {
    return specialCustomer;
  }

  public void setSpecialCustomer(SpecialCustomerItem specialCustomer) {
    this.specialCustomer = specialCustomer;
  }
}
