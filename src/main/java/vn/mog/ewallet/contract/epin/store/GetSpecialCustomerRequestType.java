package vn.mog.ewallet.contract.epin.store;

import vn.mog.framework.contract.base.MobiliserRequestType;

public class GetSpecialCustomerRequestType extends MobiliserRequestType {

  private Long id;

  private String cif;

  private Boolean isActive;

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

  public Boolean getIsActive() {
    return isActive;
  }

  public void setIsActive(Boolean active) {
    isActive = active;
  }
}
