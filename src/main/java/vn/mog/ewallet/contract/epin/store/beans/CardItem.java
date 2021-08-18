package vn.mog.ewallet.contract.epin.store.beans;

import java.io.Serializable;
import java.util.Date;
import vn.mog.ewallet.web.controller.dashboard.beans.UpType;

@SuppressWarnings("serial")
public class CardItem implements Serializable {

  private Long id;
  private String serial;
  private String pin;
  private Date issuedDate;
  private Date expiredDate;
  private Date exportedDate;
  private Integer faceValue;
  private Integer capitalValue;
  private String cardType;
  private String status;
  private String poCode;
  private Long poMerchantId;
  private String stage;

  private Date lastUpdate;
  private Long lastUpdater;
  private Date creationDate;
  private Long creator;
  private Integer upType;

  public Long getId() {
    return id;
  }

  public void setId(Long id) {
    this.id = id;
  }

  public String getSerial() {
    return serial;
  }

  public void setSerial(String serial) {
    this.serial = serial;
  }

  public String getPin() {
    return pin;
  }

  public void setPin(String pin) {
    this.pin = pin;
  }

  public Date getIssuedDate() {
    return issuedDate;
  }

  public void setIssuedDate(Date issuedDate) {
    this.issuedDate = issuedDate;
  }

  public Date getExpiredDate() {
    return expiredDate;
  }

  public void setExpiredDate(Date expiredDate) {
    this.expiredDate = expiredDate;
  }

  public Date getExportedDate() {
    return exportedDate;
  }

  public void setExportedDate(Date exportedDate) {
    this.exportedDate = exportedDate;
  }

  public Integer getFaceValue() {
    return faceValue;
  }

  public void setFaceValue(Integer faceValue) {
    this.faceValue = faceValue;
  }

  public Integer getCapitalValue() {
    return capitalValue;
  }

  public void setCapitalValue(Integer capitalValue) {
    this.capitalValue = capitalValue;
  }

  public String getCardType() {
    return cardType;
  }

  public void setCardType(String cardType) {
    this.cardType = cardType;
  }

  public String getStatus() {
    return status;
  }

  public void setStatus(String status) {
    this.status = status;
  }

  public String getPoCode() {
    return poCode;
  }

  public void setPoCode(String poCode) {
    this.poCode = poCode;
  }

  public Long getPoMerchantId() {
    return poMerchantId;
  }

  public void setPoMerchantId(Long poMerchantId) {
    this.poMerchantId = poMerchantId;
  }

  public Date getLastUpdate() {
    return lastUpdate;
  }

  public void setLastUpdate(Date lastUpdate) {
    this.lastUpdate = lastUpdate;
  }

  public Long getLastUpdater() {
    return lastUpdater;
  }

  public void setLastUpdater(Long lastUpdater) {
    this.lastUpdater = lastUpdater;
  }

  public Date getCreationDate() {
    return creationDate;
  }

  public void setCreationDate(Date creationDate) {
    this.creationDate = creationDate;
  }

  public Long getCreator() {
    return creator;
  }

  public void setCreator(Long creator) {
    this.creator = creator;
  }

  public String getStage() {
    return stage;
  }

  public void setStage(String stage) {
    this.stage = stage;
  }

  public Integer getUpType() {
    return upType;
  }

  public void setUpType(Integer upType) {
    this.upType = upType;
  }

  public String displayTextUpType(Integer upType) {

    if (UpType.NEW.getCode() == upType) {
      return UpType.NEW.getName();

    } else if (UpType.REUP.getCode() == upType) {
      return UpType.REUP.getName();
    }
    return null;
  }
}
