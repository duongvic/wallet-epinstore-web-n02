package vn.mog.ewallet.contract.customer;

import java.io.Serializable;

public class CustomerRequest extends CustomerRequestType implements Serializable {

  private static final long serialVersionUID = 1L;

  private String cif;
  private String username;
  private String email;
  private String msisdn;
  private String customerType;

  public String getCif() {
    return cif;
  }

  public void setCif(String cif) {
    this.cif = cif;
  }

  public String getUsername() {
    return username;
  }

  public void setUsername(String username) {
    this.username = username;
  }

  public String getEmail() {
    return email;
  }

  public void setEmail(String email) {
    this.email = email;
  }

  public String getMsisdn() {
    return msisdn;
  }

  public void setMsisdn(String msisdn) {
    this.msisdn = msisdn;
  }

  public String getCustomerType() {
    return customerType;
  }

  public void setCustomerType(String customerType) {
    this.customerType = customerType;
  }

}
