package vn.mog.ewallet.contract.epin.store.beans;

import java.io.Serializable;
import java.util.Date;

public class Attachment implements Serializable {

  private static final long serialVersionUID = 1L;
  protected Long id;
  protected Long purchaseOrderId;
  protected int attachmentType;
  protected String name;
  protected String contentType;
  protected byte[] content;

  protected Date lastUpdate;
  protected Long lastUpdater;
  protected Date creationDate;
  protected Long creator;

  public Long getId() {
    return this.id;
  }

  public void setId(Long value) {
    this.id = value;
  }

  public Long getPurchaseOrderId() {
    return purchaseOrderId;
  }

  public void setPurchaseOrderId(Long purchaseOrderId) {
    this.purchaseOrderId = purchaseOrderId;
  }

  public int getAttachmentType() {
    return this.attachmentType;
  }

  public void setAttachmentType(int value) {
    this.attachmentType = value;
  }

  public String getName() {
    return this.name;
  }

  public void setName(String value) {
    this.name = value;
  }

  public String getContentType() {
    return this.contentType;
  }

  public void setContentType(String value) {
    this.contentType = value;
  }

  public byte[] getContent() {
    return this.content;
  }

  public void setContent(byte[] value) {
    this.content = value;
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
}
