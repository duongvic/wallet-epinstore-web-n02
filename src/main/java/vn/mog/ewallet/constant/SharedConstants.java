package vn.mog.ewallet.constant;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

@Service
public class SharedConstants {

  public static String WEB_DOMAIN_PLATFORM_UAA_URL = StringUtils.EMPTY;
  public static String WEB_DOMAIN_PLATFORM_OPERATION_URL = StringUtils.EMPTY;
  public static String WEB_DOMAIN_PLATFORM_OPERATION_SUBPATH_EPIN_STORE_N02_URL = StringUtils.EMPTY;
  public static String WEB_DOMAIN_PLATFORM_OPERATION_SUBPATH_EPIN_STORE_N02_LOGIN_URL = StringUtils.EMPTY;
  public static String WEB_DOMAIN_PLATFORM_OPERATION_SUBPATH_EPIN_STORE_URL = StringUtils.EMPTY;
  public static String WEB_DOMAIN_PLATFORM_OPERATION_SUBPATH_EPIN_STORE_OFFLINE_URL = StringUtils.EMPTY;

  public static String PLATFORM_BACKEND_EPINSTORE_SERVICE_API_ENDPOINT = StringUtils.EMPTY;

  public static int HTTP_CLIENT_CONNECT_TIMEOUT = 60000;// ms
  public static int HTTP_CLIENT_SOCKET_TIMEOUT = 900000;// ms
  public static int HTTP_DEFAULT_MAX_CONNECTIONS_PER_HOST = 100;
  public static int HTTP_MAX_TOTAL_CONNECTIONS = 5000;

  public static int NEAR_EXP_DAYS = 15;

  @Value("${web.domain.platform.uaa.url}")
  public void setWebDomainPlatformUAAUrl(String value) {
    WEB_DOMAIN_PLATFORM_UAA_URL = value;
  }

  @Value("${web.domain.platform.operation.url}")
  public void setWebDomainPlatformOperationUrl(String value) {
    WEB_DOMAIN_PLATFORM_OPERATION_URL = value;
  }

  @Value("${web.domain.platform.operation.subpath.epinstore.n02.url}")
  public void setWebDomainPlatformOperationSubpathEpinStoreLoginUrl(String value) {
    WEB_DOMAIN_PLATFORM_OPERATION_SUBPATH_EPIN_STORE_N02_LOGIN_URL = value + "/login";
  }

  @Value("${web.domain.platform.operation.subpath.epinstore.url}")
  public void setWebDomainPlatformOperationSubpathEpinStoreN02Url(String value) {
    WEB_DOMAIN_PLATFORM_OPERATION_SUBPATH_EPIN_STORE_URL = value;
  }

  @Value("${web.domain.platform.operation.subpath.epinstore.n02.url}")
  public void setWebDomainPlatformOperationSubpathEpinStoreUrl(String value) {
    WEB_DOMAIN_PLATFORM_OPERATION_SUBPATH_EPIN_STORE_N02_URL = value;
  }

  @Value("${web.domain.platform.operation.subpath.epinstore.offline.url}")
  public void setCardStoreOfflineWebRequestUrl(String value) {
    WEB_DOMAIN_PLATFORM_OPERATION_SUBPATH_EPIN_STORE_OFFLINE_URL = value;
  }

  @Value("${platform.backend.epinstore.service.api.endpoint}")
  public void setPlatformEpinStoreServiceApiEndpoint(String value) {
    PLATFORM_BACKEND_EPINSTORE_SERVICE_API_ENDPOINT = value;
  }

  @Value("${card.dashboard.near.expiration.day}")
  public void setCardDashBoardNearExpDays(int value) {
    NEAR_EXP_DAYS = value;
  }

  /* ------------Show Card Store Off Line---------------*/
  public static String MENU_ITEM_SHOW_CARD_STORE_OFF_LINE = StringUtils.EMPTY;
  @Value("${menu.item.card.store.off.line.show.info}")
  public void setMenuItemShowCardStoreOffLine(String value) {
    MENU_ITEM_SHOW_CARD_STORE_OFF_LINE = value;
  }
}
