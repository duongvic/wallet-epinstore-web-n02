package vn.mog.ewallet.web.contract;

import java.io.Serializable;
import java.util.Set;
import java.util.stream.Collectors;
import vn.mog.framework.security.api.CallerInformation;

public class UserLogin implements Serializable {

  private String accessToken;
  private String username;
  private Long customerId;
  private String customerCif;
  private Integer customerTypeId;
  private Long balance;

  private Set<String> roles;
  private Set<String> privileges;

  public UserLogin() {
  }

  public UserLogin(long balance) {
    this.balance = balance;
  }

  public UserLogin(CallerInformation callerInformation, long balance) {
    this.accessToken = callerInformation.getAccessToken();
    this.username = callerInformation.getActorIdentifier();
    this.customerId = callerInformation.getActorId();
    this.customerCif = callerInformation.getActorCif();
    this.customerTypeId = callerInformation.getActorType();
    this.roles = callerInformation.getActorPrivs().stream().collect(Collectors.toSet());
    this.balance = balance;
    // this.privileges = jwtUser.getPrivileges();
  }

  public Long getBalance() {
    if (balance == null) {
      balance = 0L;
    }
    return balance;
  }

  public void setBalance(Long balance) {
    this.balance = balance;
  }

  public String getUsername() {
    return username;
  }

  public void setUsername(String username) {
    this.username = username;
  }

  public Long getCustomerId() {
    return customerId;
  }

  public void setCustomerId(Long customerId) {
    this.customerId = customerId;
  }

  public String getCustomerCif() {
    return customerCif;
  }

  public void setCustomerCif(String customerCif) {
    this.customerCif = customerCif;
  }

  public int getCustomerTypeId() {
    return customerTypeId;
  }

  public void setCustomerTypeId(int customerTypeId) {
    this.customerTypeId = customerTypeId;
  }

  public void setCustomerTypeId(Integer customerTypeId) {
    this.customerTypeId = customerTypeId;
  }

  public Set<String> getRoles() {
    return roles;
  }

  public void setRoles(Set<String> roles) {
    this.roles = roles;
  }

  public Set<String> getPrivileges() {
    return privileges;
  }

  public void setPrivileges(Set<String> privileges) {
    this.privileges = privileges;
  }

  public String getAccessToken() {
    return accessToken;
  }

  public void setAccessToken(String accessToken) {
    this.accessToken = accessToken;
  }
}
