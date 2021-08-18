package vn.mog.ewallet.contract.epin.store;

import java.util.Date;
import java.util.List;
import vn.mog.framework.contract.base.MobiliserRequestType;

@SuppressWarnings("serial")
public class GetCardDashBoardRequestType extends MobiliserRequestType {

  private List<String> providers;
  private List<String> cardTypes;
  private List<Integer> faceValues;
  private List<String> status;
  private List<String> stages;
  private Boolean isPrivate;
  private List<String> privateCustomerCif;

  private Date fromDate;
  private Date endDate;

  public List<String> getProviders() {
    return providers;
  }

  public void setProviders(List<String> providers) {
    this.providers = providers;
  }

  public List<String> getCardTypes() {
    return cardTypes;
  }

  public void setCardTypes(List<String> cardTypes) {
    this.cardTypes = cardTypes;
  }

  public List<Integer> getFaceValues() {
    return faceValues;
  }

  public void setFaceValues(List<Integer> faceValues) {
    this.faceValues = faceValues;
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

  public Boolean getIsPrivate() {
    return isPrivate;
  }

  public void setIsPrivate(Boolean isPrivate) {
    this.isPrivate = isPrivate;
  }

  public List<String> getPrivateCustomerCif() {
    return privateCustomerCif;
  }

  public void setPrivateCustomerCif(List<String> privateCustomerCif) {
    this.privateCustomerCif = privateCustomerCif;
  }
}
