package vn.mog.ewallet.web.filters;

import static vn.mog.ewallet.constant.RoleConstants.ADMIN_OPERATION;
import static vn.mog.ewallet.constant.RoleConstants.ADMIN_SYSTEM;
import static vn.mog.ewallet.constant.RoleConstants.FA_MANAGER;
import static vn.mog.ewallet.constant.RoleConstants.FINANCE;
import static vn.mog.ewallet.constant.RoleConstants.FINANCESUPPORT_LEADER;
import static vn.mog.ewallet.constant.RoleConstants.FINANCE_LEADER;
import static vn.mog.ewallet.constant.RoleConstants.FINANCE_SUPPORT;
import static vn.mog.ewallet.constant.RoleConstants.SALESUPPORT;
import static vn.mog.ewallet.constant.RoleConstants.SALESUPPORT_MANAGER;
import static vn.mog.ewallet.constant.SessionConstants.SESSION_ACCESS_TOKEN;
import static vn.mog.ewallet.constant.SessionConstants.SESSION_ACCOUNT_LOGIN;
import static vn.mog.ewallet.exception.MessageNotify.SESSION_MESSAGE_NOTIFY;

import java.io.IOException;
import java.util.Set;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.provider.OAuth2Authentication;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import vn.mog.ewallet.constant.SharedConstants;
import vn.mog.ewallet.exception.FrontEndException;
import vn.mog.ewallet.exception.MessageNotify;
import vn.mog.ewallet.services.walletservice.IWaletServiceEndpoint;
import vn.mog.ewallet.web.contract.UserLogin;
import vn.mog.ewallet.web.controller.AbstractController;
import vn.mog.ewallet.web.controller.dashboard.DashBoardController;
import vn.mog.ewallet.web.controller.epin.CardController;
import vn.mog.ewallet.web.controller.po.PurchaseOrderController;
import vn.mog.ewallet.web.controller.special.customer.SpecialAccountController;
import vn.mog.ewallet.web.utils.WebUtil;
import vn.mog.framework.common.utils.SessionUtil;
import vn.mog.framework.security.api.CallerInformation;
import vn.mog.framework.security.api.ICallerUtils;

/**
 * Created by binhminh on 22/08/2017.
 */
public class AuthenticationInterceptor extends HandlerInterceptorAdapter {


  private static final Logger LOG = Logger.getLogger(AuthenticationInterceptor.class);

  @Autowired
  protected IWaletServiceEndpoint walletEndpoint;

  @Autowired
  ICallerUtils callerUtil;

  @Override
  public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
      throws IOException, FrontEndException {

    String requestURI = request.getRequestURI();

    // TODO, Cần xử lý business chỗ này, /error với lõi authenzied
    LOG.debug("--preHandle--RequestURI--" + requestURI);

    int status = response.getStatus();

    if (AbstractController.PATH_ERROR.equals(requestURI)) {
      if (status == HttpServletResponse.SC_UNAUTHORIZED
          || status == HttpServletResponse.SC_FORBIDDEN) {
        request.setAttribute("errorCode", HttpServletResponse.SC_UNAUTHORIZED);
      } else {
        request.setAttribute("errorCode", 0);
      }
      return true;
    }

    // your logic
    Authentication au = SecurityContextHolder.getContext().getAuthentication();
    boolean isAuthen = au != null && au.isAuthenticated() && au instanceof OAuth2Authentication;

    try {
      if (isAuthen) {
        initAttributeToRequest(request);
        return true;
      }
    } catch (Exception e) {
      LOG.error(e.getMessage(), e);
    }
    new SecurityContextLogoutHandler().logout(request, response, au);
    response
        .sendRedirect(SharedConstants.WEB_DOMAIN_PLATFORM_OPERATION_SUBPATH_EPIN_STORE_N02_LOGIN_URL);
    return false;
  }

  @Override
  public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
      ModelAndView modelAndView) throws Exception {
    if (modelAndView == null) {
      return;
    }
    if ("GET".equalsIgnoreCase(request.getMethod())) {
      MessageNotify message = (MessageNotify) SessionUtil.getAttribute(SESSION_MESSAGE_NOTIFY);
      if (message != null) {
        modelAndView.addObject(MessageNotify.codeErr, message.getCode());
        modelAndView.addObject(MessageNotify.mesErr, message.getMessage());
        SessionUtil.removeAttribute(SESSION_MESSAGE_NOTIFY);
      }

      String requestURI = request.getRequestURI();
      String menu = (String) SessionUtil.getAttribute("menu");
      if (requestURI.contains(DashBoardController.CARD_STORE_DASHBOAR) ||
          requestURI.contains(CardController.CARD_STORE_LIST) ||
          requestURI.contains(PurchaseOrderController.PURCHASE_ORDER_LIST) ||
          requestURI.contains(SpecialAccountController.SPECIAL_ACCOUNT_MANAGE_LIST)) {
        menu = (String) SessionUtil.getAttribute("menu");
        if (!"all".equals(menu)) {
          modelAndView.addObject("menu", "pro");
          SessionUtil.setAttribute("menu", "pro");
        }
      }

      if (requestURI.contains("menu=")) {
        modelAndView.addObject("uri_all", requestURI.replace("menu=" + menu, "menu=all"));
      } else if (requestURI.contains("?")) {
        modelAndView.addObject("uri_all", requestURI + "&menu=all");
      } else {
        modelAndView.addObject("uri_all", requestURI + "?menu=all");
      }

    } else {
      modelAndView.addObject("uri_all", "#");
    }

  }

  private void initAttributeToRequest(HttpServletRequest request) {
    try {
      long balance = 0;
      Set<String> role = WebUtil.getRolesOfUserLogin();

      boolean roleNotExistBalance =
          role.contains(ADMIN_OPERATION) || role.contains(ADMIN_SYSTEM) || role
              .contains(FA_MANAGER) || role.contains(FINANCE_LEADER) || role
              .contains(FINANCESUPPORT_LEADER) || role.contains(FINANCE_SUPPORT) || role
              .contains(FINANCE) || role.contains(SALESUPPORT_MANAGER) || role
              .contains(SALESUPPORT);
      if (!roleNotExistBalance) {
        balance = walletEndpoint.getBalance();
      }

      CallerInformation callerInformation = callerUtil.getCallerInformation();
      SessionUtil.setAttribute(SESSION_ACCESS_TOKEN, callerInformation.getAccessToken());
      SessionUtil.setAttribute(SESSION_ACCOUNT_LOGIN, new UserLogin(callerInformation, balance));

      String menu = request.getParameter("menu");
      request.setAttribute("menu", menu);
      if (StringUtils.isNotEmpty(menu)) {
        SessionUtil.setAttribute("menu", menu);
      }
    } catch (Exception ex) {
      LOG.error(ex.getMessage());
    }

  }
}
