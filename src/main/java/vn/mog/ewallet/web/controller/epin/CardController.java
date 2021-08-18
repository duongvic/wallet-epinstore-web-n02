package vn.mog.ewallet.web.controller.epin;

import static vn.mog.ewallet.constant.RoleConstants.ADMIN_OPERATION;
import static vn.mog.ewallet.constant.RoleConstants.CUSTOMERCARE;
import static vn.mog.ewallet.constant.RoleConstants.CUSTOMERCARE_MANAGER;
import static vn.mog.ewallet.constant.RoleConstants.FA_MANAGER;
import static vn.mog.ewallet.constant.RoleConstants.FINANCE;
import static vn.mog.ewallet.constant.RoleConstants.FINANCESUPPORT_LEADER;
import static vn.mog.ewallet.constant.RoleConstants.RECONCILIATION;
import static vn.mog.ewallet.constant.RoleConstants.RECONCILIATION_LEADER;
import static vn.mog.ewallet.constant.RoleConstants.SALESUPPORT;
import static vn.mog.ewallet.constant.RoleConstants.SALESUPPORT_LEADER;
import static vn.mog.ewallet.constant.RoleConstants.SALESUPPORT_MANAGER;
import static vn.mog.ewallet.constant.RoleConstants.SALE_DIRECTOR;
import static vn.mog.ewallet.web.contract.CardFaceValue.FULL_FACE_VALUE;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Date;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.lang3.ArrayUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import vn.mog.ewallet.contract.epin.store.FindCardRequest;
import vn.mog.ewallet.contract.epin.store.FindCardResponse;
import vn.mog.ewallet.contract.epin.store.beans.CardItem;
import vn.mog.ewallet.exception.FrontEndException;
import vn.mog.ewallet.web.controller.AbstractController;
import vn.mog.ewallet.web.controller.dashboard.beans.UpType;
import vn.mog.framework.common.utils.NumberUtil;

@Controller
@RequestMapping(value = "/provider/card-manager")
public class CardController extends AbstractController {

  public static final String CARD_STORE_LIST = "/provider/card-manager/list";
  private static final Logger log = Logger.getLogger(CardController.class);

  @RequestMapping(value = "/list", method = RequestMethod.GET)
  @PreAuthorize("hasAnyRole('" + ADMIN_OPERATION + "','"
      + FINANCESUPPORT_LEADER + "','" + FA_MANAGER + "','" + FINANCE + "','"
      + SALESUPPORT + "','" + SALESUPPORT_MANAGER + "','" + SALESUPPORT_LEADER + "','"
      + SALE_DIRECTOR + "', '"
      + RECONCILIATION + "', '" + RECONCILIATION_LEADER + "','" + CUSTOMERCARE + "','" + CUSTOMERCARE_MANAGER + "')")
  public String cardManagerStore(HttpServletRequest request, ModelMap model)
      throws FrontEndException {

    model.put("listTelcos", epinStoreEndpoint.listProvider());
    model.put("listAmount", FULL_FACE_VALUE);
    model.put("listStatus", epinStoreEndpoint.listCardStatus());
    model.put("cardTypes", epinStoreEndpoint.listType());
    model.put("listUpType", UpType.FULL_UP_TYPE);

    Long total = 0L;
    Integer offset = 0;
    Integer limit = 10;
    if (request.getParameter("d-49520-p") != null) {
      Integer p = Integer.parseInt(request.getParameter("d-49520-p"));
      offset = limit * (p - 1);
    }

    FindCardRequest fcRequest = new FindCardRequest();

    String searchRange = request.getParameter("range");
    if (StringUtils.isNotBlank(searchRange)) {
      Date[] dates = parseDateRange(searchRange,true);
      fcRequest.setFromDate(dates[0]);
      fcRequest.setEndDate(dates[1]);
    }

    int[] faceValues = ServletRequestUtils.getIntParameters(request, "faceValues");
    String[] status = request.getParameterValues("status");
    String[] stages = request.getParameterValues("stages");
    String[] cardType = request.getParameterValues("cardTypes");
    String[] poType = request.getParameterValues("poTypes");

    if (faceValues != null && faceValues.length > 0 && faceValues[0] > 0) {
      fcRequest.setFaceValues(Arrays.asList(ArrayUtils.toObject(faceValues)));
    }

    if (status != null && status.length > 0 && !status[0].equals(StringUtils.EMPTY)) {
      fcRequest.setStatus(Arrays.asList(status));
    }

    if (stages != null && stages.length > 0 && !stages[0].equals(StringUtils.EMPTY)) {
      fcRequest.setStages(Arrays.asList(stages));
    }

    if (cardType != null && cardType.length > 0 && !cardType[0].equals(StringUtils.EMPTY)) {
      fcRequest.setTypes(Arrays.asList(cardType));
    }

    if (poType != null && poType.length > 0 && !poType[0].equals(StringUtils.EMPTY)) {
      fcRequest.setUpTypes(NumberUtil.convertListToInt(poType));
    }

    fcRequest.setOrderBy(new String[]{"creationDate"});
    fcRequest.setDesc(new boolean[]{true});

    String quickSearch = StringUtils.trimToNull(request.getParameter("search"));
    fcRequest.setQuickSearch(quickSearch);
    fcRequest.setOffset(offset);
    fcRequest.setLimit(limit);

    Collection<CardItem> listCard = new ArrayList<>();
    FindCardResponse responseCard = epinStoreEndpoint.findCards(fcRequest);
    long sumOfmoney = 0;
    long sumOfcapital = 0;
    if (responseCard.getStatus().getCode() == 0) {
      listCard = responseCard.getCards();
      total = responseCard.getCount();
      sumOfmoney = responseCard.getAmount();
      sumOfcapital = responseCard.getCapital();
    }

    model.put("pagesize", limit);
    model.put("offset", offset);
    model.put("list", listCard);
    model.put("total", total.intValue());
    model.put("sumOfmoney", sumOfmoney);
    model.put("sumOfcapital", sumOfcapital);
    model.put("search", StringUtils.trimToNull(quickSearch));

    return "/card_manager/card_manager";
  }

}
