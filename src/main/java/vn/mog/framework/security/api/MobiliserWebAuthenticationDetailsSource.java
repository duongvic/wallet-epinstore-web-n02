package vn.mog.framework.security.api;

import javax.servlet.http.HttpServletRequest;
import org.springframework.security.authentication.AuthenticationDetailsSource;

public class MobiliserWebAuthenticationDetailsSource implements AuthenticationDetailsSource<HttpServletRequest, MobiliserWebAuthenticationDetails> {

  public MobiliserWebAuthenticationDetails buildDetails(HttpServletRequest context) {
    return new MobiliserWebAuthenticationDetails(context);
  }
}
