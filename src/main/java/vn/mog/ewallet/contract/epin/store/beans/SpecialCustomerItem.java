package vn.mog.ewallet.contract.epin.store.beans;

import java.io.Serializable;

@SuppressWarnings("serial")
public class SpecialCustomerItem implements Serializable{

  private Long id;
  private String cif;
  private String displayName;
  private Integer customerType;
  private Boolean isActive;
  private String email;
  private String phoneNumber;
  private String description;

  public SpecialCustomerItem() {
    super();
  }


  public Long getId() {
    return id;
  }

  public void setId(Long id) {
    this.id = id;
  }

  public String getCif() {
    return cif;
  }

  public void setCif(String cif) {
    this.cif = cif;
  }

  public String getDisplayName() {
    return displayName;
  }

  public void setDisplayName(String displayName) {
    this.displayName = displayName;
  }

  public Integer getCustomerType() {
    return customerType;
  }

  public void setCustomerType(Integer customerType) {
    this.customerType = customerType;
  }

  public Boolean getIsActive() {
    return isActive;
  }

  public void setIsActive(Boolean active) {
    isActive = active;
  }

  public String getEmail() {
    return email;
  }

  public void setEmail(String email) {
    this.email = email;
  }

  public String getPhoneNumber() {
    return phoneNumber;
  }

  public void setPhoneNumber(String phoneNumber) {
    this.phoneNumber = phoneNumber;
  }

  public String getDescription() {
    return description;
  }

  public void setDescription(String description) {
    this.description = description;
  }
}
