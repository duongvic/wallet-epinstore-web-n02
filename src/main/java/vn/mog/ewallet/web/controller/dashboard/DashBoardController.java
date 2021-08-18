package vn.mog.ewallet.web.controller.dashboard;

import static vn.mog.ewallet.constant.RoleConstants.ADMIN_OPERATION;
import static vn.mog.ewallet.constant.RoleConstants.CUSTOMER;
import static vn.mog.ewallet.constant.RoleConstants.CUSTOMERCARE;
import static vn.mog.ewallet.constant.RoleConstants.CUSTOMERCARE_MANAGER;
import static vn.mog.ewallet.constant.RoleConstants.FA_MANAGER;
import static vn.mog.ewallet.constant.RoleConstants.FINANCE;
import static vn.mog.ewallet.constant.RoleConstants.FINANCESUPPORT_LEADER;
import static vn.mog.ewallet.constant.RoleConstants.FINANCE_LEADER;
import static vn.mog.ewallet.constant.RoleConstants.MERCHANT;
import static vn.mog.ewallet.constant.RoleConstants.SALESUPPORT;
import static vn.mog.ewallet.constant.RoleConstants.SALESUPPORT_LEADER;
import static vn.mog.ewallet.constant.RoleConstants.SALESUPPORT_MANAGER;
import static vn.mog.ewallet.constant.RoleConstants.SALE_ASM;
import static vn.mog.ewallet.constant.RoleConstants.SALE_ASSISTANT;
import static vn.mog.ewallet.constant.RoleConstants.SALE_DIRECTOR;
import static vn.mog.ewallet.constant.RoleConstants.SALE_EXCUTIVE;
import static vn.mog.ewallet.constant.RoleConstants.SALE_RSM;
import static vn.mog.ewallet.constant.RoleConstants.SALE_SUPERVISOR;
import static vn.mog.ewallet.constant.RoleConstants.STAFF;
import static vn.mog.ewallet.constant.RoleConstants.TECH_SUPPORT;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import org.apache.commons.lang3.StringUtils;
import org.jboss.logging.Logger;
import org.json.JSONObject;
import org.springframework.http.MediaType;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import vn.mog.ewallet.constant.RoleConstants;
import vn.mog.ewallet.constant.SharedConstants;
import vn.mog.ewallet.contract.epin.store.FindSpecialCustomerRequest;
import vn.mog.ewallet.contract.epin.store.FindSpecialCustomerResponse;
import vn.mog.ewallet.contract.epin.store.GetCardDashBoardRequest;
import vn.mog.ewallet.contract.epin.store.GetCardDashBoardResponse;
import vn.mog.ewallet.contract.epin.store.beans.CardDashBoardItem;
import vn.mog.ewallet.contract.epin.store.beans.CardSummaryWarning;
import vn.mog.ewallet.contract.epin.store.beans.ChartRowItem;
import vn.mog.ewallet.contract.epin.store.beans.CustomerType;
import vn.mog.ewallet.contract.epin.store.beans.PieChartItem;
import vn.mog.ewallet.contract.epin.store.beans.SpecialCustomerItem;
import vn.mog.ewallet.contract.epin.store.beans.Stage;
import vn.mog.ewallet.contract.epin.store.beans.StoreNotfInfo;
import vn.mog.ewallet.exception.FrontEndException;
import vn.mog.ewallet.web.controller.AbstractController;
import vn.mog.framework.common.utils.JsonUtil;
import vn.mog.framework.common.utils.NumberUtil;
import vn.mog.framework.security.api.CallerInformation;

@Controller
@RequestMapping(value = "/provider")
public class DashBoardController extends AbstractController {

  private static final Logger log = Logger.getLogger(DashBoardController.class);

  private static final String CARD_INPUTTED = "cardInputted";
  private static final String CARD_SOLD = "cardSold";
  private static final String CARD_ACTIVATE = "cardActivate";
  private static final String CARD_DEACTIVATE = "cardDeactivate";
  private static final String CARD_EXPIRED = "cardExpired";
  private static final String CARD_PRE_EXPIRED = "cardPreExpired";

  private static final String TEN = "10000";
  private static final String TWENTY = "20000";
  private static final String THIRTY = "30000";
  private static final String FORTY = "40000";
  private static final String FIFTY = "50000";
  private static final String HUNDRED = "100000";
  private static final String TWO_HUNDRED = "200000";
  private static final String THREE_HUNDRED = "300000";
  private static final String FIVE_HUNDRED = "500000";
  private static final String ONE_MINION = "1000000";
  private static final String TWO_MINION = "2000000";
  private static final String FIVE_MINION = "5000000";
  private static final String ONE = "1000";
  private static final String TWO = "2000";
  private static final String THREE = "3000";
  private static final String FIVE = "5000";
  private static final String FOUR_TEENTH = "14000";
  private static final String TWENTY_EIGHTH = "28000";
  private static final String FOURTY_SECOND = "42000";
  private static final String FIFTY_SIX = "56000";
  private static final String EIGHTY_FOUR = "84000";
  private static final String SEVEN_TY = "70000";
  private static final String ONE_HUNDRED_TWELVE = "120000";
  private static final String ONE_HUNDRED_FIFTEEN = "150000";
  private static final String NINETY = "90000";
  private static final String ONE_HUNDRED_TWENTY_FIVE = "125000";

  private static final String NUMBER = "number";
  private static final String VALUE = "value";
  private static final String CAPITAL = "capital";

  public static final String CARD_STORE_DASHBOAR = "/provider/cardstore/dashboard";

  @RequestMapping(value = "/cardstore/dashboard", method = RequestMethod.GET)
  @PreAuthorize("hasAnyRole('" + ADMIN_OPERATION + "','"
      + FINANCE + "','" + SALE_DIRECTOR + "','" + MERCHANT + "','"
      + CUSTOMERCARE_MANAGER + "', '" + CUSTOMERCARE + "', '" + SALESUPPORT + "', '"
      + SALE_ASM + "', '" + SALE_RSM + "', '" + SALE_DIRECTOR + "', '" + SALE_EXCUTIVE + "', '"
      + SALE_SUPERVISOR + "', '" + SALE_ASSISTANT + "' ,'" + TECH_SUPPORT + "','" + CUSTOMER + "','"
      + STAFF + "','"
      + SALESUPPORT + "','" + SALESUPPORT_LEADER + "','" + SALESUPPORT_MANAGER + "','"
      + FINANCESUPPORT_LEADER + "','" + FINANCE_LEADER + "','" + FA_MANAGER + "')")
  public String dashboard(ModelMap model) throws FrontEndException {
    Boolean isSale = false;
    List<SpecialCustomerItem> specialCustomers = new ArrayList<>();
    try {
      CallerInformation callerInformation = callerUtil.getCallerInformation();
      List<String> roleList = callerInformation.getActorPrivs();

      for (int i = 0; i < roleList.size(); i++) {
        String role = roleList.get(i);
        if (role.equals(RoleConstants.SALE_DIRECTOR) || role.equals(RoleConstants.SALE_EXCUTIVE)
            || role.equals(RoleConstants.SALE_SUPERVISOR) || role.equals(RoleConstants.SALE_ASM)
            || role.equals(RoleConstants.SALE_RSM) || role.equals(RoleConstants.SALE_RSM)) {
          isSale = true;

        }
      }
      if (!isSale) {
        FindSpecialCustomerResponse merchantRes = epinStoreEndpoint
            .getPrivateMerchant(new FindSpecialCustomerRequest());
        if (merchantRes != null && merchantRes.getStatus().getCode() == 0) {
          specialCustomers = merchantRes.getSpecialCustomerList();
        }
      }
      model.put("isSale", isSale);
      model.put("specialCustomers", specialCustomers);
      model.put("cardTypes", epinStoreEndpoint.listType());
      model.put("cardProviders", epinStoreEndpoint.listProvider());
      model.put("nearExpDays", SharedConstants.NEAR_EXP_DAYS);
    } catch (Exception ex) {
      log.error(ex.getMessage());
    }
    return "/dashboard/cardstore";
  }

  @RequestMapping(value = "/dashboard/statistic", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE, consumes = MediaType.APPLICATION_JSON_VALUE)
  @ResponseBody
  public String statisticDashboard(
      @RequestBody GetCardDashBoardRequest dashboardRequest,
      @RequestParam("daterange") String daterange) throws FrontEndException, ParseException {
    JSONObject jDashboard = new JSONObject();
    try {
      if (daterange != null && daterange.compareTo("null") != 0 && StringUtils
          .isNotEmpty(daterange)) {
        Date[] dates = parseDateRange(daterange, true);
        dashboardRequest.setFromDate(dates[0]);
        dashboardRequest.setEndDate(dates[1]);
      }

      long startRequest = new Date().getTime();
      GetCardDashBoardResponse dashBoardResponse = epinStoreEndpoint
          .getCardDashBoard(dashboardRequest);
      Map<String, Map<Integer, StoreNotfInfo>> warningLevelResult = dashBoardResponse
          .getWarningLevelResult();
      if (warningLevelResult == null) {
        warningLevelResult = new HashMap<>();
      }
      long endResponse = new Date().getTime();
      if (dashBoardResponse.getCardDashBoardItems() != null) {
        chartFollowStatus(dashBoardResponse.getCardDashBoardItems(), jDashboard);
        chartFollowCardType(dashBoardResponse.getCardDashBoardItems(), warningLevelResult,
            jDashboard);
      }
      long calulateTime = new Date().getTime();
      log.debug("time request---" + (endResponse - startRequest));
      log.debug("time caculator-" + (calulateTime - endResponse));
    } catch (Exception ex) {
      log.error(ex.getMessage());
    }

    return jDashboard.toString();
  }

  /**
   * chartFollowStatus
   */
  private void chartFollowStatus(List<CardDashBoardItem> items, JSONObject jDashboard) {

    HashMap<String, JSONObject> hashMap = sumCountData(items);

    jDashboard.put(CARD_INPUTTED, hashMap.get(CARD_INPUTTED));
    jDashboard.put(CARD_SOLD, hashMap.get(CARD_SOLD));
    jDashboard.put(CARD_ACTIVATE, hashMap.get(CARD_ACTIVATE));
    jDashboard.put(CARD_DEACTIVATE, hashMap.get(CARD_DEACTIVATE));
    jDashboard.put(CARD_EXPIRED, hashMap.get(CARD_EXPIRED));
    jDashboard.put(CARD_PRE_EXPIRED, hashMap.get(CARD_PRE_EXPIRED));

    List<PieChartItem> pieNumbers = new ArrayList<>();
    pieNumbers.add(new PieChartItem("Sold", hashMap.get(CARD_SOLD).getLong(NUMBER)));//Thẻ đã bán
    pieNumbers
        .add(new PieChartItem("Active", hashMap.get(CARD_ACTIVATE).getLong(NUMBER)));//Thẻ còn tồn
    pieNumbers.add(
        new PieChartItem("Inactive", hashMap.get(CARD_DEACTIVATE).getLong(NUMBER)));//Thẻ còn tồn

    jDashboard.put("pieDataNumberCards", JsonUtil.objectToJson(pieNumbers));

    List<PieChartItem> pieValues = new ArrayList<>();
    pieValues.add(new PieChartItem("Sold", hashMap.get(CARD_SOLD).getLong(VALUE)));//Thẻ đã bán
    pieValues
        .add(new PieChartItem("Active", hashMap.get(CARD_ACTIVATE).getLong(VALUE)));//Thẻ còn tồn
    pieValues.add(
        new PieChartItem("Inactive", hashMap.get(CARD_DEACTIVATE).getLong(VALUE)));//Thẻ còn tồn

    jDashboard.put("pieDataFaceValues", JsonUtil.objectToJson(pieValues));
  }


  /**
   * chartFollowCardType
   */
  private void chartFollowCardType(List<CardDashBoardItem> itemTables,
      Map<String, Map<Integer, StoreNotfInfo>> warningLevelResult, JSONObject jsonDashboard) {

    HashMap<String, List<CardDashBoardItem>> rawData = new HashMap<>();

    //sort by Card Type
    for (CardDashBoardItem item : itemTables) {
      if (rawData.containsKey(item.getCardType().name)) {
        List<CardDashBoardItem> chartRowItems = rawData.get(item.getCardType().name);
        chartRowItems.add(item);
        rawData.put(item.getCardType().name, chartRowItems);
      } else {
        List<CardDashBoardItem> rowItems = new ArrayList<>();
        rowItems.add(item);
        rawData.put(item.getCardType().name, rowItems);
      }
    }

    //summary card type
    HashMap<String, List<CardSummaryWarning>> cardSumaryWarning = new HashMap<>();

    //sum value && count
    HashMap<String, List<ChartRowItem>> chartDataStatict = new HashMap<>();

    ChartRowItem chartRowItem;
    CardSummaryWarning cardSummaryWarning;

    for (Map.Entry<String, List<CardDashBoardItem>> rawItem : rawData.entrySet()) {
      String cardType = rawItem.getKey();
      HashMap<String, JSONObject> hashCardType = caculatorByFacevalue(rawItem.getValue());

      List<ChartRowItem> chartRowItems = new ArrayList<>();
      List<CardSummaryWarning> cardSummaryWarnings = new ArrayList<>();

      Set<String> faceValueExistSet = new HashSet<>();
      for (Map.Entry<String, JSONObject> item : hashCardType.entrySet()) {
        JSONObject sumValueCard = item.getValue();
        chartRowItem = new ChartRowItem(rawItem.getKey(), item.getKey(),
            sumValueCard.isNull(CARD_INPUTTED) ? 0L : sumValueCard.getLong(CARD_INPUTTED),
            sumValueCard.isNull(CARD_SOLD) ? 0L : sumValueCard.getLong(CARD_SOLD),
            sumValueCard.isNull(CARD_ACTIVATE) ? 0L : sumValueCard.getLong(CARD_ACTIVATE),
            sumValueCard.isNull(CARD_DEACTIVATE) ? 0L : sumValueCard.getLong(CARD_DEACTIVATE),
            sumValueCard.isNull(CARD_PRE_EXPIRED) ? 0L : sumValueCard.getLong(CARD_PRE_EXPIRED),
            sumValueCard.isNull(CARD_EXPIRED) ? 0L : sumValueCard.getLong(CARD_EXPIRED));

        //TODO tinh mưc cảnh bảo here
        String faceValue = chartRowItem.getFaceValue();
        faceValueExistSet.add(faceValue);
        long level = checkCardWarning(cardType, NumberUtil.convertToInt(faceValue),
            warningLevelResult);
        chartRowItem.setLeverWarning(level);

        chartRowItems.add(chartRowItem);

        cardSummaryWarning = new CardSummaryWarning(NumberUtil.formatNumber(faceValue), level);
        cardSummaryWarnings.add(cardSummaryWarning);
      }

      chartRowItems.addAll(initDefaultCharRowItem(faceValueExistSet, cardType, warningLevelResult));

      chartDataStatict.put(cardType, chartRowItems);
      cardSumaryWarning.put(cardType, cardSummaryWarnings);
    }

    jsonDashboard.put("cardSumaryWarning", JsonUtil.objectToJson(cardSumaryWarning));
    jsonDashboard.put("cardRowItemes", JsonUtil.objectToJson(chartDataStatict));
  }

  /**
   * Khởi tạo giá trị default theo card type
   */
  private List<ChartRowItem> initDefaultCharRowItem(Set<String> faceValueExist, String cardType,
      Map<String, Map<Integer, StoreNotfInfo>> warningLevelResult) {
    List<ChartRowItem> initDefault = new ArrayList<>();
    if (("DATA_VINAPHONE" != cardType) && ("DATA_MOBIFONE" != cardType) && ("DATA_VIETTEL"
        != cardType) && ("SCOIN" != cardType) && ("FUNCARD" != cardType)) {
      if (!faceValueExist.contains(TEN)) {
        long level = checkCardWarning(cardType, NumberUtil.convertToInt(TEN), warningLevelResult);
        initDefault.add(new ChartRowItem(cardType, TEN, 0L, 0L, 0L, 0L, 0L, 0L, level));
      }

      if (!faceValueExist.contains(TWENTY)) {
        long level = checkCardWarning(cardType, NumberUtil.convertToInt(TWENTY),
            warningLevelResult);
        initDefault.add(new ChartRowItem(cardType, TWENTY, 0L, 0L, 0L, 0L, 0L, 0L, level));
      }

      if ("SOHA" != cardType) {
        if (!faceValueExist.contains(THIRTY)) {
          long level = checkCardWarning(cardType, NumberUtil.convertToInt(THIRTY),
              warningLevelResult);
          initDefault.add(new ChartRowItem(cardType, THIRTY, 0L, 0L, 0L, 0L, 0L, 0L, level));
        }
      }

      if (!faceValueExist.contains(FIFTY)) {
        long level = checkCardWarning(cardType, NumberUtil.convertToInt(FIFTY), warningLevelResult);
        initDefault.add(new ChartRowItem(cardType, FIFTY, 0L, 0L, 0L, 0L, 0L, 0L, level));
      }

      if (!faceValueExist.contains(HUNDRED)) {
        long level = checkCardWarning(cardType, NumberUtil.convertToInt(HUNDRED),
            warningLevelResult);
        initDefault.add(new ChartRowItem(cardType, HUNDRED, 0L, 0L, 0L, 0L, 0L, 0L, level));
      }

      if (!faceValueExist.contains(TWO_HUNDRED)) {
        long level = checkCardWarning(cardType, NumberUtil.convertToInt(TWO_HUNDRED),
            warningLevelResult);
        initDefault.add(new ChartRowItem(cardType, TWO_HUNDRED, 0L, 0L, 0L, 0L, 0L, 0L, level));
      }

      if (!faceValueExist.contains(THREE_HUNDRED)) {
        long level = checkCardWarning(cardType, NumberUtil.convertToInt(THREE_HUNDRED),
            warningLevelResult);
        initDefault.add(new ChartRowItem(cardType, THREE_HUNDRED, 0L, 0L, 0L, 0L, 0L, 0L, level));
      }

      if (!faceValueExist.contains(FIVE_HUNDRED)) {
        long level = checkCardWarning(cardType, NumberUtil.convertToInt(FIVE_HUNDRED),
            warningLevelResult);
        initDefault.add(new ChartRowItem(cardType, FIVE_HUNDRED, 0L, 0L, 0L, 0L, 0L, 0L, level));
      }

      if (!faceValueExist.contains(ONE_MINION)) {
        long level = checkCardWarning(cardType, NumberUtil.convertToInt(ONE_MINION),
            warningLevelResult);
        initDefault.add(new ChartRowItem(cardType, ONE_MINION, 0L, 0L, 0L, 0L, 0L, 0L, level));
      }

      if (!faceValueExist.contains(TWO_MINION)) {
        long level = checkCardWarning(cardType, NumberUtil.convertToInt(TWO_MINION),
            warningLevelResult);
        initDefault.add(new ChartRowItem(cardType, TWO_MINION, 0L, 0L, 0L, 0L, 0L, 0L, level));
      }
      if ("SOHA" == cardType) {
        if (!faceValueExist.contains(FIVE_MINION)) {
          long level = checkCardWarning(cardType, NumberUtil.convertToInt(FIVE_MINION),
              warningLevelResult);
          initDefault.add(new ChartRowItem(cardType, FIVE_MINION, 0L, 0L, 0L, 0L, 0L, 0L, level));
        }
      }
    } else if ("DATA_MOBIFONE" == cardType) {
            /*Data code*/
      if (!faceValueExist.contains(ONE)) {
        long level = checkCardWarning(cardType, NumberUtil.convertToInt(ONE), warningLevelResult);
        initDefault.add(new ChartRowItem(cardType, ONE, 0L, 0L, 0L, 0L, 0L, 0L, level));
      }

      if (!faceValueExist.contains(TWO)) {
        long level = checkCardWarning(cardType, NumberUtil.convertToInt(TWO), warningLevelResult);
        initDefault.add(new ChartRowItem(cardType, TWO, 0L, 0L, 0L, 0L, 0L, 0L, level));
      }

      if (!faceValueExist.contains(THREE)) {
        long level = checkCardWarning(cardType, NumberUtil.convertToInt(THREE), warningLevelResult);
        initDefault.add(new ChartRowItem(cardType, THREE, 0L, 0L, 0L, 0L, 0L, 0L, level));
      }

      if (!faceValueExist.contains(FIVE)) {
        long level = checkCardWarning(cardType, NumberUtil.convertToInt(FIVE), warningLevelResult);
        initDefault.add(new ChartRowItem(cardType, FIVE, 0L, 0L, 0L, 0L, 0L, 0L, level));
      }

      if (!faceValueExist.contains(TEN)) {
        long level = checkCardWarning(cardType, NumberUtil.convertToInt(TEN), warningLevelResult);
        initDefault.add(new ChartRowItem(cardType, TEN, 0L, 0L, 0L, 0L, 0L, 0L, level));
      }

      if (!faceValueExist.contains(FOUR_TEENTH)) {
        long level = checkCardWarning(cardType, NumberUtil.convertToInt(FOUR_TEENTH),
            warningLevelResult);
        initDefault.add(new ChartRowItem(cardType, FOUR_TEENTH, 0L, 0L, 0L, 0L, 0L, 0L, level));
      }

      if (!faceValueExist.contains(TWENTY)) {
        long level = checkCardWarning(cardType, NumberUtil.convertToInt(TWENTY),
            warningLevelResult);
        initDefault.add(new ChartRowItem(cardType, TWENTY, 0L, 0L, 0L, 0L, 0L, 0L, level));
      }

      if (!faceValueExist.contains(TWENTY_EIGHTH)) {
        long level = checkCardWarning(cardType, NumberUtil.convertToInt(TWENTY_EIGHTH),
            warningLevelResult);
        initDefault.add(new ChartRowItem(cardType, TWENTY_EIGHTH, 0L, 0L, 0L, 0L, 0L, 0L, level));
      }

      if (!faceValueExist.contains(FOURTY_SECOND)) {
        long level = checkCardWarning(cardType, NumberUtil.convertToInt(FOURTY_SECOND),
            warningLevelResult);
        initDefault.add(new ChartRowItem(cardType, FOURTY_SECOND, 0L, 0L, 0L, 0L, 0L, 0L, level));
      }

      if (!faceValueExist.contains(FIFTY_SIX)) {
        long level = checkCardWarning(cardType, NumberUtil.convertToInt(FIFTY_SIX),
            warningLevelResult);
        initDefault.add(new ChartRowItem(cardType, FIFTY_SIX, 0L, 0L, 0L, 0L, 0L, 0L, level));
      }

      if (!faceValueExist.contains(EIGHTY_FOUR)) {
        long level = checkCardWarning(cardType, NumberUtil.convertToInt(EIGHTY_FOUR),
            warningLevelResult);
        initDefault.add(new ChartRowItem(cardType, EIGHTY_FOUR, 0L, 0L, 0L, 0L, 0L, 0L, level));
      }
    } else if ("DATA_VINAPHONE" == cardType) {

      if (!faceValueExist.contains(TWENTY)) {
        long level = checkCardWarning(cardType, NumberUtil.convertToInt(TWENTY),
            warningLevelResult);
        initDefault.add(new ChartRowItem(cardType, TWENTY, 0L, 0L, 0L, 0L, 0L, 0L, level));
      }

      if (!faceValueExist.contains(FIFTY)) {
        long level = checkCardWarning(cardType, NumberUtil.convertToInt(FIFTY), warningLevelResult);
        initDefault.add(new ChartRowItem(cardType, FIFTY, 0L, 0L, 0L, 0L, 0L, 0L, level));
      }

      if (!faceValueExist.contains(SEVEN_TY)) {
        long level = checkCardWarning(cardType, NumberUtil.convertToInt(SEVEN_TY),
            warningLevelResult);
        initDefault.add(new ChartRowItem(cardType, SEVEN_TY, 0L, 0L, 0L, 0L, 0L, 0L, level));
      }

      if (!faceValueExist.contains(HUNDRED)) {
        long level = checkCardWarning(cardType, NumberUtil.convertToInt(HUNDRED),
            warningLevelResult);
        initDefault.add(new ChartRowItem(cardType, HUNDRED, 0L, 0L, 0L, 0L, 0L, 0L, level));
      }
      if (!faceValueExist.contains(ONE_HUNDRED_TWELVE)) {
        long level = checkCardWarning(cardType, NumberUtil.convertToInt(ONE_HUNDRED_TWELVE),
            warningLevelResult);
        initDefault
            .add(new ChartRowItem(cardType, ONE_HUNDRED_TWELVE, 0L, 0L, 0L, 0L, 0L, 0L, level));
      }

      if (!faceValueExist.contains(ONE_HUNDRED_FIFTEEN)) {
        long level = checkCardWarning(cardType, NumberUtil.convertToInt(ONE_HUNDRED_FIFTEEN),
            warningLevelResult);
        initDefault
            .add(new ChartRowItem(cardType, ONE_HUNDRED_FIFTEEN, 0L, 0L, 0L, 0L, 0L, 0L, level));
      }
    } else if ("DATA_VIETTEL" == cardType) {

      if (!faceValueExist.contains(FIVE)) {
        long level = checkCardWarning(cardType, NumberUtil.convertToInt(FIVE), warningLevelResult);
        initDefault.add(new ChartRowItem(cardType, FIVE, 0L, 0L, 0L, 0L, 0L, 0L, level));
      }

      if (!faceValueExist.contains(TEN)) {
        long level = checkCardWarning(cardType, NumberUtil.convertToInt(TEN), warningLevelResult);
        initDefault.add(new ChartRowItem(cardType, TEN, 0L, 0L, 0L, 0L, 0L, 0L, level));
      }

      if (!faceValueExist.contains(FIFTY)) {
        long level = checkCardWarning(cardType, NumberUtil.convertToInt(FIFTY), warningLevelResult);
        initDefault.add(new ChartRowItem(cardType, FIFTY, 0L, 0L, 0L, 0L, 0L, 0L, level));
      }

      if (!faceValueExist.contains(HUNDRED)) {
        long level = checkCardWarning(cardType, NumberUtil.convertToInt(HUNDRED),
            warningLevelResult);
        initDefault.add(new ChartRowItem(cardType, HUNDRED, 0L, 0L, 0L, 0L, 0L, 0L, level));
      }
    } else if ("SCOIN" == cardType) {
      if (!faceValueExist.contains(TEN)) {
        long level = checkCardWarning(cardType, NumberUtil.convertToInt(TEN), warningLevelResult);
        initDefault.add(new ChartRowItem(cardType, TEN, 0L, 0L, 0L, 0L, 0L, 0L, level));
      }

      if (!faceValueExist.contains(TWENTY)) {
        long level = checkCardWarning(cardType, NumberUtil.convertToInt(TWENTY),
            warningLevelResult);
        initDefault.add(new ChartRowItem(cardType, TWENTY, 0L, 0L, 0L, 0L, 0L, 0L, level));
      }

      if (!faceValueExist.contains(FIFTY)) {
        long level = checkCardWarning(cardType, NumberUtil.convertToInt(FIFTY), warningLevelResult);
        initDefault.add(new ChartRowItem(cardType, FIFTY, 0L, 0L, 0L, 0L, 0L, 0L, level));
      }

      if (!faceValueExist.contains(HUNDRED)) {
        long level = checkCardWarning(cardType, NumberUtil.convertToInt(HUNDRED),
            warningLevelResult);
        initDefault.add(new ChartRowItem(cardType, HUNDRED, 0L, 0L, 0L, 0L, 0L, 0L, level));
      }

      if (!faceValueExist.contains(TWO_HUNDRED)) {
        long level = checkCardWarning(cardType, NumberUtil.convertToInt(TWO_HUNDRED),
            warningLevelResult);
        initDefault.add(new ChartRowItem(cardType, TWO_HUNDRED, 0L, 0L, 0L, 0L, 0L, 0L, level));
      }

      if (!faceValueExist.contains(FIVE_HUNDRED)) {
        long level = checkCardWarning(cardType, NumberUtil.convertToInt(FIVE_HUNDRED),
            warningLevelResult);
        initDefault.add(new ChartRowItem(cardType, FIVE_HUNDRED, 0L, 0L, 0L, 0L, 0L, 0L, level));
      }

      if (!faceValueExist.contains(ONE_MINION)) {
        long level = checkCardWarning(cardType, NumberUtil.convertToInt(ONE_MINION),
            warningLevelResult);
        initDefault.add(new ChartRowItem(cardType, ONE_MINION, 0L, 0L, 0L, 0L, 0L, 0L, level));
      }

      if (!faceValueExist.contains(TWO_MINION)) {
        long level = checkCardWarning(cardType, NumberUtil.convertToInt(TWO_MINION),
            warningLevelResult);
        initDefault.add(new ChartRowItem(cardType, TWO_MINION, 0L, 0L, 0L, 0L, 0L, 0L, level));
      }

      if (!faceValueExist.contains(FIVE_MINION)) {
        long level = checkCardWarning(cardType, NumberUtil.convertToInt(FIVE_MINION),
            warningLevelResult);
        initDefault.add(new ChartRowItem(cardType, FIVE_MINION, 0L, 0L, 0L, 0L, 0L, 0L, level));
      }
    } else if ("FUNCARD" == cardType) {
      if (!faceValueExist.contains(TEN)) {
        long level = checkCardWarning(cardType, NumberUtil.convertToInt(TEN), warningLevelResult);
        initDefault.add(new ChartRowItem(cardType, TEN, 0L, 0L, 0L, 0L, 0L, 0L, level));
      }

      if (!faceValueExist.contains(TWENTY)) {
        long level = checkCardWarning(cardType, NumberUtil.convertToInt(TWENTY),
            warningLevelResult);
        initDefault.add(new ChartRowItem(cardType, TWENTY, 0L, 0L, 0L, 0L, 0L, 0L, level));
      }

      if (!faceValueExist.contains(FIFTY)) {
        long level = checkCardWarning(cardType, NumberUtil.convertToInt(FIFTY), warningLevelResult);
        initDefault.add(new ChartRowItem(cardType, FIFTY, 0L, 0L, 0L, 0L, 0L, 0L, level));
      }

      if (!faceValueExist.contains(HUNDRED)) {
        long level = checkCardWarning(cardType, NumberUtil.convertToInt(HUNDRED),
            warningLevelResult);
        initDefault.add(new ChartRowItem(cardType, HUNDRED, 0L, 0L, 0L, 0L, 0L, 0L, level));
      }

      if (!faceValueExist.contains(TWO_HUNDRED)) {
        long level = checkCardWarning(cardType, NumberUtil.convertToInt(TWO_HUNDRED),
            warningLevelResult);
        initDefault.add(new ChartRowItem(cardType, TWO_HUNDRED, 0L, 0L, 0L, 0L, 0L, 0L, level));
      }

      if (!faceValueExist.contains(FIVE_HUNDRED)) {
        long level = checkCardWarning(cardType, NumberUtil.convertToInt(FIVE_HUNDRED),
            warningLevelResult);
        initDefault.add(new ChartRowItem(cardType, FIVE_HUNDRED, 0L, 0L, 0L, 0L, 0L, 0L, level));
      }

      if (!faceValueExist.contains(ONE_MINION)) {
        long level = checkCardWarning(cardType, NumberUtil.convertToInt(ONE_MINION),
            warningLevelResult);
        initDefault.add(new ChartRowItem(cardType, ONE_MINION, 0L, 0L, 0L, 0L, 0L, 0L, level));
      }

      if (!faceValueExist.contains(TWO_MINION)) {
        long level = checkCardWarning(cardType, NumberUtil.convertToInt(TWO_MINION),
            warningLevelResult);
        initDefault.add(new ChartRowItem(cardType, TWO_MINION, 0L, 0L, 0L, 0L, 0L, 0L, level));
      }
    }
    return initDefault;
  }

  private long checkCardWarning(String cardTypeWarning, Integer faceValue,
      Map<String, Map<Integer, StoreNotfInfo>> warningLevelResult) {
    if (warningLevelResult.containsKey(cardTypeWarning)) {
      Map<Integer, StoreNotfInfo> integerIntegerMap = warningLevelResult.get(cardTypeWarning);
      if (integerIntegerMap.containsKey(faceValue)) {
        StoreNotfInfo storeNotfInfo = integerIntegerMap.get(faceValue);
        return storeNotfInfo.getWarnLevel() + 1;
      }
    }
    return 0;
  }


  /**
   * chartFollowCardType Tính toán tổng các Facevalue
   */
  private HashMap<String, JSONObject> caculatorByFacevalue(
      List<CardDashBoardItem> cardDashBoardItems) {
    HashMap<String, JSONObject> hashMapCardDashBoardItem = new HashMap<>();
    for (CardDashBoardItem itemCardType : cardDashBoardItems) {
      switch (itemCardType.getFaceValue()) {
        case 10000:
          if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.IN_STOCK.code == itemCardType
              .getStatus().code && Stage.ON == itemCardType.getStage()) {
            sumFacevalue(hashMapCardDashBoardItem, TEN, CARD_ACTIVATE, itemCardType.getTotal());

          } else if (
              vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.IN_STOCK.code == itemCardType
                  .getStatus().code && Stage.OFF == itemCardType
                  .getStage()) {
            sumFacevalue(hashMapCardDashBoardItem, TEN, CARD_DEACTIVATE, itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.SOLD.code
              == itemCardType.getStatus().code) {
            sumFacevalue(hashMapCardDashBoardItem, TEN, CARD_SOLD, itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.EXPIRED.code
              == itemCardType.getStatus().code) {

            sumFacevalue(hashMapCardDashBoardItem, TEN, CARD_EXPIRED, itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.NEAR_EXP.code
              == itemCardType.getStatus().code) {
            sumFacevalue(hashMapCardDashBoardItem, TEN, CARD_PRE_EXPIRED, itemCardType.getTotal());
          }
          break;
        case 20000:
          if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.IN_STOCK.code == itemCardType
              .getStatus().code && Stage.ON == itemCardType.getStage()) {
            sumFacevalue(hashMapCardDashBoardItem, TWENTY, CARD_ACTIVATE, itemCardType.getTotal());

          } else if (
              vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.IN_STOCK.code == itemCardType
                  .getStatus().code && Stage.OFF == itemCardType
                  .getStage()) {
            sumFacevalue(hashMapCardDashBoardItem, TWENTY, CARD_DEACTIVATE,
                itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.SOLD.code
              == itemCardType.getStatus().code) {
            sumFacevalue(hashMapCardDashBoardItem, TWENTY, CARD_SOLD, itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.EXPIRED.code
              == itemCardType.getStatus().code) {
            sumFacevalue(hashMapCardDashBoardItem, TWENTY, CARD_EXPIRED, itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.NEAR_EXP.code
              == itemCardType.getStatus().code) {
            sumFacevalue(hashMapCardDashBoardItem, TWENTY, CARD_PRE_EXPIRED,
                itemCardType.getTotal());
          }
          break;
        case 30000:
          if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.IN_STOCK.code == itemCardType
              .getStatus().code && Stage.ON == itemCardType.getStage()) {
            sumFacevalue(hashMapCardDashBoardItem, THIRTY, CARD_ACTIVATE, itemCardType.getTotal());

          } else if (
              vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.IN_STOCK.code == itemCardType
                  .getStatus().code && Stage.OFF == itemCardType
                  .getStage()) {
            sumFacevalue(hashMapCardDashBoardItem, THIRTY, CARD_DEACTIVATE,
                itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.SOLD.code
              == itemCardType.getStatus().code) {
            sumFacevalue(hashMapCardDashBoardItem, THIRTY, CARD_SOLD, itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.EXPIRED.code
              == itemCardType.getStatus().code) {
            sumFacevalue(hashMapCardDashBoardItem, THIRTY, CARD_EXPIRED, itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.NEAR_EXP.code
              == itemCardType.getStatus().code) {
            sumFacevalue(hashMapCardDashBoardItem, THIRTY, CARD_PRE_EXPIRED,
                itemCardType.getTotal());
          }
          break;
        case 50000:
          if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.IN_STOCK.code == itemCardType
              .getStatus().code && Stage.ON == itemCardType.getStage()) {
            sumFacevalue(hashMapCardDashBoardItem, FIFTY, CARD_ACTIVATE, itemCardType.getTotal());

          } else if (
              vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.IN_STOCK.code == itemCardType
                  .getStatus().code && Stage.OFF == itemCardType
                  .getStage()) {
            sumFacevalue(hashMapCardDashBoardItem, FIFTY, CARD_DEACTIVATE, itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.SOLD.code
              == itemCardType.getStatus().code) {
            sumFacevalue(hashMapCardDashBoardItem, FIFTY, CARD_SOLD, itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.EXPIRED.code
              == itemCardType.getStatus().code) {
            sumFacevalue(hashMapCardDashBoardItem, FIFTY, CARD_EXPIRED, itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.NEAR_EXP.code
              == itemCardType.getStatus().code) {
            sumFacevalue(hashMapCardDashBoardItem, FIFTY, CARD_PRE_EXPIRED,
                itemCardType.getTotal());
          }
          break;
        case 100000:
          if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.IN_STOCK.code == itemCardType
              .getStatus().code && Stage.ON == itemCardType.getStage()) {
            sumFacevalue(hashMapCardDashBoardItem, HUNDRED, CARD_ACTIVATE, itemCardType.getTotal());

          } else if (
              vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.IN_STOCK.code == itemCardType
                  .getStatus().code && Stage.OFF == itemCardType
                  .getStage()) {
            sumFacevalue(hashMapCardDashBoardItem, HUNDRED, CARD_DEACTIVATE,
                itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.SOLD.code
              == itemCardType.getStatus().code) {
            sumFacevalue(hashMapCardDashBoardItem, HUNDRED, CARD_SOLD, itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.EXPIRED.code
              == itemCardType.getStatus().code) {
            sumFacevalue(hashMapCardDashBoardItem, HUNDRED, CARD_EXPIRED, itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.NEAR_EXP.code
              == itemCardType.getStatus().code) {
            sumFacevalue(hashMapCardDashBoardItem, HUNDRED, CARD_PRE_EXPIRED,
                itemCardType.getTotal());
          }
          break;
        case 200000:
          if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.IN_STOCK.code == itemCardType
              .getStatus().code && Stage.ON == itemCardType.getStage()) {
            sumFacevalue(hashMapCardDashBoardItem, TWO_HUNDRED, CARD_ACTIVATE,
                itemCardType.getTotal());

          } else if (
              vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.IN_STOCK.code == itemCardType
                  .getStatus().code && Stage.OFF == itemCardType
                  .getStage()) {
            sumFacevalue(hashMapCardDashBoardItem, TWO_HUNDRED, CARD_DEACTIVATE,
                itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.SOLD.code
              == itemCardType.getStatus().code) {
            sumFacevalue(hashMapCardDashBoardItem, TWO_HUNDRED, CARD_SOLD, itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.EXPIRED.code
              == itemCardType.getStatus().code) {
            sumFacevalue(hashMapCardDashBoardItem, TWO_HUNDRED, CARD_EXPIRED,
                itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.NEAR_EXP.code
              == itemCardType.getStatus().code) {
            sumFacevalue(hashMapCardDashBoardItem, TWO_HUNDRED, CARD_PRE_EXPIRED,
                itemCardType.getTotal());
          }
          break;
        case 300000:
          if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.IN_STOCK.code == itemCardType
              .getStatus().code && Stage.ON == itemCardType.getStage()) {
            sumFacevalue(hashMapCardDashBoardItem, THREE_HUNDRED, CARD_ACTIVATE,
                itemCardType.getTotal());

          } else if (
              vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.IN_STOCK.code == itemCardType
                  .getStatus().code && Stage.OFF == itemCardType
                  .getStage()) {
            sumFacevalue(hashMapCardDashBoardItem, THREE_HUNDRED, CARD_DEACTIVATE,
                itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.SOLD.code
              == itemCardType.getStatus().code) {
            sumFacevalue(hashMapCardDashBoardItem, THREE_HUNDRED, CARD_SOLD,
                itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.EXPIRED.code
              == itemCardType.getStatus().code) {
            sumFacevalue(hashMapCardDashBoardItem, THREE_HUNDRED, CARD_EXPIRED,
                itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.NEAR_EXP.code
              == itemCardType.getStatus().code) {
            sumFacevalue(hashMapCardDashBoardItem, THREE_HUNDRED, CARD_PRE_EXPIRED,
                itemCardType.getTotal());
          }
          break;
        case 500000:
          if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.IN_STOCK.code == itemCardType
              .getStatus().code && Stage.ON == itemCardType.getStage()) {
            sumFacevalue(hashMapCardDashBoardItem, FIVE_HUNDRED, CARD_ACTIVATE,
                itemCardType.getTotal());

          } else if (
              vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.IN_STOCK.code == itemCardType
                  .getStatus().code && Stage.OFF == itemCardType
                  .getStage()) {
            sumFacevalue(hashMapCardDashBoardItem, FIVE_HUNDRED, CARD_DEACTIVATE,
                itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.SOLD.code
              == itemCardType.getStatus().code) {
            sumFacevalue(hashMapCardDashBoardItem, FIVE_HUNDRED, CARD_SOLD,
                itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.EXPIRED.code
              == itemCardType.getStatus().code) {
            sumFacevalue(hashMapCardDashBoardItem, FIVE_HUNDRED, CARD_EXPIRED,
                itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.NEAR_EXP.code
              == itemCardType.getStatus().code) {

            sumFacevalue(hashMapCardDashBoardItem, FIVE_HUNDRED, CARD_PRE_EXPIRED,
                itemCardType.getTotal());
          }
          break;

        case 1000000:
          if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.IN_STOCK.code == itemCardType
              .getStatus().code && Stage.ON == itemCardType.getStage()) {
            sumFacevalue(hashMapCardDashBoardItem, ONE_MINION, CARD_ACTIVATE,
                itemCardType.getTotal());

          } else if (
              vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.IN_STOCK.code == itemCardType
                  .getStatus().code && Stage.OFF == itemCardType
                  .getStage()) {
            sumFacevalue(hashMapCardDashBoardItem, ONE_MINION, CARD_DEACTIVATE,
                itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.SOLD.code
              == itemCardType.getStatus().code) {
            sumFacevalue(hashMapCardDashBoardItem, ONE_MINION, CARD_SOLD, itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.EXPIRED.code
              == itemCardType.getStatus().code) {
            sumFacevalue(hashMapCardDashBoardItem, ONE_MINION, CARD_EXPIRED,
                itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.NEAR_EXP.code
              == itemCardType.getStatus().code) {

            sumFacevalue(hashMapCardDashBoardItem, ONE_MINION, CARD_PRE_EXPIRED,
                itemCardType.getTotal());
          }
          break;

        case 2000000:
          if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.IN_STOCK.code == itemCardType
              .getStatus().code && Stage.ON == itemCardType.getStage()) {
            sumFacevalue(hashMapCardDashBoardItem, TWO_MINION, CARD_ACTIVATE,
                itemCardType.getTotal());

          } else if (
              vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.IN_STOCK.code == itemCardType
                  .getStatus().code && Stage.OFF == itemCardType
                  .getStage()) {
            sumFacevalue(hashMapCardDashBoardItem, TWO_MINION, CARD_DEACTIVATE,
                itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.SOLD.code
              == itemCardType.getStatus().code) {
            sumFacevalue(hashMapCardDashBoardItem, TWO_MINION, CARD_SOLD, itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.EXPIRED.code
              == itemCardType.getStatus().code) {
            sumFacevalue(hashMapCardDashBoardItem, TWO_MINION, CARD_EXPIRED,
                itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.NEAR_EXP.code
              == itemCardType.getStatus().code) {

            sumFacevalue(hashMapCardDashBoardItem, TWO_MINION, CARD_PRE_EXPIRED,
                itemCardType.getTotal());
          }
          break;
        case 5000000:
          if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.IN_STOCK.code == itemCardType
              .getStatus().code && Stage.ON == itemCardType.getStage()) {
            sumFacevalue(hashMapCardDashBoardItem, FIVE_MINION, CARD_ACTIVATE,
                itemCardType.getTotal());

          } else if (
              vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.IN_STOCK.code == itemCardType
                  .getStatus().code && Stage.OFF == itemCardType
                  .getStage()) {
            sumFacevalue(hashMapCardDashBoardItem, FIVE_MINION, CARD_DEACTIVATE,
                itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.SOLD.code
              == itemCardType.getStatus().code) {
            sumFacevalue(hashMapCardDashBoardItem, FIVE_MINION, CARD_SOLD, itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.EXPIRED.code
              == itemCardType.getStatus().code) {
            sumFacevalue(hashMapCardDashBoardItem, FIVE_MINION, CARD_EXPIRED,
                itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.NEAR_EXP.code
              == itemCardType.getStatus().code) {

            sumFacevalue(hashMapCardDashBoardItem, FIVE_MINION, CARD_PRE_EXPIRED,
                itemCardType.getTotal());
          }
          break;
                /* Data code*/
        case 1000:
          if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.IN_STOCK.code == itemCardType
              .getStatus().code && Stage.ON == itemCardType.getStage()) {
            sumFacevalue(hashMapCardDashBoardItem, ONE, CARD_ACTIVATE, itemCardType.getTotal());

          } else if (
              vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.IN_STOCK.code == itemCardType
                  .getStatus().code && Stage.OFF == itemCardType
                  .getStage()) {
            sumFacevalue(hashMapCardDashBoardItem, ONE, CARD_DEACTIVATE, itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.SOLD.code
              == itemCardType.getStatus().code) {
            sumFacevalue(hashMapCardDashBoardItem, ONE, CARD_SOLD, itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.EXPIRED.code
              == itemCardType.getStatus().code) {
            sumFacevalue(hashMapCardDashBoardItem, ONE, CARD_EXPIRED, itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.NEAR_EXP.code
              == itemCardType.getStatus().code) {

            sumFacevalue(hashMapCardDashBoardItem, ONE, CARD_PRE_EXPIRED, itemCardType.getTotal());
          }
          break;

        case 2000:
          if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.IN_STOCK.code == itemCardType
              .getStatus().code && Stage.ON == itemCardType.getStage()) {
            sumFacevalue(hashMapCardDashBoardItem, TWO, CARD_ACTIVATE, itemCardType.getTotal());

          } else if (
              vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.IN_STOCK.code == itemCardType
                  .getStatus().code && Stage.OFF == itemCardType
                  .getStage()) {
            sumFacevalue(hashMapCardDashBoardItem, TWO, CARD_DEACTIVATE, itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.SOLD.code
              == itemCardType.getStatus().code) {
            sumFacevalue(hashMapCardDashBoardItem, TWO, CARD_SOLD, itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.EXPIRED.code
              == itemCardType.getStatus().code) {
            sumFacevalue(hashMapCardDashBoardItem, TWO, CARD_EXPIRED, itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.NEAR_EXP.code
              == itemCardType.getStatus().code) {

            sumFacevalue(hashMapCardDashBoardItem, TWO, CARD_PRE_EXPIRED, itemCardType.getTotal());
          }
          break;

        case 3000:
          if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.IN_STOCK.code == itemCardType
              .getStatus().code && Stage.ON == itemCardType.getStage()) {
            sumFacevalue(hashMapCardDashBoardItem, THREE, CARD_ACTIVATE, itemCardType.getTotal());

          } else if (
              vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.IN_STOCK.code == itemCardType
                  .getStatus().code && Stage.OFF == itemCardType
                  .getStage()) {
            sumFacevalue(hashMapCardDashBoardItem, THREE, CARD_DEACTIVATE, itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.SOLD.code
              == itemCardType.getStatus().code) {
            sumFacevalue(hashMapCardDashBoardItem, THREE, CARD_SOLD, itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.EXPIRED.code
              == itemCardType.getStatus().code) {
            sumFacevalue(hashMapCardDashBoardItem, THREE, CARD_EXPIRED, itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.NEAR_EXP.code
              == itemCardType.getStatus().code) {

            sumFacevalue(hashMapCardDashBoardItem, THREE, CARD_PRE_EXPIRED,
                itemCardType.getTotal());
          }
          break;

        case 5000:
          if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.IN_STOCK.code == itemCardType
              .getStatus().code && Stage.ON == itemCardType.getStage()) {
            sumFacevalue(hashMapCardDashBoardItem, FIVE, CARD_ACTIVATE, itemCardType.getTotal());

          } else if (
              vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.IN_STOCK.code == itemCardType
                  .getStatus().code && Stage.OFF == itemCardType
                  .getStage()) {
            sumFacevalue(hashMapCardDashBoardItem, FIVE, CARD_DEACTIVATE, itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.SOLD.code
              == itemCardType.getStatus().code) {
            sumFacevalue(hashMapCardDashBoardItem, FIVE, CARD_SOLD, itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.EXPIRED.code
              == itemCardType.getStatus().code) {
            sumFacevalue(hashMapCardDashBoardItem, FIVE, CARD_EXPIRED, itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.NEAR_EXP.code
              == itemCardType.getStatus().code) {

            sumFacevalue(hashMapCardDashBoardItem, FIVE, CARD_PRE_EXPIRED, itemCardType.getTotal());
          }
          break;

        case 14000:
          if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.IN_STOCK.code == itemCardType
              .getStatus().code && Stage.ON == itemCardType.getStage()) {
            sumFacevalue(hashMapCardDashBoardItem, FOUR_TEENTH, CARD_ACTIVATE,
                itemCardType.getTotal());

          } else if (
              vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.IN_STOCK.code == itemCardType
                  .getStatus().code && Stage.OFF == itemCardType
                  .getStage()) {
            sumFacevalue(hashMapCardDashBoardItem, FOUR_TEENTH, CARD_DEACTIVATE,
                itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.SOLD.code
              == itemCardType.getStatus().code) {
            sumFacevalue(hashMapCardDashBoardItem, FOUR_TEENTH, CARD_SOLD, itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.EXPIRED.code
              == itemCardType.getStatus().code) {
            sumFacevalue(hashMapCardDashBoardItem, FOUR_TEENTH, CARD_EXPIRED,
                itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.NEAR_EXP.code
              == itemCardType.getStatus().code) {

            sumFacevalue(hashMapCardDashBoardItem, FOUR_TEENTH, CARD_PRE_EXPIRED,
                itemCardType.getTotal());
          }
          break;

        case 28000:
          if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.IN_STOCK.code == itemCardType
              .getStatus().code && Stage.ON == itemCardType.getStage()) {
            sumFacevalue(hashMapCardDashBoardItem, TWENTY_EIGHTH, CARD_ACTIVATE,
                itemCardType.getTotal());

          } else if (
              vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.IN_STOCK.code == itemCardType
                  .getStatus().code && Stage.OFF == itemCardType
                  .getStage()) {
            sumFacevalue(hashMapCardDashBoardItem, TWENTY_EIGHTH, CARD_DEACTIVATE,
                itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.SOLD.code
              == itemCardType.getStatus().code) {
            sumFacevalue(hashMapCardDashBoardItem, TWENTY_EIGHTH, CARD_SOLD,
                itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.EXPIRED.code
              == itemCardType.getStatus().code) {
            sumFacevalue(hashMapCardDashBoardItem, TWENTY_EIGHTH, CARD_EXPIRED,
                itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.NEAR_EXP.code
              == itemCardType.getStatus().code) {

            sumFacevalue(hashMapCardDashBoardItem, TWENTY_EIGHTH, CARD_PRE_EXPIRED,
                itemCardType.getTotal());
          }
          break;

        case 42000:
          if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.IN_STOCK.code == itemCardType
              .getStatus().code && Stage.ON == itemCardType.getStage()) {
            sumFacevalue(hashMapCardDashBoardItem, FOURTY_SECOND, CARD_ACTIVATE,
                itemCardType.getTotal());

          } else if (
              vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.IN_STOCK.code == itemCardType
                  .getStatus().code && Stage.OFF == itemCardType
                  .getStage()) {
            sumFacevalue(hashMapCardDashBoardItem, FOURTY_SECOND, CARD_DEACTIVATE,
                itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.SOLD.code
              == itemCardType.getStatus().code) {
            sumFacevalue(hashMapCardDashBoardItem, FOURTY_SECOND, CARD_SOLD,
                itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.EXPIRED.code
              == itemCardType.getStatus().code) {
            sumFacevalue(hashMapCardDashBoardItem, FOURTY_SECOND, CARD_EXPIRED,
                itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.NEAR_EXP.code
              == itemCardType.getStatus().code) {

            sumFacevalue(hashMapCardDashBoardItem, FOURTY_SECOND, CARD_PRE_EXPIRED,
                itemCardType.getTotal());
          }
          break;

        case 56000:
          if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.IN_STOCK.code == itemCardType
              .getStatus().code && Stage.ON == itemCardType.getStage()) {
            sumFacevalue(hashMapCardDashBoardItem, FIFTY_SIX, CARD_ACTIVATE,
                itemCardType.getTotal());

          } else if (
              vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.IN_STOCK.code == itemCardType
                  .getStatus().code && Stage.OFF == itemCardType
                  .getStage()) {
            sumFacevalue(hashMapCardDashBoardItem, FIFTY_SIX, CARD_DEACTIVATE,
                itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.SOLD.code
              == itemCardType.getStatus().code) {
            sumFacevalue(hashMapCardDashBoardItem, FIFTY_SIX, CARD_SOLD, itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.EXPIRED.code
              == itemCardType.getStatus().code) {
            sumFacevalue(hashMapCardDashBoardItem, FIFTY_SIX, CARD_EXPIRED,
                itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.NEAR_EXP.code
              == itemCardType.getStatus().code) {

            sumFacevalue(hashMapCardDashBoardItem, FIFTY_SIX, CARD_PRE_EXPIRED,
                itemCardType.getTotal());
          }
          break;

        case 84000:
          if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.IN_STOCK.code == itemCardType
              .getStatus().code && Stage.ON == itemCardType.getStage()) {
            sumFacevalue(hashMapCardDashBoardItem, EIGHTY_FOUR, CARD_ACTIVATE,
                itemCardType.getTotal());

          } else if (
              vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.IN_STOCK.code == itemCardType
                  .getStatus().code && Stage.OFF == itemCardType
                  .getStage()) {
            sumFacevalue(hashMapCardDashBoardItem, EIGHTY_FOUR, CARD_DEACTIVATE,
                itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.SOLD.code
              == itemCardType.getStatus().code) {
            sumFacevalue(hashMapCardDashBoardItem, EIGHTY_FOUR, CARD_SOLD, itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.EXPIRED.code
              == itemCardType.getStatus().code) {
            sumFacevalue(hashMapCardDashBoardItem, EIGHTY_FOUR, CARD_EXPIRED,
                itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.NEAR_EXP.code
              == itemCardType.getStatus().code) {

            sumFacevalue(hashMapCardDashBoardItem, EIGHTY_FOUR, CARD_PRE_EXPIRED,
                itemCardType.getTotal());
          }
          break;

        case 70000:
          if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.IN_STOCK.code == itemCardType
              .getStatus().code && Stage.ON == itemCardType.getStage()) {
            sumFacevalue(hashMapCardDashBoardItem, SEVEN_TY, CARD_ACTIVATE,
                itemCardType.getTotal());

          } else if (
              vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.IN_STOCK.code == itemCardType
                  .getStatus().code && Stage.OFF == itemCardType
                  .getStage()) {
            sumFacevalue(hashMapCardDashBoardItem, SEVEN_TY, CARD_DEACTIVATE,
                itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.SOLD.code
              == itemCardType.getStatus().code) {
            sumFacevalue(hashMapCardDashBoardItem, SEVEN_TY, CARD_SOLD, itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.EXPIRED.code
              == itemCardType.getStatus().code) {
            sumFacevalue(hashMapCardDashBoardItem, SEVEN_TY, CARD_EXPIRED, itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.NEAR_EXP.code
              == itemCardType.getStatus().code) {

            sumFacevalue(hashMapCardDashBoardItem, SEVEN_TY, CARD_PRE_EXPIRED,
                itemCardType.getTotal());
          }
          break;

        case 120000:
          if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.IN_STOCK.code == itemCardType
              .getStatus().code && Stage.ON == itemCardType.getStage()) {
            sumFacevalue(hashMapCardDashBoardItem, ONE_HUNDRED_TWELVE, CARD_ACTIVATE,
                itemCardType.getTotal());

          } else if (
              vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.IN_STOCK.code == itemCardType
                  .getStatus().code && Stage.OFF == itemCardType
                  .getStage()) {
            sumFacevalue(hashMapCardDashBoardItem, ONE_HUNDRED_TWELVE, CARD_DEACTIVATE,
                itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.SOLD.code
              == itemCardType.getStatus().code) {
            sumFacevalue(hashMapCardDashBoardItem, ONE_HUNDRED_TWELVE, CARD_SOLD,
                itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.EXPIRED.code
              == itemCardType.getStatus().code) {
            sumFacevalue(hashMapCardDashBoardItem, ONE_HUNDRED_TWELVE, CARD_EXPIRED,
                itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.NEAR_EXP.code
              == itemCardType.getStatus().code) {

            sumFacevalue(hashMapCardDashBoardItem, ONE_HUNDRED_TWELVE, CARD_PRE_EXPIRED,
                itemCardType.getTotal());
          }
          break;

        case 150000:
          if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.IN_STOCK.code == itemCardType
              .getStatus().code && Stage.ON == itemCardType.getStage()) {
            sumFacevalue(hashMapCardDashBoardItem, ONE_HUNDRED_FIFTEEN, CARD_ACTIVATE,
                itemCardType.getTotal());

          } else if (
              vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.IN_STOCK.code == itemCardType
                  .getStatus().code && Stage.OFF == itemCardType
                  .getStage()) {
            sumFacevalue(hashMapCardDashBoardItem, ONE_HUNDRED_FIFTEEN, CARD_DEACTIVATE,
                itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.SOLD.code
              == itemCardType.getStatus().code) {
            sumFacevalue(hashMapCardDashBoardItem, ONE_HUNDRED_FIFTEEN, CARD_SOLD,
                itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.EXPIRED.code
              == itemCardType.getStatus().code) {
            sumFacevalue(hashMapCardDashBoardItem, ONE_HUNDRED_FIFTEEN, CARD_EXPIRED,
                itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.NEAR_EXP.code
              == itemCardType.getStatus().code) {

            sumFacevalue(hashMapCardDashBoardItem, ONE_HUNDRED_FIFTEEN, CARD_PRE_EXPIRED,
                itemCardType.getTotal());
          }
          break;

        case 40000:
          if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.IN_STOCK.code == itemCardType
              .getStatus().code && Stage.ON == itemCardType.getStage()) {
            sumFacevalue(hashMapCardDashBoardItem, FORTY, CARD_ACTIVATE, itemCardType.getTotal());

          } else if (
              vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.IN_STOCK.code == itemCardType
                  .getStatus().code && Stage.OFF == itemCardType
                  .getStage()) {
            sumFacevalue(hashMapCardDashBoardItem, FORTY, CARD_DEACTIVATE,
                itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.SOLD.code
              == itemCardType.getStatus().code) {
            sumFacevalue(hashMapCardDashBoardItem, FORTY, CARD_SOLD, itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.EXPIRED.code
              == itemCardType.getStatus().code) {
            sumFacevalue(hashMapCardDashBoardItem, FORTY, CARD_EXPIRED, itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.NEAR_EXP.code
              == itemCardType.getStatus().code) {
            sumFacevalue(hashMapCardDashBoardItem, FORTY, CARD_PRE_EXPIRED,
                itemCardType.getTotal());
          }
          break;

        case 90000:
          if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.IN_STOCK.code == itemCardType
              .getStatus().code && Stage.ON == itemCardType.getStage()) {
            sumFacevalue(hashMapCardDashBoardItem, NINETY, CARD_ACTIVATE, itemCardType.getTotal());

          } else if (
              vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.IN_STOCK.code == itemCardType
                  .getStatus().code && Stage.OFF == itemCardType
                  .getStage()) {
            sumFacevalue(hashMapCardDashBoardItem, NINETY, CARD_DEACTIVATE,
                itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.SOLD.code
              == itemCardType.getStatus().code) {
            sumFacevalue(hashMapCardDashBoardItem, NINETY, CARD_SOLD, itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.EXPIRED.code
              == itemCardType.getStatus().code) {
            sumFacevalue(hashMapCardDashBoardItem, NINETY, CARD_EXPIRED, itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.NEAR_EXP.code
              == itemCardType.getStatus().code) {
            sumFacevalue(hashMapCardDashBoardItem, NINETY, CARD_PRE_EXPIRED,
                itemCardType.getTotal());
          }
          break;

        case 125000:
          if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.IN_STOCK.code == itemCardType
              .getStatus().code && Stage.ON == itemCardType.getStage()) {
            sumFacevalue(hashMapCardDashBoardItem, ONE_HUNDRED_TWENTY_FIVE, CARD_ACTIVATE, itemCardType.getTotal());

          } else if (
              vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.IN_STOCK.code == itemCardType
                  .getStatus().code && Stage.OFF == itemCardType
                  .getStage()) {
            sumFacevalue(hashMapCardDashBoardItem, ONE_HUNDRED_TWENTY_FIVE, CARD_DEACTIVATE,
                itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.SOLD.code
              == itemCardType.getStatus().code) {
            sumFacevalue(hashMapCardDashBoardItem, ONE_HUNDRED_TWENTY_FIVE, CARD_SOLD, itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.EXPIRED.code
              == itemCardType.getStatus().code) {
            sumFacevalue(hashMapCardDashBoardItem, ONE_HUNDRED_TWENTY_FIVE, CARD_EXPIRED, itemCardType.getTotal());

          } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.NEAR_EXP.code
              == itemCardType.getStatus().code) {
            sumFacevalue(hashMapCardDashBoardItem, ONE_HUNDRED_TWENTY_FIVE, CARD_PRE_EXPIRED,
                itemCardType.getTotal());
          }
          break;

        default:
          break;
      }
    }

    for (Map.Entry<String, JSONObject> item : hashMapCardDashBoardItem.entrySet()) {
      JSONObject value = item.getValue();
      value.put(CARD_INPUTTED, (value.isNull(CARD_SOLD) ? 0L : value.getLong(CARD_SOLD)) +
          (value.isNull(CARD_ACTIVATE) ? 0L : value.getLong(CARD_ACTIVATE)) +
          (value.isNull(CARD_DEACTIVATE) ? 0L : value.getLong(CARD_DEACTIVATE)));
      hashMapCardDashBoardItem.put(item.getKey(), value);
    }

    return hashMapCardDashBoardItem;
  }

  private void sumFacevalue(HashMap<String, JSONObject> hashMap, String faceValue, String cardType,
      long total) {
    if (hashMap.containsKey(faceValue)) {
      JSONObject jFaceValue = hashMap.get(faceValue);
      if (jFaceValue.isNull(cardType)) {
        jFaceValue.put(cardType, total);
      } else {
        long aLong = jFaceValue.getLong(cardType);
        aLong += total;
        jFaceValue.put(cardType, aLong);
      }
      hashMap.put(faceValue, jFaceValue);
    } else {
      JSONObject jCardType = new JSONObject();
      jCardType.put(cardType, total);
      hashMap.put(faceValue, jCardType);
    }
  }

  /**
   * chartFollowStatus đếm số lượng thẻ, INPUT CARD	, ... trên 1 face value, trên 1nhà mạng trong
   * màn hình tổng quát, hàng 1
   */
  private HashMap<String, JSONObject> sumCountData(List<CardDashBoardItem> items) {

    HashMap<String, JSONObject> hashMap = new HashMap<>();

    Long numberSold = 0L;
    Long valueSold = 0L;
    Long capitalSold = 0L;

    Long numberActivate = 0L;
    Long valueActivate = 0L;
    Long capitalActivate = 0L;

    Long numberDeactivate = 0L;
    Long valueDeactivate = 0L;
    Long capitalDeactivate = 0L;

    Long numberNearExpired = 0L;
    Long valueNearExpired = 0L;
    Long capitalNearExpired = 0L;

    Long numberExpired = 0L;
    Long valueExpired = 0L;
    Long capitalExpired = 0L;

    for (CardDashBoardItem item : items) {
      if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.IN_STOCK.code == item
          .getStatus().code && Stage.ON == item.getStage()) {
        numberActivate += item.getTotal();
        valueActivate += item.getFaceValue() * item.getTotal();
        capitalActivate += item.getCapital();

      } else if (
          vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.IN_STOCK.code == item
              .getStatus().code && Stage.OFF == item.getStage()) {
        numberDeactivate += item.getTotal();
        valueDeactivate += item.getFaceValue() * item.getTotal();
        capitalDeactivate += item.getCapital();

      } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.SOLD.code == item
          .getStatus().code) {
        numberSold += item.getTotal();
        valueSold += item.getFaceValue() * item.getTotal();
        capitalSold += item.getCapital();

      } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.EXPIRED.code == item
          .getStatus().code) {
        numberExpired += item.getTotal();
        valueExpired += item.getFaceValue() * item.getTotal();
        capitalExpired += item.getCapital();

      } else if (vn.mog.ewallet.web.controller.dashboard.beans.CardStatus.NEAR_EXP.code == item
          .getStatus().code) {
        numberNearExpired += item.getTotal();
        valueNearExpired += item.getFaceValue() * item.getTotal();
        capitalNearExpired += item.getCapital();
      }
    }
    Long numberInputted = numberActivate + numberDeactivate + numberSold;
    Long valueInputted = valueActivate + valueDeactivate + valueSold;
    Long capitalInputted = capitalActivate + capitalDeactivate + capitalSold;

    JSONObject cardInputted = new JSONObject();
    cardInputted.put(NUMBER, numberInputted);
    cardInputted.put(VALUE, valueInputted);
    cardInputted.put(CAPITAL, capitalInputted);

    JSONObject cardSold = new JSONObject();
    cardSold.put(NUMBER, numberSold);
    cardSold.put(VALUE, valueSold);
    cardSold.put(CAPITAL, capitalSold);

    JSONObject cardActivate = new JSONObject();
    cardActivate.put(NUMBER, numberActivate);
    cardActivate.put(VALUE, valueActivate);
    cardActivate.put(CAPITAL, capitalActivate);

    JSONObject cardDeactivate = new JSONObject();
    cardDeactivate.put(NUMBER, numberDeactivate);
    cardDeactivate.put(VALUE, valueDeactivate);
    cardDeactivate.put(CAPITAL, capitalDeactivate);

    JSONObject cardExpired = new JSONObject();
    cardExpired.put(NUMBER, numberExpired);
    cardExpired.put(VALUE, valueExpired);
    cardExpired.put(CAPITAL, capitalExpired);

    JSONObject cardPreExpired = new JSONObject();
    cardPreExpired.put(NUMBER, numberNearExpired);
    cardPreExpired.put(VALUE, valueNearExpired);
    cardPreExpired.put(CAPITAL, capitalNearExpired);

    hashMap.put(CARD_INPUTTED, cardInputted);
    hashMap.put(CARD_SOLD, cardSold);
    hashMap.put(CARD_ACTIVATE, cardActivate);
    hashMap.put(CARD_DEACTIVATE, cardDeactivate);
    hashMap.put(CARD_EXPIRED, cardExpired);
    hashMap.put(CARD_PRE_EXPIRED, cardPreExpired);

    return hashMap;

  }
}