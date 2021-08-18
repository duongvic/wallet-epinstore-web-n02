package vn.mog.ewallet.contract.epin.store;

import java.util.List;
import vn.mog.framework.contract.base.MobiliserRequestType;

public class FindSpecialCustomerRequestType extends MobiliserRequestType {

  private Integer offset;
  private Integer limit;
  private Boolean isActive;
  private String quickSearch;
  private List<Integer> customerTypes;

  public Integer getOffset() {
    return offset;
  }

  public void setOffset(Integer offset) {
    this.offset = offset;
  }

  public Integer getLimit() {
    return limit;
  }

  public void setLimit(Integer limit) {
    this.limit = limit;
  }

  public Boolean getIsActive() {
    return isActive;
  }

  public void setIsActive(Boolean isActive) {
    this.isActive = isActive;
  }

  public String getQuickSearch() {
    return quickSearch;
  }

  public void setQuickSearch(String quickSearch) {
    this.quickSearch = quickSearch;
  }

  public List<Integer> getCustomerTypes() {
    return customerTypes;
  }

  public void setCustomerTypes(List<Integer> customerTypes) {
    this.customerTypes = customerTypes;
  }
}
