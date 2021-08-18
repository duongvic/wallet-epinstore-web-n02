package vn.mog.ewallet.contract.epin.store;

import java.util.Date;
import java.util.List;
import vn.mog.framework.contract.base.MobiliserRequestType;

@SuppressWarnings("serial")
public class FindCardRequestType extends MobiliserRequestType {

  protected String[] orderBy;
  protected boolean[] desc;
  private String quickSearch;
  private List<Integer> faceValues;
  private List<String> types;
  private List<String> status;
  private List<String> stages;
  private Date fromDate;
  private Date endDate;
  private int offset;
  private int limit;
  private List<Integer> upTypes;

  public String getQuickSearch() {
    return quickSearch;
  }

  public void setQuickSearch(String quickSearch) {
    this.quickSearch = quickSearch;
  }

  public List<Integer> getFaceValues() {
    return faceValues;
  }

  public void setFaceValues(List<Integer> faceValues) {
    this.faceValues = faceValues;
  }

  public List<String> getTypes() {
    return types;
  }

  public void setTypes(List<String> types) {
    this.types = types;
  }

  public List<String> getStatus() {
    return status;
  }

  public void setStatus(List<String> status) {
    this.status = status;
  }

  public List<String> getStages() {
    return stages;
  }

  public void setStages(List<String> stages) {
    this.stages = stages;
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

  public String[] getOrderBy() {
    return orderBy;
  }

  public void setOrderBy(String[] orderBy) {
    this.orderBy = orderBy;
  }

  public boolean[] getDesc() {
    return desc;
  }

  public void setDesc(boolean[] desc) {
    this.desc = desc;
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

  public List<Integer> getUpTypes() {
    return upTypes;
  }

  public void setUpTypes(List<Integer> upTypes) {
    this.upTypes = upTypes;
  }
}
