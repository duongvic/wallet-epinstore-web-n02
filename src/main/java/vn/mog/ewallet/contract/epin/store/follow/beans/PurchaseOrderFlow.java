package vn.mog.ewallet.contract.epin.store.follow.beans;

import java.io.Serializable;
import java.util.Date;

public class PurchaseOrderFlow implements Serializable {

  private Long id;
  private Long poId;
  private String description;
  private Integer lastStage;
  private Integer currStage;
  private String info;
  private String type;

  private Boolean active;
  private Long creator;
  private Date createdTime;
  private Integer lastUpdater;
  private Date lastUpdatedTime;

  public PurchaseOrderFlow() {
  }

  public PurchaseOrderFlow(Long id, Long poId, String description, Integer lastStage, Integer currStage, String info, String type, Boolean active,
      Long creator, Date createdTime, Integer lastUpdater, Date lastUpdatedTime) {
    super();
    this.id = id;
    this.poId = poId;
    this.description = description;
    this.lastStage = lastStage;
    this.currStage = currStage;
    this.info = info;
    this.type = type;
    this.active = active;
    this.creator = creator;
    this.createdTime = createdTime;
    this.lastUpdater = lastUpdater;
    this.lastUpdatedTime = lastUpdatedTime;
  }

  public Long getId() {
    return id;
  }

  public void setId(Long id) {
    this.id = id;
  }

  public Long getPoId() {
    return poId;
  }

  public void setPoId(Long poId) {
    this.poId = poId;
  }

  public String getDescription() {
    return description;
  }

  public void setDescription(String description) {
    this.description = description;
  }

  public Integer getLastStage() {
    return lastStage;
  }

  public void setLastStage(Integer lastStage) {
    this.lastStage = lastStage;
  }

  public Integer getCurrStage() {
    return currStage;
  }

  public void setCurrStage(Integer currStage) {
    this.currStage = currStage;
  }

  public String getInfo() {
    return info;
  }

  public void setInfo(String info) {
    this.info = info;
  }

  public String getType() {
    return type;
  }

  public void setType(String type) {
    this.type = type;
  }

  public Boolean getActive() {
    return active;
  }

  public void setActive(Boolean active) {
    this.active = active;
  }

  public Long getCreator() {
    return creator;
  }

  public void setCreator(Long creator) {
    this.creator = creator;
  }

  public Date getCreatedTime() {
    return createdTime;
  }

  public void setCreatedTime(Date createdTime) {
    this.createdTime = createdTime;
  }

  public Integer getLastUpdater() {
    return lastUpdater;
  }

  public void setLastUpdater(Integer lastUpdater) {
    this.lastUpdater = lastUpdater;
  }

  public Date getLastUpdatedTime() {
    return lastUpdatedTime;
  }

  public void setLastUpdatedTime(Date lastUpdatedTime) {
    this.lastUpdatedTime = lastUpdatedTime;
  }

}
