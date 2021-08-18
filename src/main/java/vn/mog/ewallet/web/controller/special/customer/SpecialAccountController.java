package vn.mog.ewallet.web.controller.special.customer;

import static vn.mog.ewallet.constant.RoleConstants.ADMIN_OPERATION;
import static vn.mog.ewallet.constant.RoleConstants.SALESUPPORT_MANAGER;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import vn.mog.ewallet.contract.epin.store.AddOrUpdateSpecialCustomerRequest;
import vn.mog.ewallet.contract.epin.store.AddOrUpdateSpecialCustomerResponse;
import vn.mog.ewallet.contract.epin.store.GetSpecialCustomerRequest;
import vn.mog.ewallet.contract.epin.store.GetSpecialCustomerResponse;
import vn.mog.ewallet.contract.epin.store.beans.SpecialCustomerItem;
import vn.mog.ewallet.exception.FrontEndException;
import vn.mog.ewallet.web.controller.AbstractController;
import vn.mog.framework.common.utils.SessionUtil;

@Controller
@RequestMapping(value = "/provider/special-account/manage")
public class SpecialAccountController extends AbstractController {

  private static final Logger LOG = LogManager.getLogger(SpecialAccountController.class);

  public static final String SPECIAL_ACCOUNT_MANAGE_CONTROLLER = "/provider/special-account/manage";
  public static final String SPECIAL_ACCOUNT_MANAGE_LIST =
      SPECIAL_ACCOUNT_MANAGE_CONTROLLER + "/list";
  public static final String SPECIAL_ACCOUNT_MANAGE_DETAIL =
      SPECIAL_ACCOUNT_MANAGE_CONTROLLER + "/details";
  public static final String SYSTEM_WALLET = "SYSTEM_WALLET";

  private static final String REDIRECT_WALLET_ACCOUNT_MANAGE_ADD =
      SPECIAL_ACCOUNT_MANAGE_CONTROLLER + "/add";

  private static final String PAGE_EDIT_ACCOUNT = "/special_account_manage/edit_account";
  private static final String PAGE_LIST_ACCOUNT = "/special_account_manage/list";

  private String codeErr;
  private SpecialCustomerItem mCustomer;

  private static final String MESERR_RQP = "mesErr";
  private static final String CODEERR_RQP = "codeErr";
  private static final String ACCOUNT_OBJECT_RQP = "account_object";
  private static final String EDIT_TYPE_RQP = "edit_type";

  private static final String ACCOUNT_OBJECT_ATTRIBUTE = "ACCOUNT_OBJECT";

  @GetMapping(value = "/list")
  public String list(HttpServletRequest request, HttpServletResponse response, ModelMap map)
      throws FrontEndException {

    return PAGE_LIST_ACCOUNT;
  }

  @GetMapping(value = "/add")
  @PreAuthorize("hasAnyRole('" + ADMIN_OPERATION + "' ,'" + SALESUPPORT_MANAGER + "')")
  public String addAccount(HttpServletRequest request, HttpServletResponse response, ModelMap map)
      throws FrontEndException {

    map.put(CODEERR_RQP, codeErr);
    map.put(MESERR_RQP, codeErr);
    codeErr = StringUtils.EMPTY;

    SpecialCustomerItem customer = (SpecialCustomerItem) SessionUtil
        .getAttribute(ACCOUNT_OBJECT_ATTRIBUTE);
    if (customer != null) {
      map.put(ACCOUNT_OBJECT_RQP, SessionUtil.getAttribute(ACCOUNT_OBJECT_ATTRIBUTE));
      SessionUtil.removeAttribute(ACCOUNT_OBJECT_ATTRIBUTE);
    }
    return PAGE_EDIT_ACCOUNT;
  }

  @GetMapping(value = "/details/{accountId}")
//    @PreAuthorize("hasAnyRole('" + ADMIN_OPERATION + "')")
  public String accountDetail(HttpServletRequest request, HttpServletResponse response,
      ModelMap model, @PathVariable("accountId") Long accountId) throws FrontEndException {
    try {
      getAccountDetail(request, model, accountId);
    } catch (Exception e) {
      LOG.error(e.getMessage(), e);
      codeErr = e.getMessage();
      model.put(MESERR_RQP, codeErr);
    }

    model.put(CODEERR_RQP, codeErr);
    model.put(EDIT_TYPE_RQP, "edit");
    codeErr = StringUtils.EMPTY;
    return PAGE_EDIT_ACCOUNT;
  }

  @PostMapping(value = "/details/{accountId}")
//    @PreAuthorize("hasAnyRole('" + ADMIN_OPERATION + "')")
  public String accountDetailUpdate(HttpServletRequest request, HttpServletResponse response,
      ModelMap map, @PathVariable("accountId") Long accountId) throws FrontEndException {

    try {
      String editType = request.getParameter(EDIT_TYPE_RQP);
      if ("edit".equals(editType)) {
//        //Update special account info
        mCustomer = getAccountDetail(request, map, accountId);
        String btnAction = request.getParameter("btn-action");
        if ("save-account-info".equals(btnAction)) {
          putAccountInfo(request, map, mCustomer);
        }
        AddOrUpdateSpecialCustomerRequest updateCustomerReq = new AddOrUpdateSpecialCustomerRequest();
        updateCustomerReq.setSpecialCustomerItem(mCustomer);
        AddOrUpdateSpecialCustomerResponse updateCustomerRes = epinStoreEndpoint
            .updateAccount(updateCustomerReq);
        if (updateCustomerRes == null || updateCustomerRes.getStatus() == null) {
          codeErr = updateCustomerRes.getStatus().getValue();
          throw new Exception("Can not Update Customer");
        }
        if (0 != updateCustomerRes.getStatus().getCode()) {
          codeErr = updateCustomerRes.getStatus().getValue();
          map.put(MESERR_RQP, codeErr);
          throw new Exception(updateCustomerRes.getStatus().getValue());
        }
      }

    } catch (Exception e) {
      LOG.error(e.getMessage(), e);
      codeErr = e.getMessage();
      map.put(CODEERR_RQP, codeErr);
      map.put(MESERR_RQP, codeErr);
      codeErr = StringUtils.EMPTY;
      map.put(EDIT_TYPE_RQP, "edit");
      return PAGE_EDIT_ACCOUNT;
    }

    return accountDetail(request, response, map, accountId);
  }

  @PostMapping(value = "/add")
  @PreAuthorize("hasAnyRole('" + ADMIN_OPERATION + "','" + SALESUPPORT_MANAGER + "')")
  public String addAccountPost(HttpServletRequest request, HttpServletResponse response,
      ModelMap map) throws FrontEndException {
    codeErr = StringUtils.EMPTY;
    SpecialCustomerItem customer = new SpecialCustomerItem();
    try {
      AddOrUpdateSpecialCustomerRequest createCustomerRequest = new AddOrUpdateSpecialCustomerRequest();

      putAccountInfo(request, map, customer);

      createCustomerRequest.setSpecialCustomerItem(customer);

      AddOrUpdateSpecialCustomerResponse createCustomerResponse = epinStoreEndpoint
          .addAccount(createCustomerRequest);
      Long customerId = createCustomerResponse.getItemId();

      if (createCustomerResponse == null) {
        throw new Exception("Can not Update Customer`");
      }
      if (0 != createCustomerResponse.getStatus().getCode()) {
        throw new Exception(createCustomerResponse.getStatus().getValue());
      }

      map.put(CODEERR_RQP, "");
      map.put(MESERR_RQP, "label.message.create.account");
      map.put(EDIT_TYPE_RQP, "add");
      map.put(ACCOUNT_OBJECT_RQP, mCustomer);
      return "redirect:" + SPECIAL_ACCOUNT_MANAGE_DETAIL + "/" + customerId;
    } catch (Exception ex) {
      LOG.error(ex.getMessage(), ex);
      codeErr = ex.getMessage();
      map.put(ACCOUNT_OBJECT_RQP, customer);
      SessionUtil.setAttribute(ACCOUNT_OBJECT_ATTRIBUTE, customer);
      return "redirect:" + REDIRECT_WALLET_ACCOUNT_MANAGE_ADD;
    }
  }

  private SpecialCustomerItem getAccountDetail(HttpServletRequest request,
      ModelMap model, Long accountId) {
    try {

      GetSpecialCustomerRequest specialCustomerByCifRequest = new GetSpecialCustomerRequest();
      specialCustomerByCifRequest.setId(accountId);
      GetSpecialCustomerResponse responseType = epinStoreEndpoint
          .getAccount(specialCustomerByCifRequest);
      if (responseType != null && responseType.getStatus().getCode() == 0) {
        mCustomer = responseType.getSpecialCustomer();
        model.put(ACCOUNT_OBJECT_RQP, mCustomer);
      }
      String editType = request.getParameter(EDIT_TYPE_RQP);
      if ("edit".equals(editType)) {
        model.put(MESERR_RQP, "label.message.label");
      } else if ("add".equals(editType)) {
        model.put(MESERR_RQP, "label.message.create.account");
      }
    } catch (Exception ex) {
      LOG.error(ex.getMessage());
      model.put(ACCOUNT_OBJECT_RQP, mCustomer);
    }
    return mCustomer;
  }

  private void putAccountInfo(HttpServletRequest request, ModelMap model,
      SpecialCustomerItem mCustomer) {
    String editType = request.getParameter(EDIT_TYPE_RQP);
    if ("edit".equals(editType)) {
      mCustomer.setId(Long.parseLong(request.getParameter("accountId")));
      model.put("cif", mCustomer.getCif());
    } else {
      mCustomer.setCif(request.getParameter("cif"));
    }
    mCustomer.setDisplayName(request.getParameter("displayName"));
    if (StringUtils.isNotBlank(request.getParameter("customerType"))) {
      mCustomer.setCustomerType(Integer.parseInt(request.getParameter("customerType")));
    }
    if (StringUtils.isNotBlank(request.getParameter("isActive"))) {
      mCustomer.setIsActive(Boolean.valueOf(request.getParameter("isActive")));
    }
    mCustomer.setEmail(request.getParameter("email"));
    mCustomer.setPhoneNumber(request.getParameter("phone"));
    mCustomer.setDescription(request.getParameter("description"));
    model.put(ACCOUNT_OBJECT_RQP, mCustomer);
  }
}
