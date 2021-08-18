package vn.mog.ewallet.contract.epin.store.beans;

import java.io.Serializable;

@SuppressWarnings("serial")
public class StoreNotfInfo implements Serializable {

  private Integer warnLevel;
  private Integer warnQuantity;
  private Long currQuantity;

  public StoreNotfInfo() {
  }

  public StoreNotfInfo(Integer warnLevel, Integer warnQuantity, Long currQuantity) {
    this.warnLevel = warnLevel;
    this.warnQuantity = warnQuantity;
    this.currQuantity = currQuantity;
  }

  public Integer getWarnLevel() {
    return warnLevel;
  }

  public void setWarnLevel(Integer warnLevel) {
    this.warnLevel = warnLevel;
  }

  public Integer getWarnQuantity() {
    return warnQuantity;
  }

  public void setWarnQuantity(Integer warnQuantity) {
    this.warnQuantity = warnQuantity;
  }

  public Long getCurrQuantity() {
    return currQuantity;
  }

  public void setCurrQuantity(Long currQuantity) {
    this.currQuantity = currQuantity;
  }
}