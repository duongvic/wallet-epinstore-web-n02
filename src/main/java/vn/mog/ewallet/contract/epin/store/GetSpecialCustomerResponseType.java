package vn.mog.ewallet.contract.epin.store;


import vn.mog.ewallet.contract.epin.store.beans.SpecialCustomerItem;
import vn.mog.framework.contract.base.MobiliserResponseType;

public class GetSpecialCustomerResponseType extends MobiliserResponseType {

  private SpecialCustomerItem specialCustomer;

  public SpecialCustomerItem getSpecialCustomer() {
    return specialCustomer;
  }

  public void setSpecialCustomer(
      SpecialCustomerItem specialCustomer) {
    this.specialCustomer = specialCustomer;
  }
}
