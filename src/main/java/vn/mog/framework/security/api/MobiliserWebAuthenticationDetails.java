package vn.mog.framework.security.api;

import javax.servlet.http.HttpServletRequest;
import org.springframework.security.web.authentication.WebAuthenticationDetails;

public class MobiliserWebAuthenticationDetails extends WebAuthenticationDetails {

  private static final long serialVersionUID = 5840462824511978519L;
  private String userAgent;

  public MobiliserWebAuthenticationDetails(HttpServletRequest request) {
    super(request);

    this.userAgent = request.getHeader("User-Agent");
  }

  public String getUserAgent() {
    return this.userAgent;
  }
}
