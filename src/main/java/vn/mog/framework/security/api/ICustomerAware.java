package vn.mog.framework.security.api;

import java.security.Principal;
import org.springframework.security.core.Authentication;

public interface ICustomerAware extends Principal {

  static ICustomerAware from(Principal principal) {

    if (principal instanceof Authentication) {
      Object p = ((Authentication) principal).getPrincipal();
      if (p instanceof ICustomerAware) {
        return (ICustomerAware) p;
      }
    }
    if (principal instanceof ICustomerAware) {
      return (ICustomerAware) principal;
    }
    return null;
  }

  Long getId();

  void setId(Long id);

  String getCif();

  void setCif(String cif);

  String getUsername();

  void setUsername(String username);

  String getFullname();

  void setFullname(String fullname);

  String getEmail();

  void setEmail(String email);

  String getPhone();

  void setPhone(String phone);

  Integer getType();

  void setType(Integer type);

  boolean isVerifiedEmail();

  void setVerifiedEmail(boolean verified);

  boolean isVerifiedPhone();

  void setVerifiedPhone(boolean verified);
}
