package vn.mog.ewallet.configuration;

import java.util.EnumSet;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.SessionTrackingMode;
import org.springframework.web.WebApplicationInitializer;

/**
 * Created by binhminh on 09/10/2017.
 */
public class WebApplicationConfiguration implements WebApplicationInitializer {

  @Override
  public void onStartup(ServletContext servletContext) throws ServletException {
    servletContext.setSessionTrackingModes(EnumSet.of(SessionTrackingMode.COOKIE));
  }
}
