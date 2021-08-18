package vn.mog.framework.common.utils;

import java.util.List;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;

public class CookieUtil {

  private static final Logger LOG = Logger.getLogger(CookieUtil.class);

  // The path the cookie will be available to, edit this to use a different
  // cookie path.
  private static final String COOKIE_PATH = "/";
  // Two years in seconds.
  private static final int COOKIE_USER_PERSISTENCE = 63072000;
  // cookie version
  private static final int COOKIE_VERSION = 1;

  public static boolean isVNXX(String str) {
    if (str == null) {
      return false;
    }
    for (int i = 0; i < str.length(); i++) {
      if (str.charAt(i) > 128) {
        return false;
      }
    }
    return true;
  }

  public static String getCookieValue(HttpServletRequest request, String name) {
    try {
      Cookie[] cookies = request.getCookies();
      if (cookies != null) {
        for (Cookie cookie : cookies) {
          if (cookie != null && name.equals(cookie.getName())) {
            return cookie.getValue();
          }
        }
      }
    } catch (Exception exp) {
      LOG.error(StringUtils.EMPTY, exp);
    }
    return null;
  }

  public static void setCookieValue(HttpServletResponse response, String name, String value, int maxAge) {
    try {
      maxAge = maxAge == Integer.MAX_VALUE ? COOKIE_USER_PERSISTENCE : maxAge;
      Cookie cookie = new Cookie(name, value);
      cookie.setVersion(COOKIE_VERSION);
      cookie.setMaxAge(maxAge);
      cookie.setPath(COOKIE_PATH);
      response.addCookie(cookie);
    } catch (Exception e) {
      LOG.error(StringUtils.EMPTY, e);
    }
  }

  public static void setCookieValue(HttpServletResponse response, String name, String value, int maxAge, String domain) {
    try {
      maxAge = maxAge == Integer.MAX_VALUE ? COOKIE_USER_PERSISTENCE : maxAge;
      Cookie cookie = new Cookie(name, value);
      cookie.setVersion(COOKIE_VERSION);
      cookie.setMaxAge(maxAge);
      cookie.setDomain(domain);
      cookie.setPath(COOKIE_PATH);
      response.addCookie(cookie);
    } catch (Exception e) {
      LOG.error(StringUtils.EMPTY, e);
    }
  }

  public static void removeCookie(HttpServletResponse response, String name) {
    setCookieValue(response, name, null, 0);
  }

  public static String implode(String[] ary, String delim) {
    StringBuilder out = new StringBuilder();
    for (int i = 0; i < ary.length; i++) {
      if (i != 0) {
        out.append(delim);
      }
      out.append(ary[i]);
    }
    return out.toString();
  }

  public static void cleanCookie(HttpServletRequest request, HttpServletResponse response, List<String> cookiesToClear) {
    for (String cookieName : cookiesToClear) {
      Cookie cookie = new Cookie(cookieName, null);
      String cookiePath = request.getContextPath() + "/";
      if (!org.springframework.util.StringUtils.hasLength(cookiePath)) {
        cookiePath = "/";
      }
      cookie.setPath(cookiePath);
      cookie.setMaxAge(0);
      response.addCookie(cookie);
    }
  }

  public static void cleanCookie(HttpServletRequest request, HttpServletResponse response) {
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
      for (Cookie cookieName : cookies) {
        Cookie cookie = new Cookie(cookieName.getName(), null);
        String cookiePath = request.getContextPath() + "/";
        if (!org.springframework.util.StringUtils.hasLength(cookiePath)) {
          cookiePath = "/";
        }
        cookie.setPath(cookiePath);
        cookie.setMaxAge(0);
        response.addCookie(cookie);
      }
    }
  }
}
