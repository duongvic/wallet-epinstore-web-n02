package vn.mog.ewallet.web.controller;

import static vn.mog.ewallet.constant.RoleConstants.ACCOUNTING;
import static vn.mog.ewallet.constant.RoleConstants.ACCOUNTING_LEADER;
import static vn.mog.ewallet.constant.RoleConstants.ADMIN_OPERATION;
import static vn.mog.ewallet.constant.RoleConstants.AGENT;
import static vn.mog.ewallet.constant.RoleConstants.AGGREATOR;
import static vn.mog.ewallet.constant.RoleConstants.BILLER;
import static vn.mog.ewallet.constant.RoleConstants.CUSTOMER;
import static vn.mog.ewallet.constant.RoleConstants.CUSTOMERCARE_MANAGER;
import static vn.mog.ewallet.constant.RoleConstants.FA_MANAGER;
import static vn.mog.ewallet.constant.RoleConstants.FINANCE;
import static vn.mog.ewallet.constant.RoleConstants.FINANCE_LEADER;
import static vn.mog.ewallet.constant.RoleConstants.MERCHANT;
import static vn.mog.ewallet.constant.RoleConstants.RECONCILIATION;
import static vn.mog.ewallet.constant.RoleConstants.RECONCILIATION_LEADER;
import static vn.mog.ewallet.constant.RoleConstants.SALESUPPORT;
import static vn.mog.ewallet.constant.RoleConstants.SALESUPPORT_LEADER;
import static vn.mog.ewallet.constant.RoleConstants.SALESUPPORT_MANAGER;
import static vn.mog.ewallet.constant.RoleConstants.SALE_ASM;
import static vn.mog.ewallet.constant.RoleConstants.SALE_DIRECTOR;
import static vn.mog.ewallet.constant.RoleConstants.SALE_EXCUTIVE;
import static vn.mog.ewallet.constant.RoleConstants.TECH_SUPPORT;
import static vn.mog.ewallet.constant.RoleConstants.TELCO;
import static vn.mog.ewallet.web.contract.UrlIntergration.FUND_IN_HISTORY_LIST;
import static vn.mog.ewallet.web.contract.UrlIntergration.FUND_IN_ORDER_LIST;
import static vn.mog.ewallet.web.contract.UrlIntergration.PROVIDER_LIST;
import static vn.mog.ewallet.web.contract.UrlIntergration.TRANSACTION_LIST;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Set;
import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.servlet.resource.ResourceUrlProvider;
import vn.mog.ewallet.services.epin.store.IEpinStoreEndpoint;
import vn.mog.ewallet.web.utils.ValidationUtil;
import vn.mog.ewallet.web.utils.WebUtil;
import vn.mog.framework.common.utils.DateUtil;
import vn.mog.framework.security.api.ICallerUtils;

public abstract class AbstractController {

  public static final String PATH_ERROR = "/error";
  private static final Logger LOG = Logger.getLogger(AbstractController.class);
  @Autowired
  protected ICallerUtils callerUtil;

  @Autowired
  protected IEpinStoreEndpoint epinStoreEndpoint;
  @Autowired
  protected ValidationUtil validation;

  @Autowired
  ResourceUrlProvider resourceUrlProvider;

  @ModelAttribute("urls")
  public ResourceUrlProvider urls() {
    return this.resourceUrlProvider;
  }

  protected String redirectWalletRole() {
    Set<String> roles = WebUtil.getRolesOfUserLogin();

    boolean isAdmin = roles.contains(ADMIN_OPERATION);
    boolean isFinance = roles.contains(FINANCE) || roles.contains(FINANCE_LEADER) || roles.contains(FA_MANAGER);
    boolean isPlusCustomer = roles.contains(MERCHANT) || roles.contains(AGENT) || roles.contains(CUSTOMER) || roles.contains(TELCO)
        || roles.contains(AGGREATOR) || roles.contains(BILLER);

    if (isFinance || isAdmin) {
      return FUND_IN_ORDER_LIST + "?menu=wal";

    } else if (isPlusCustomer) {
      return FUND_IN_HISTORY_LIST + "?menu=wal";

    } else {
      return TRANSACTION_LIST + "?menu=ser";
    }
  }

  protected String redirectProviderRole() {
    Set<String> roles = WebUtil.getRolesOfUserLogin();

    boolean isAdmin = roles.contains(ADMIN_OPERATION);
    boolean isSaleSupport = roles.contains(SALESUPPORT_MANAGER) || roles.contains(SALESUPPORT_LEADER) || roles.contains(SALESUPPORT);

    if (isSaleSupport || isAdmin) {
      return PROVIDER_LIST + "?menu=pro";

    } else {
      return TRANSACTION_LIST + "?menu=ser";
    }
  }

  protected String redirectServiceRole() {
    Set<String> roles = WebUtil.getRolesOfUserLogin();

    boolean isDefault = roles.contains(ADMIN_OPERATION) || roles.contains(SALE_DIRECTOR) || roles.contains(SALE_ASM);
    boolean isReconciliation = roles.contains(RECONCILIATION) || roles.contains(RECONCILIATION_LEADER) || roles.contains(ACCOUNTING)
        || roles.contains(ACCOUNTING_LEADER);
    boolean isBusinessOperation = roles.contains(CUSTOMERCARE_MANAGER) || roles.contains(SALE_EXCUTIVE) || roles.contains(TECH_SUPPORT);

    if (isDefault || isBusinessOperation || isReconciliation) {
      return TRANSACTION_LIST + "?menu=ser";

    } else {
      return TRANSACTION_LIST + "?menu=ser";
    }
  }

  public Date[] parseDateRange(String dateRange, boolean isDefaultFulltime) {
    try {
      Date currentDate = new Date();
      if (StringUtils.isNotBlank(dateRange)) {
        String fulltime = validation.notify("daterange.locale.fulltime.nosign");
        if (fulltime.equals(dateRange)) {
          return new Date[]{null, null};
        } else {
          String[] range = dateRange.split("-");
          DateFormat df = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
          Date fromDate = df.parse(StringUtils.trimToEmpty(range[0]));
          Date endDate = df.parse(StringUtils.trimToEmpty(range[1]));
          return new Date[]{fromDate, endDate};
        }
      } else if (StringUtils.isBlank(dateRange) && isDefaultFulltime) {
        return new Date[]{null, null};
      } else {
        return new Date[]{DateUtil.getStartOfDay(currentDate), DateUtil.getEndOfDay(currentDate)};
      }
    } catch (Exception e) {
      LOG.error(e.getMessage(), e);
    }
    return new Date[]{null, null};
  }
}
