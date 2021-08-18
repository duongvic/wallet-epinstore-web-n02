package vn.mog.ewallet.contract.epin.store;


import java.util.Collections;
import java.util.List;
import vn.mog.ewallet.contract.epin.store.beans.SpecialCustomerItem;
import vn.mog.framework.contract.base.MobiliserResponseType;

public class FindSpecialCustomerResponseType extends MobiliserResponseType {

  private List<SpecialCustomerItem> specialCustomerList;

  private Long total;

  private Long all;
  public List<SpecialCustomerItem> getSpecialCustomerList() {
    return specialCustomerList == null ? Collections.emptyList() : specialCustomerList;
  }

  public void setSpecialCustomerList(List<SpecialCustomerItem> specialCustomerList) {
    this.specialCustomerList = specialCustomerList;
  }

  public Long getTotal() {
    return total;
  }

  public void setTotal(Long total) {
    this.total = total;
  }

  public Long getAll() {
    return all;
  }

  public void setAll(Long all) {
    this.all = all;
  }
}
