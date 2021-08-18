package vn.mog.ewallet.web.filters;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.apache.logging.log4j.ThreadContext;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import vn.mog.framework.common.utils.Utils;

/**
 * Created by binhminh on 22/08/2017.
 */
public class LoggingInterceptor extends HandlerInterceptorAdapter {

  private static final Logger LOGGER = LogManager.getLogger(LoggingInterceptor.class);

  @Override
  public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

    try {
      final String ip = Utils.getIP((HttpServletRequest) request);
      ThreadContext.put("IP", ip);
      ThreadContext.put("IPAddress", ip);
    } catch (Exception e) {
      LOGGER.error(e.getMessage(), e);
    }
    return true;
  }

}
