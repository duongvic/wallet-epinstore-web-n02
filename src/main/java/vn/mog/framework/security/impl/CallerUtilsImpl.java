package vn.mog.framework.security.impl;

import java.util.ArrayList;
import java.util.List;
import org.apache.commons.lang3.StringUtils;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.provider.authentication.OAuth2AuthenticationDetails;
import org.springframework.stereotype.Service;
import vn.mog.framework.common.utils.Utils;
import vn.mog.framework.security.api.CallerInformation;
import vn.mog.framework.security.api.ICallerUtils;
import vn.mog.framework.security.api.ICustomerAware;
import vn.mog.framework.security.api.MobiliserWebAuthenticationDetails;

@Service
public class CallerUtilsImpl implements ICallerUtils {

  @Override
  public long getCallerId() {
    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

    if (authentication == null) {
      throw new IllegalArgumentException("No authentication object found in security context. Check configuration?");
    }

    return getActorId(authentication);
  }

  @Override
  public CallerInformation getCallerInformation() {
    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

    if (authentication == null) {
      throw new IllegalArgumentException("No authentication object found in security context. Check configuration?");
    }

    String accessToken = getAccessToken(authentication);
    Long actorId = Long.valueOf(getActorId(authentication));
    String actorCif = getActorCif(authentication);
    String actorIdentifier = getActorIdentifier(authentication);
    int actorType = getActorType(authentication);

    List<String> actorPrivs = new ArrayList<>();

    for (GrantedAuthority grantedAuth : authentication.getAuthorities()) {
      actorPrivs.add(grantedAuth.getAuthority());
    }

    Object authDetails = authentication.getDetails();
    String userAgent;
    String ip;
    if (authDetails instanceof MobiliserWebAuthenticationDetails) {
      ip = ((MobiliserWebAuthenticationDetails) authDetails).getRemoteAddress();
      userAgent = ((MobiliserWebAuthenticationDetails) authDetails).getUserAgent();
    } else {
      ip = null;
      userAgent = null;
    }

    return new CallerInformation(accessToken, actorId, actorCif, actorType, actorIdentifier, actorPrivs, ip, userAgent);
  }

  @Override
  public boolean hasPrivilege(final String privilege) {
    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
    if (authentication == null) {
      throw new IllegalArgumentException("No authentication object found in security context. Check configuration?");
    }

    final String prefix = "ROLE_";
    String strPrivilege = privilege.toUpperCase().trim();
    if (!strPrivilege.startsWith(prefix)) {
      strPrivilege = prefix + strPrivilege;
    }

    for (GrantedAuthority grantedAuth : authentication.getAuthorities()) {
      if (StringUtils.equals(strPrivilege, grantedAuth.getAuthority())
          || StringUtils.equals(strPrivilege.replace(prefix, ""), grantedAuth.getAuthority())) {
        return true;
      }
    }

    return false;
  }

  private String getAccessToken(Authentication authentication) {
    Object details = authentication.getDetails();
    if (details instanceof OAuth2AuthenticationDetails) {
      return ((OAuth2AuthenticationDetails) details).getTokenValue();
    }
    System.out.println(Utils.objectToJson(authentication.getCredentials()));
    return authentication.getCredentials().toString();
  }

  private long getActorId(Authentication authentication) {
    Object principal = authentication.getPrincipal();
    if (principal instanceof ICustomerAware) {
      return ((ICustomerAware) principal).getId();
    }
    return 0L;
  }

  private String getActorCif(Authentication authentication) {
    Object principal = authentication.getPrincipal();
    if (principal instanceof ICustomerAware) {
      return ((ICustomerAware) principal).getCif();
    }
    return null;
  }

  private String getActorIdentifier(Authentication authentication) {
    Object principal = authentication.getPrincipal();
    if (principal instanceof ICustomerAware) {
      return ((ICustomerAware) principal).getUsername();
    }
    return authentication.getName();
  }

  private int getActorType(Authentication authentication) {
    Object principal = authentication.getPrincipal();
    if (principal instanceof ICustomerAware) {
      return ((ICustomerAware) principal).getType();
    }
    return 0;
  }
}
