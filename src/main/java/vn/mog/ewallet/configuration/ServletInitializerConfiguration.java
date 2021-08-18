package vn.mog.ewallet.configuration;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.support.SpringBootServletInitializer;
import vn.mog.ewallet.StartApplication;

public class ServletInitializerConfiguration extends SpringBootServletInitializer {

  public ServletInitializerConfiguration() {
    super();
    //setRegisterErrorPageFilter(false); // <- this one
  }

  @Override
  protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
    return builder.sources(StartApplication.class);
  }

  @Override
  public void onStartup(ServletContext servletContext) throws ServletException {
    super.onStartup(servletContext);
    servletContext.setInitParameter("defaultHtmlEscape", "true");
  }
}