package vn.mog.ewallet.web.filters;

import java.io.IOException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.security.web.DefaultRedirectStrategy;

/**
 * Created by binhminh on 09/10/2017.
 */
public class CrlfFilteringRedirectStrategy extends DefaultRedirectStrategy {

  /**
   * @see DefaultRedirectStrategy#sendRedirect(HttpServletRequest, HttpServletResponse, String)
   */
  @Override
  public void sendRedirect(HttpServletRequest request, HttpServletResponse response, String url) throws IOException {
    String filteredUrl = url.replaceAll("\\n|\\r", "");
    super.sendRedirect(request, response, filteredUrl);
  }
}
