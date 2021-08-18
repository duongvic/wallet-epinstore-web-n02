package vn.mog.ewallet.web.utils;

import java.util.Collections;
import java.util.Set;
import java.util.stream.Collectors;
import org.apache.log4j.Logger;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.provider.OAuth2Authentication;

/**
 * Created by binhminh on 04/10/2017.
 */
public class WebUtil {

  private static final Logger LOG = Logger.getLogger(WebUtil.class);

  public static Set<String> getRolesOfUserLogin() {
    try {
      Authentication auth = SecurityContextHolder.getContext().getAuthentication();
      if (auth != null && auth.isAuthenticated() && auth instanceof OAuth2Authentication) {
        return auth.getAuthorities().stream().map(GrantedAuthority::getAuthority).collect(Collectors.toSet());
      }
    } catch (ClassCastException e) {
      LOG.error(e.getMessage(), e);
    }
    return Collections.emptySet();
  }
}
