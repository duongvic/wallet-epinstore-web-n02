package vn.mog.ewallet.web.controller.ajax;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import vn.mog.ewallet.contract.epin.store.ChangeStatusSpecialCustomerRequest;
import vn.mog.ewallet.contract.epin.store.DataTableResponse;
import vn.mog.ewallet.contract.epin.store.DeleteSpecialCustomerRequest;
import vn.mog.ewallet.contract.epin.store.FindSpecialCustomerRequest;
import vn.mog.ewallet.contract.epin.store.FindSpecialCustomerResponse;
import vn.mog.ewallet.contract.epin.store.beans.CustomerType;
import vn.mog.ewallet.contract.epin.store.beans.SpecialCustomerItem;
import vn.mog.ewallet.services.epin.store.IEpinStoreEndpoint;
import vn.mog.ewallet.web.controller.AbstractController;
import vn.mog.framework.common.utils.NumberUtil;
import vn.mog.framework.contract.base.MobiliserResponseType;

@RestController
@RequestMapping(value = "/ajax-controller")
public class AjaxController extends AbstractController {

  @Autowired
  IEpinStoreEndpoint cardStoreService;
  /*Account*/

  @RequestMapping(value = "/customer/find-customers", method = RequestMethod.POST)
  public DataTableResponse<SpecialCustomerItem> findUmgrCustomers(HttpServletRequest request)
      throws Exception {
//    Enumeration<String> params = request.getParameterNames();
//    while(params.hasMoreElements()){
//      String paramName = params.nextElement();
//      System.out.println("Parameter Name - "+paramName+", Value - "+request.getParameter(paramName));
//    }

    FindSpecialCustomerRequest findSpecialCustomerRequest = new FindSpecialCustomerRequest();

    String fullTextSearch = request.getParameter("quickSearch");
    String paramIsActive = request.getParameter("isActive");
    String paramCustomerType = request.getParameter("customerType");

    if (StringUtils.isNotEmpty(paramIsActive)) {
      findSpecialCustomerRequest.setIsActive(Boolean.valueOf(paramIsActive));
    } else {
      findSpecialCustomerRequest.setIsActive(null);
    }

    if (StringUtils.isNotEmpty(fullTextSearch)) {
      findSpecialCustomerRequest.setQuickSearch(fullTextSearch);
    }

    if (StringUtils.isNotEmpty(paramCustomerType)) {
      findSpecialCustomerRequest.setCustomerTypes(Arrays.asList(Integer.parseInt(paramCustomerType)));
    } else {
      List<Integer> accountTypes = new ArrayList<>();
      accountTypes.add(CustomerType.ID_CUSTOMER);
      accountTypes.add(CustomerType.ID_MERCHANT);
      findSpecialCustomerRequest.setCustomerTypes(accountTypes);
    }

    findSpecialCustomerRequest.setOffset(Integer.parseInt(request.getParameter("start")));
    findSpecialCustomerRequest.setLimit(Integer.parseInt(request.getParameter("length")));

    FindSpecialCustomerResponse findUmgrCustomerResponse = cardStoreService
        .getPrivateMerchant(findSpecialCustomerRequest);

    DataTableResponse<SpecialCustomerItem> response = new DataTableResponse<>();
    response.setRecordsTotal(findUmgrCustomerResponse.getTotal());
    response.setRecordsFiltered(findUmgrCustomerResponse.getTotal());
    response.setDataList(findUmgrCustomerResponse.getSpecialCustomerList());

    return response;
  }

  @RequestMapping(value = "/account/remove-account", method = RequestMethod.POST)
  public MobiliserResponseType resendInfo(HttpServletRequest request)
      throws Exception {

    String customerId = request.getParameter("customerId");

    DeleteSpecialCustomerRequest deleteCusRq = new DeleteSpecialCustomerRequest();
    deleteCusRq.setCustomerId(NumberUtil.convertToLong(customerId));

    return cardStoreService.removeAccount(deleteCusRq);
  }

  @RequestMapping(value = "/account/changeStatus", method = RequestMethod.POST)
  public MobiliserResponseType changeStatusList(HttpServletRequest request)
      throws Exception {
    String blacklistReasonType = request.getParameter("isActive");
    String customerId = request.getParameter("customerId");
    String remark = request.getParameter("description");

    ChangeStatusSpecialCustomerRequest changeBlacklistReasonRequest = new ChangeStatusSpecialCustomerRequest();
    changeBlacklistReasonRequest.setCustomerId(NumberUtil.convertToLong(customerId));
    changeBlacklistReasonRequest.setIsActive(Boolean.valueOf(blacklistReasonType));
    changeBlacklistReasonRequest.setDescription(remark);

    return cardStoreService.changeStatus(changeBlacklistReasonRequest);
  }

}
