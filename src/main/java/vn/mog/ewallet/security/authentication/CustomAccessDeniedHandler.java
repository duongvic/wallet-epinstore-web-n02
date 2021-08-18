package vn.mog.ewallet.security.authentication;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.stereotype.Component;
import vn.mog.ewallet.web.controller.AbstractController;

@Component
public class CustomAccessDeniedHandler implements AccessDeniedHandler {

  private static Logger LOGGER = Logger.getLogger(CustomAccessDeniedHandler.class);

  @Override
  public void handle(HttpServletRequest request, HttpServletResponse response, AccessDeniedException arg2) throws IOException, ServletException {

    LOGGER.info(String.format("### AccessDeniedHandler: URL [%s] ", request.getServletPath()));
    request.getRequestDispatcher(AbstractController.PATH_ERROR).forward(request, response);
  }
}
