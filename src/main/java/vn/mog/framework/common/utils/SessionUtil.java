package vn.mog.framework.common.utils;

import java.util.Enumeration;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;

public class SessionUtil {

  private static final Logger LOG = Logger.getLogger(SessionUtil.class);

  /***
   * Xóa session
   */
  public static void cleanSession(HttpServletRequest request) {
    try {
      HttpSession session = request.getSession();
      Enumeration<?> attrNames = session.getAttributeNames();
      while (attrNames.hasMoreElements()) {
        session.removeAttribute((String) attrNames.nextElement());
      }
      request.getSession().invalidate();
    } catch (Exception e) {
      LOG.error("cleanSession", e);
    }
  }

  public static void setObjectToSession(HttpServletRequest request, String name, Object object) {
    try {
      if (object != null) {
        request.getSession().setAttribute(name, object);
      }
    } catch (Exception e) {
      LOG.error("setSession", e);
    }
  }

  public static Object getObjectFromSession(HttpServletRequest request, String name) {
    try {
      if (StringUtils.isNotEmpty(name)) {
        return request.getSession().getAttribute(name);
      }
    } catch (Exception e) {
      LOG.error("getObjectFromSession", e);
    }
    return null;
  }

  public static Object getAttribute(String name) {
    try {
      if (StringUtils.isNotEmpty(name)) {
        return HttpUtil.getCurrentHttpServletRequest().getSession().getAttribute(name);
      }
    } catch (Exception e) {
      LOG.error("getObjectFromSession", e);
    }
    return null;
  }

  public static Object removeAttribute(String name) {
    try {
      if (StringUtils.isNotEmpty(name)) {
        HttpUtil.getCurrentHttpServletRequest().getSession().removeAttribute(name);
      }
    } catch (Exception e) {
      LOG.error("getObjectFromSession", e);
    }
    return null;
  }

  public static void setAttribute(String attribute, Object object) {
    if (StringUtils.isNotEmpty(attribute) && object != null) {
      HttpUtil.getCurrentHttpServletRequest().getSession().setAttribute(attribute, object);
    }
  }

  public static boolean hasSession(HttpServletRequest request, String sessionName) {
    try {
      HttpSession session = request.getSession();
      String name = StringUtils.trimToEmpty(sessionName);
      if (StringUtils.isNotBlank(name) && session.getAttribute(name) != null) {
        return true;
      }
    } catch (Exception e) {
      LOG.error("hasSession", e);
    }
    return false;
  }

}
