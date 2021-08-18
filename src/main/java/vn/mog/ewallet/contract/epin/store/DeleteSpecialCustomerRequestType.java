package vn.mog.ewallet.contract.epin.store;

import vn.mog.framework.contract.base.MobiliserRequestType;

public class DeleteSpecialCustomerRequestType extends MobiliserRequestType {

  private Long customerId;
  private String customerCif;

  public Long getCustomerId() {
    return customerId;
  }

  public void setCustomerId(Long customerId) {
    this.customerId = customerId;
  }

  public String getCustomerCif() {
    return customerCif;
  }

  public void setCustomerCif(String customerCif) {
    this.customerCif = customerCif;
  }
}
