package vn.mog.framework.security.impl;

import java.util.Map;
import vn.mog.framework.security.api.ICustomerAware;

public class CustomerAwareConvertor {

  public static void fromMap(Map<String, ?> map, ICustomerAware user) {
    user.setId(((Number) map.get("id")).longValue());
    user.setCif((String) map.get("cif"));
    user.setEmail((String) map.get("email"));
    Object verifiedEmail = map.get("verified_email");
    user.setVerifiedEmail(verifiedEmail != null ? (Boolean) verifiedEmail : Boolean.FALSE);
    user.setPhone((String) map.get("phone"));
    Object verifiedPhone = map.get("verified_phone");
    user.setVerifiedPhone(verifiedPhone != null ? (Boolean) verifiedPhone : Boolean.FALSE);
    user.setFullname((String) map.get("fullname"));
    user.setType(((Number) map.get("type")).intValue());

  }

  public static void toMap(ICustomerAware user, Map<String, Object> map) {
    map.put("id", user.getId());
    map.put("cif", user.getCif());
    if (user.getEmail() != null) {
      map.put("email", user.getEmail());
      map.put("verified_email", user.isVerifiedEmail());
    }
    if (user.getPhone() != null) {
      map.put("phone", user.getPhone());
      map.put("verified_phone", user.isVerifiedPhone());
    }
    map.put("fullname", user.getFullname());
    map.put("type", user.getType());
  }
}
