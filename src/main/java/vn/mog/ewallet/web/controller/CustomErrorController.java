package vn.mog.ewallet.web.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.boot.autoconfigure.web.ErrorController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by binhminh on 18/02/2017.
 */

@Controller
public class CustomErrorController extends AbstractController implements ErrorController {

  @RequestMapping(value = PATH_ERROR)
  public String error(HttpServletRequest request, HttpServletResponse response, ModelMap map) {

    if (HttpServletResponse.SC_UNAUTHORIZED == response.getStatus() || response.getStatus() == HttpServletResponse.SC_FORBIDDEN) {
      map.put("errorCode", HttpServletResponse.SC_UNAUTHORIZED);
    } else {
      map.put("errorCode", 0);
    }
    return "/config/error";
  }

  @Override
  public String getErrorPath() {
    return PATH_ERROR;
  }
}
