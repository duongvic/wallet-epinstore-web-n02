package vn.mog.ewallet.contract.epin.store;

import java.util.Date;
import java.util.List;
import vn.mog.framework.contract.base.MobiliserRequestType;

@SuppressWarnings("serial")
public class FindPurchaseOrderRequestType extends MobiliserRequestType {

  private String quickSearch;
  private List<String> provider;
  private List<Integer> workflowState;
  private List<String> status;

  private Date fromDate;
  private Date endDate;

  private int offset;
  private int limit;
  private List<Integer> upTypes;
  private Boolean isPrivate;
  private String specialMcCif;

  public List<Integer> getUpTypes() {
    return upTypes;
  }

  public void setUpTypes(List<Integer> upTypes) {
    this.upTypes = upTypes;
  }

  public String getQuickSearch() {
    return quickSearch;
  }

  public void setQuickSearch(String quickSearch) {
    this.quickSearch = quickSearch;
  }

  public List<String> getProvider() {
    return provider;
  }

  public void setProvider(List<String> provider) {
    this.provider = provider;
  }

  public List<Integer> getWorkflowState() {
    return workflowState;
  }

  public void setWorkflowState(List<Integer> workflowState) {
    this.workflowState = workflowState;
  }

  public List<String> getStatus() {
    return status;
  }

  public void setStatus(List<String> status) {
    this.status = status;
  }

  public Date getFromDate() {
    return fromDate;
  }

  public void setFromDate(Date fromDate) {
    this.fromDate = fromDate;
  }

  public Date getEndDate() {
    return endDate;
  }

  public void setEndDate(Date endDate) {
    this.endDate = endDate;
  }

  public int getOffset() {
    return offset;
  }

  public void setOffset(int offset) {
    this.offset = offset;
  }

  public int getLimit() {
    return limit;
  }

  public void setLimit(int limit) {
    this.limit = limit;
  }

  public Boolean getIsPrivate() {
    return isPrivate;
  }

  public void setIsPrivate(Boolean isPrivate) {
    this.isPrivate = isPrivate;
  }

  public String getSpecialMcCif() {
    return specialMcCif;
  }

  public void setSpecialMcCif(String specialMcCif) {
    this.specialMcCif = specialMcCif;
  }
}
