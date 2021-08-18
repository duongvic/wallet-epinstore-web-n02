package vn.mog.ewallet.web.contract;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

/**
 * Created by binhminh on 11/08/2017.
 */
@Service
public class UrlIntergration {

  /* ------------------PROVIDER--------------- */
  public static final String PROVIDER_TAB = "/provider/provider-profile/list";

  /* ------------------WALLET--------------- */
  public static final String WALLET_TAB = "/wallet/transaction/user/all/list";
  public static final String FUND_IN_HISTORY_LIST = "/wallet/fund-in-history/list";

  /* ------------------SERVICE--------------- */
  public static final String SERVICE_TAB = "/service/transaction-history/list";
  // public static final String DASHBOARD_LIST = "/dashboard/index";
  public static final String FUND_IN_ORDER_LIST = "/wallet/fund-in/list";
  public static final String TRANSACTION_LIST = "/service/transaction-history/list";
  public static final String PROVIDER_LIST = "/provider/provider-profile/list";

  public static String SUBPATH_BILLPAY_URL = StringUtils.EMPTY;
  /* ------------------CUSTOMER--------------- */
  public static String SUBPATH_CUSTOMER_URL = StringUtils.EMPTY;
  /* ------------------OPERATION--------------- */
  public static String SUBPATH_OPERATION_URL = StringUtils.EMPTY;
  /* ------------------SETTING--------------- */
  public static String SUBPATH_SETTING_URL = StringUtils.EMPTY;

  @Value("${web.domain.platform.operation.subpath.billpay.url}")
  public void setAgentURIBillpayTab(String value) {
    SUBPATH_BILLPAY_URL = value;
  }

  @Value("${web.domain.platform.operation.subpath.customer.url}")
  public void setAgentURICustomerTab(String value) {
    SUBPATH_CUSTOMER_URL = value;
  }

  @Value("${web.domain.platform.operation.subpath.operation.url}")
  public void setAgentURIOperationTab(String value) {
    SUBPATH_OPERATION_URL = value;
  }

  @Value("${web.domain.platform.operation.subpath.setting.url}")
  public void setAgentURISettingTab(String value) {
    SUBPATH_SETTING_URL = value;
  }

}
