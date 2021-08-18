package vn.mog.ewallet.web.controller;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.CookieClearingLogoutHandler;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import vn.mog.ewallet.constant.SharedConstants;
import vn.mog.ewallet.web.controller.dashboard.DashBoardController;
import vn.mog.ewallet.web.controller.epin.CardController;
import vn.mog.ewallet.web.controller.po.ProfileProviderController;
import vn.mog.ewallet.web.controller.po.PurchaseOrderController;
import vn.mog.ewallet.web.controller.special.customer.SpecialAccountController;
import vn.mog.framework.common.utils.CookieUtil;

@Controller
public class MainController extends AbstractController {

  @GetMapping(value = "/")
  public String index(HttpServletRequest request) {

    String menu_click = CookieUtil.getCookieValue(request, "menu-click");
    if ("1".equalsIgnoreCase(menu_click)) {
      return String.format("redirect:%s", CardController.CARD_STORE_LIST);
    } else if ("2".equalsIgnoreCase(menu_click)) {
      return String.format("redirect:%s", PurchaseOrderController.PURCHASE_ORDER_LIST);
    } else if ("3".equalsIgnoreCase(menu_click)) {
      return String.format("redirect:%s", SpecialAccountController.SPECIAL_ACCOUNT_MANAGE_LIST);
    }else if ("4".equalsIgnoreCase(menu_click)) {
      return String.format("redirect:%s", ProfileProviderController.PROFILE_MANAGER_LIST);
    }
    return String.format("redirect:%s", DashBoardController.CARD_STORE_DASHBOAR);
  }

  @GetMapping(value = "/wallet")
  @PreAuthorize("isAuthenticated()")
  public String wallet() {
    return String.format("redirect:%s", redirectWalletRole());
  }

  @GetMapping(value = "/provider")
  @PreAuthorize("isAuthenticated()")
  public String provider() {
    return String.format("redirect:%s", redirectProviderRole());
  }

  @GetMapping(value = "/service")
  @PreAuthorize("isAuthenticated()")
  public String service() {
    return String.format("redirect:%s", redirectServiceRole());
  }

  @GetMapping(value = "/logout")
  public String logout(HttpServletRequest request, HttpServletResponse response, ModelMap map) {
    Cookie[] cookies = request.getCookies();
    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
    if (cookies != null) {
      List<String> cookieNames = Arrays.stream(cookies).map(Cookie::getName).collect(Collectors.toList());
      new CookieClearingLogoutHandler(cookieNames.toArray(new String[0])).logout(request, response, authentication);
    }
    new SecurityContextLogoutHandler().logout(request, response, authentication);
    return String.format("redirect:%s/logout?pre=%s", SharedConstants.WEB_DOMAIN_PLATFORM_UAA_URL, SharedConstants.WEB_DOMAIN_PLATFORM_OPERATION_SUBPATH_EPIN_STORE_N02_URL);
  }

  @GetMapping(value = "/common-error")
  public String notificationError(ModelMap model) {
    return "/config/error";
  }

  @GetMapping(value = "/not-found")
  public String notificationNotFound(ModelMap model) {
    return "/config/404";
  }

}
