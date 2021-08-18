package vn.mog.ewallet.web.controller.po;

import static vn.mog.ewallet.constant.RoleConstants.ADMIN_OPERATION;
import static vn.mog.ewallet.constant.RoleConstants.CUSTOMERCARE;
import static vn.mog.ewallet.constant.RoleConstants.CUSTOMERCARE_MANAGER;
import static vn.mog.ewallet.constant.RoleConstants.FA_MANAGER;
import static vn.mog.ewallet.constant.RoleConstants.FINANCE;
import static vn.mog.ewallet.constant.RoleConstants.FINANCESUPPORT_LEADER;
import static vn.mog.ewallet.constant.RoleConstants.FINANCE_LEADER;
import static vn.mog.ewallet.constant.RoleConstants.RECONCILIATION;
import static vn.mog.ewallet.constant.RoleConstants.RECONCILIATION_LEADER;
import static vn.mog.ewallet.constant.RoleConstants.SALESUPPORT;
import static vn.mog.ewallet.constant.RoleConstants.SALESUPPORT_LEADER;
import static vn.mog.ewallet.constant.RoleConstants.SALESUPPORT_MANAGER;
import static vn.mog.ewallet.constant.RoleConstants.SALE_DIRECTOR;
import static vn.mog.ewallet.exception.MessageNotify.ERROR_CODE;
import static vn.mog.ewallet.exception.MessageNotify.SESSION_MESSAGE_NOTIFY;
import static vn.mog.ewallet.exception.MessageNotify.SUCCESS_CODE;
import static vn.mog.ewallet.web.utils.ValidationUtil.MESAGE_ERROR;
import static vn.mog.ewallet.web.utils.ValidationUtil.MESAGE_ERROR_EPIN_FOLLOW;
import static vn.mog.ewallet.web.utils.ValidationUtil.MESAGE_ERROR_EPIN_FOLLOW_PARAM;
import static vn.mog.ewallet.web.utils.ValidationUtil.MESAGE_SUCCESS;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Base64;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.ArrayUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.LoggerFactory;
import org.springframework.core.io.ClassPathResource;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import vn.mog.ewallet.contract.epin.store.ChangePurchaseOrderStatusRequest;
import vn.mog.ewallet.contract.epin.store.ChangePurchaseOrderStatusResponse;
import vn.mog.ewallet.contract.epin.store.CreateAttachmentRequest;
import vn.mog.ewallet.contract.epin.store.CreateAttachmentResponse;
import vn.mog.ewallet.contract.epin.store.CreateFullPurchaseOrderRequest;
import vn.mog.ewallet.contract.epin.store.CreateFullPurchaseOrderResponse;
import vn.mog.ewallet.contract.epin.store.FindProviderProfileRequest;
import vn.mog.ewallet.contract.epin.store.FindProviderProfileResponse;
import vn.mog.ewallet.contract.epin.store.FindPurchaseOrderRequest;
import vn.mog.ewallet.contract.epin.store.FindPurchaseOrderResponse;
import vn.mog.ewallet.contract.epin.store.FindSpecialCustomerRequest;
import vn.mog.ewallet.contract.epin.store.FindSpecialCustomerResponse;
import vn.mog.ewallet.contract.epin.store.GetPurchaseOrderRequest;
import vn.mog.ewallet.contract.epin.store.GetPurchaseOrderResponse;
import vn.mog.ewallet.contract.epin.store.TransferPOToGeneralStoreRequest;
import vn.mog.ewallet.contract.epin.store.TransferPOToGeneralStoreResponse;
import vn.mog.ewallet.contract.epin.store.TransferPOToOtherCustomerRequest;
import vn.mog.ewallet.contract.epin.store.TransferPOToOtherCustomerResponse;
import vn.mog.ewallet.contract.epin.store.UpdatePurchaseOrderRequest;
import vn.mog.ewallet.contract.epin.store.UpdatePurchaseOrderResponse;
import vn.mog.ewallet.contract.epin.store.VerifyPurchaseOrderFileRequest;
import vn.mog.ewallet.contract.epin.store.VerifyPurchaseOrderFileResponse;
import vn.mog.ewallet.contract.epin.store.beans.Attachment;
import vn.mog.ewallet.contract.epin.store.beans.POFileCompareResult;
import vn.mog.ewallet.contract.epin.store.beans.PurchaseOrderDetailItem;
import vn.mog.ewallet.contract.epin.store.beans.PurchaseOrderItem;
import vn.mog.ewallet.contract.epin.store.beans.SpecialCustomerItem;
import vn.mog.ewallet.contract.epin.store.follow.PurchaseOrderFlowApproveRequest;
import vn.mog.ewallet.contract.epin.store.follow.PurchaseOrderFlowApproveResponse;
import vn.mog.ewallet.contract.epin.store.follow.PurchaseOrderFlowRejectRequest;
import vn.mog.ewallet.contract.epin.store.follow.PurchaseOrderFlowRejectResponse;
import vn.mog.ewallet.contract.epin.store.follow.PurchaseOrderFlowStartProcessRequest;
import vn.mog.ewallet.contract.epin.store.follow.PurchaseOrderFlowStartProcessResponse;
import vn.mog.ewallet.contract.epin.store.follow.PurchaseOrderFlowSubmitProcessRequest;
import vn.mog.ewallet.contract.epin.store.follow.PurchaseOrderFlowSubmitProcessResponse;
import vn.mog.ewallet.exception.FrontEndException;
import vn.mog.ewallet.exception.MessageNotify;
import vn.mog.ewallet.web.contract.AjaxResponse;
import vn.mog.ewallet.web.controller.AbstractController;
import vn.mog.ewallet.web.controller.dashboard.beans.UpType;
import vn.mog.ewallet.web.controller.po.beans.WorkflowState;
import vn.mog.ewallet.web.utils.FileCompareUtil;
import vn.mog.framework.common.utils.NumberUtil;
import vn.mog.framework.common.utils.SessionUtil;
import vn.mog.framework.contract.base.KeyValue;

@Controller
@RequestMapping(value = "/provider/purchase-order")
public class PurchaseOrderController extends AbstractController {

  private static final org.slf4j.Logger LOGGER = LoggerFactory
      .getLogger(PurchaseOrderController.class);
  private static String EPAY = "/templatefile/EPAY.xls";
  private static String ZOTA = "/templatefile/ZOTA.xlsx";
  private static String VIETTEL = "/templatefile/VIETTEL.txt";
  private static String VNTP = "/templatefile/VNTP.xlsx";
  private static String VTC = "/templatefile/VTC.txt";
  private static String MOBIFONE = "/templatefile/MOBIFONE.dat";
  private static String VINPLAY = "/templatefile/VINPLAY.txt";
  private static String TPTELECOM = "/templatefile/TPTELECOM.txt";
  private static String VNPT = "/templatefile/VNPT.txt";
  private static String VMG = "/templatefile/VMG.csv";
  private static String IMEDIA = "/templatefile/IMEDIA.csv";

  private static String EPAY_NAME = "EPAY";
  private static String ZOTA_NAME = "ZOTA";
  private static String VIETTEL_NAME = "VIETTEL";
  private static String VNTP_NAME = "VNTP";
  private static String VTC_NAME = "VTC";
  private static String MOBIFONE_NAME = "MOBIFONE";
  private static String VINPLAY_NAME = "VINPLAY";
  private static String DATA_VINAPHONE_NAME = "DATA_VINAPHONE";
  private static String DATA_MOBIFONE_NAME = "DATA_MOBIFONE";
  private static String DT_VTM_NAME = "DATA_VIETTEL";
  private static String VNPT_NAME = "VNPT";
  private static String ZOPAY_NAME = "ZOPAY";
  private static String VPAY_NAME = "VPAY";
  private static String IMEDIA_NAME = "IMEDIA";
  private static String IOMEDIA_NAME = "IOMEDIA";
  private static String THANHSON_NAME = "THANHSON";

  public static final String PURCHASE_ORDER_LIST = "/provider/purchase-order/list";

  private MessageNotify message;

  private static final String TEXT_PLAIN = "text/plain";
  private static final String APPLICATION_VND_MS_EXCEL = "application/vnd.ms-excel";
  private static final String APPLICATION_VND_MS_EXCEL_XLSX = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";

  private static final String PO_TYPES_RQP = "poTypes";
  private static final String PROVIDER_RQP = "provider";
  private static final String LIST_PROVIDER_RQP = "listProvider";
  private static final String PO_CODE_RQP = "poCode";
  private static final String RESPONSE_PO_RQP = "responsePO";
  private static final String PASSW_RQP = "password";
  private static final String ACTION_RQP = "action";


  private static final String REDIRECT = "redirect:";

  private static final String MESERR_MODELMAP = "mesErr";
  private static final String CODE_ERR_MODELMAP = "codeErr";

  private static final String PAGE_PURCHASE_MANAGER_DECLARE_PO = "/purchase_manager/declare_po";
  private static final String PAGE_PURCHASE_MANAGER_UPLOAD_FILE = "/purchase_manager/upload_file";
  private static final String PAGE_PURCHASE_MANAGER_EDIT_DECLARE_PO = "/purchase_manager/edit_declare_po";

  private static final String CHECKBOX_SPECIAL_CARD_ATTRIBUTE = "checkBoxSpecialCard";

  @RequestMapping(value = "/list", method = RequestMethod.GET)
  @PreAuthorize("hasAnyRole('" + ADMIN_OPERATION + "','"
      + FINANCESUPPORT_LEADER + "','" + FINANCE + "','" + FINANCE_LEADER + "','" + FA_MANAGER
      + "','"
      + SALESUPPORT + "','" + SALESUPPORT_MANAGER + "','" + SALESUPPORT_LEADER + "','"
      + SALE_DIRECTOR + "','"
      + RECONCILIATION + "','" + RECONCILIATION_LEADER + "','" + CUSTOMERCARE + "','"
      + CUSTOMERCARE_MANAGER + "')")
  public String purchaseOrderList(HttpServletRequest request, ModelMap model)
      throws FrontEndException {

    try {
      List<SpecialCustomerItem> specialCustomers = new ArrayList<>();

      FindSpecialCustomerResponse merchantRes = epinStoreEndpoint
          .getPrivateMerchant(new FindSpecialCustomerRequest());
      if (merchantRes != null && merchantRes.getStatus().getCode() == 0) {
        specialCustomers = merchantRes.getSpecialCustomerList();
      }

      String specialCard = request.getParameter("specialCard");
      String specialMerchant = request.getParameter("specialCustomer");
      String[] provider = request.getParameterValues(PROVIDER_RQP);
      String quickSearch = request.getParameter("id");
      String[] status = request.getParameterValues("status");
      String[] poType = request.getParameterValues(PO_TYPES_RQP);
      int[] workflowState = ServletRequestUtils.getIntParameters(request, "workflowState");
      String searchRange = request.getParameter("range");

      int limit = 20;
      int offset = 0;
      if (request.getParameter("d-49520-p") != null) {
        Integer p = Integer.parseInt(request.getParameter("d-49520-p"));
        offset = limit * (p - 1);
      }

      FindPurchaseOrderRequest fpoRequest = new FindPurchaseOrderRequest();
//      if (StringUtils.isNotBlank(searchRange)) {
        Date[] dates = parseDateRange(searchRange,false);
        fpoRequest.setFromDate(dates[0]);
        fpoRequest.setEndDate(dates[1]);
//      }

      if (provider != null && provider.length > 0 && !provider[0].equals(StringUtils.EMPTY)) {
        fpoRequest.setProvider(Arrays.asList(provider));
      }
      if (status != null && status.length > 0 && !status[0].equals(StringUtils.EMPTY)) {
        fpoRequest.setStatus(Arrays.asList(status));
      }
      if (poType != null && poType.length > 0 && !poType[0].equals(StringUtils.EMPTY)) {
        fpoRequest.setUpTypes(NumberUtil.convertListToInt(poType));
      }
      if (workflowState != null && workflowState.length > 0) {
        fpoRequest.setWorkflowState(Arrays.asList(ArrayUtils.toObject(workflowState)));
      }

      if(specialCard !=null && specialCard.equals("0")){
        fpoRequest.setIsPrivate(false);
      } else if(specialCard !=null && specialCard.equals("1")){
        fpoRequest.setIsPrivate(true);
      }

      fpoRequest.setSpecialMcCif(specialMerchant);
      fpoRequest.setQuickSearch(StringUtils.trimToNull(quickSearch));
      fpoRequest.setLimit(limit);
      fpoRequest.setOffset(offset);

      FindPurchaseOrderResponse fpoResponse = epinStoreEndpoint.findPurchaseOrders(fpoRequest);

      Long totalOfMoney = fpoResponse.getAmount();
      Long totalOfCapital = fpoResponse.getCapital();

      model.put(LIST_PROVIDER_RQP, epinStoreEndpoint.listProvider());
      model.put("listWorkflow", WorkflowState.values());
      model.put("listStatus", epinStoreEndpoint.listPOStatus());
      model.put("listUpType", UpType.FULL_UP_TYPE);

      model.put("pagesize", limit);
      model.put("offset", offset);
      model.put("list", fpoResponse.getPurchaseOrders());
      model.put("total", fpoResponse.getCount().intValue());
      model.put("totalOfMoney", totalOfMoney);
      model.put("totalOfCapital", totalOfCapital);
      model.put("totalOfCards", fpoResponse.getQuantity().intValue());
      model.put("id", StringUtils.trimToNull(quickSearch));
      model.put("specialCard",specialCard);
      model.put("specialCustomers", specialCustomers);
      model.put("listSpecialCustomer", getListSpecialCustomer());
    } catch (Exception ex) {
      LOGGER.error(ex.getMessage());
    }

    return "/purchase_manager/list";
  }

  @RequestMapping(value = "/add", method = RequestMethod.GET)
  @PreAuthorize("hasAnyRole('" + ADMIN_OPERATION + "','" +
      SALESUPPORT + "','" + SALESUPPORT_LEADER + "','" + SALESUPPORT_MANAGER + "','"
      + FINANCESUPPORT_LEADER + "','" + FA_MANAGER
      + "')")
  public String purchaseOrderAdd(HttpServletRequest request, ModelMap model)
      throws FrontEndException {
    try {
      model.put("listSpecialCustomer", getListSpecialCustomer());

      model.put(LIST_PROVIDER_RQP, epinStoreEndpoint.listProvider());

    } catch (Exception ex) {
      LOGGER.error(ex.getMessage());
    }
    return PAGE_PURCHASE_MANAGER_DECLARE_PO;
  }

  /**
   * Luồng import B1:  Khai báo PO
   */
  @RequestMapping(value = "/add", method = RequestMethod.POST)
  @PreAuthorize("hasAnyRole('" + ADMIN_OPERATION + "','" +
      SALESUPPORT + "','" + SALESUPPORT_MANAGER + "','" + SALESUPPORT_LEADER + "','"
      + FINANCESUPPORT_LEADER + "','" + FA_MANAGER
      + "')")
  public String purchaseOrderSubmit(HttpServletRequest request, ModelMap model)
      throws FrontEndException, IOException {

    Long totalQuantity = 0L;
    Long totalMoney = 0L;
    Long totalCapitalValue = 0L;
    Integer totalTelco = NumberUtil.convertToInt(request.getParameter("totalTelco"));

    List<PurchaseOrderDetailItem> poDetails = new ArrayList<>();
    for (int i = 1; i < totalTelco + 1; i++) {
      PurchaseOrderDetailItem poDetailItem = new PurchaseOrderDetailItem();

      String cardType = request.getParameter("telco_" + i);
      Integer faceValue = NumberUtil.convertToInt(request.getParameter("value_" + i));
      Integer quantity = NumberUtil.convertToInt(request.getParameter("quantity_" + i));
      Double discount = NumberUtil.convertToDouble(request.getParameter("discount_" + i));

      BigDecimal sumFaceValue = new BigDecimal(Long.valueOf(faceValue) * quantity);
      BigDecimal discountPercentRate = new BigDecimal(discount / 100);
      BigDecimal sumCapitalValue = sumFaceValue
          .subtract(sumFaceValue.multiply(discountPercentRate));
      totalCapitalValue += sumCapitalValue.setScale(0, RoundingMode.HALF_UP).longValueExact();

      poDetailItem.setCardType(cardType);
      poDetailItem.setFaceValue(faceValue);
      poDetailItem.setQuantity(quantity);
      poDetailItem.setDiscountRate(discount);

      totalQuantity += quantity;
      Long money = (long) quantity * faceValue;
      totalMoney += money;
      poDetails.add(poDetailItem);

    }

    String provider = request.getParameter(PROVIDER_RQP);
    String poCode = request.getParameter(PO_CODE_RQP);
    String notePo = request.getParameter("note");
    String reImportation = request.getParameter("reImportation");
    String[] specialCustomer = request.getParameterValues("specialCustomer");

    PurchaseOrderItem poCreate = new PurchaseOrderItem();
    poCreate.setPoCode(poCode);
    poCreate.setTotalQuantity(totalQuantity);
    poCreate.setTotalValue(totalMoney);
    poCreate.setCapitalValue(totalCapitalValue);
    poCreate.setProvider(provider);
    poCreate.setPurchaseOrderDetails(poDetails);
    poCreate.setNote(notePo);

    if (reImportation != null && reImportation != "") {
      if ("1".equals(reImportation)) {
        poCreate.setReimportation(true);
//        poCreate.setUpType(1);
      } else if ("0".equals(reImportation)) {
        poCreate.setReimportation(false);
//        poCreate.setUpType(0);
      }
    }
    if (specialCustomer != null && specialCustomer.length > 0) {
      List<String> cifList = new ArrayList<>();
      for (String cif : specialCustomer) {
        if (StringUtils.isNotBlank(cif)) {
          cifList.add(cif);
        }
      }
      if (!cifList.isEmpty()) {
        poCreate.setIsPrivate(true);
        poCreate.setSpecialCustomerCifList(cifList);
      }
    }

    CreateFullPurchaseOrderRequest cfpoRequest = new CreateFullPurchaseOrderRequest(poCreate);

    MultipartHttpServletRequest multiPartRequest = (MultipartHttpServletRequest) request;
    List<MultipartFile> multiparts = multiPartRequest.getFiles("file");

    List<Attachment> attachments = new ArrayList<>();
    Attachment fileUpload;

    for (MultipartFile multipart : multiparts) {
      byte[] fileData = new byte[0];
      if (multipart != null && multipart.getBytes() != null && multipart.getBytes().length > 0) {
        fileData = multipart.getBytes();
      }
      fileUpload = new Attachment();
      fileUpload.setName(multipart.getOriginalFilename());
      fileUpload.setContentType(multipart.getContentType());
      fileUpload.setContent(fileData);

      attachments.add(fileUpload);
    }

    cfpoRequest.setAttachments(attachments);

    CreateFullPurchaseOrderResponse cfpoResponse = epinStoreEndpoint
        .createFullPurchaseOrder(cfpoRequest);

    if (cfpoResponse.getStatus().getCode() == 0) {
      SessionUtil.setAttribute(SESSION_MESSAGE_NOTIFY,
          new MessageNotify(SUCCESS_CODE, validation.notify(MESAGE_SUCCESS)));
      return REDIRECT + PURCHASE_ORDER_LIST;
    } else {
      model.put(CODE_ERR_MODELMAP, cfpoResponse.getStatus().getCode());
      model.put(MESERR_MODELMAP, cfpoResponse.getStatus().getValue());
      model.put("unstructuredData", cfpoResponse.getUnstructuredData());
      model.put(LIST_PROVIDER_RQP, epinStoreEndpoint.listProvider());
      return PAGE_PURCHASE_MANAGER_DECLARE_PO;
    }
  }

  @RequestMapping(value = "/upload", method = RequestMethod.GET)
  @PreAuthorize("hasAnyRole('" + ADMIN_OPERATION + "','" +
      SALESUPPORT + "','" + SALESUPPORT_LEADER + "','" + FINANCESUPPORT_LEADER + "','" + FA_MANAGER
      + "')")
  public String purchaseOrderUpload(HttpServletRequest request, ModelMap model)
      throws FrontEndException {

    model.put(LIST_PROVIDER_RQP, epinStoreEndpoint.listProvider());

    return PAGE_PURCHASE_MANAGER_UPLOAD_FILE;
  }

  /**
   * Luồng import B2: file tải lên
   */
  @RequestMapping(value = "/upload", method = RequestMethod.POST)
  @PreAuthorize("hasAnyRole('" + ADMIN_OPERATION + "','" +
      SALESUPPORT + "','" + SALESUPPORT_MANAGER + "','" + SALESUPPORT_LEADER + "','"
      + FINANCESUPPORT_LEADER + "','" + FA_MANAGER
      + "')")
  public String createFullPurchaseOrder(HttpServletRequest request, ModelMap model)
      throws FrontEndException, IOException {

		/* Upload file file excel and save it to PO table */
    String notePo = request.getParameter("note");
    String filePath = request.getParameter("pathFile");

    MultipartHttpServletRequest multiPartRequest = (MultipartHttpServletRequest) request;
    List<MultipartFile> multiparts = multiPartRequest.getFiles("file");

    List<Attachment> attachments = new ArrayList<>();
    Attachment fileUpload;

    for (MultipartFile multipart : multiparts) {
      byte[] fileData = new byte[0];
      if (multipart != null && multipart.getBytes() != null && multipart.getBytes().length > 0) {
        fileData = multipart.getBytes();
      }
      fileUpload = new Attachment();

      fileUpload.setName(multipart.getOriginalFilename());
      fileUpload.setContentType("unknow");
      fileUpload.setContent(fileData);

      attachments.add(fileUpload);

    }

    PurchaseOrderItem poUpdate = new PurchaseOrderItem();
    poUpdate.setNote(notePo);
    poUpdate.setFilePath(filePath);

    CreateFullPurchaseOrderRequest cfpoRequest = new CreateFullPurchaseOrderRequest();
    cfpoRequest.setPurchaseOrder(poUpdate);
    cfpoRequest.setAttachments(attachments);

    CreateFullPurchaseOrderResponse cfpoResponse = epinStoreEndpoint
        .createFullPurchaseOrder(cfpoRequest);
    if (cfpoResponse.getStatus().getCode() == 0) {
      SessionUtil.setAttribute(SESSION_MESSAGE_NOTIFY,
          new MessageNotify(SUCCESS_CODE, validation.notify(MESAGE_SUCCESS)));
      return REDIRECT + PURCHASE_ORDER_LIST;
    } else {
      model.put(CODE_ERR_MODELMAP, cfpoResponse.getStatus().getCode());
      model.put(MESERR_MODELMAP, cfpoResponse.getStatus().getValue());
      model.put(LIST_PROVIDER_RQP, epinStoreEndpoint.listProvider());
      return PAGE_PURCHASE_MANAGER_DECLARE_PO;
    }

  }

  @RequestMapping(value = "/updateAttachment", method = RequestMethod.POST)
  @PreAuthorize("hasAnyRole('" + ADMIN_OPERATION + "','" +
      SALESUPPORT + "','" + SALESUPPORT_MANAGER + "','" + SALESUPPORT_LEADER + "','"
      + FINANCESUPPORT_LEADER + "','" + FA_MANAGER
      + "')")
  public String updatePurchaseOrderAttachment(HttpServletRequest request, ModelMap model)
      throws FrontEndException, IOException {

		/* Upload file file excel and save it to PO table */

    Long idPo = Long.parseLong(request.getParameter("id"));
    String note = request.getParameter("note");

    MultipartHttpServletRequest multiPartRequest = (MultipartHttpServletRequest) request;
    List<MultipartFile> multiparts = multiPartRequest.getFiles("file");

    List<Attachment> attachments = new ArrayList<>();
    Attachment fileUpload;

    for (MultipartFile multipart : multiparts) {
      byte[] fileData = new byte[0];
      if (multipart != null && multipart.getBytes() != null && multipart.getBytes().length > 0) {
        fileData = multipart.getBytes();
      }
      fileUpload = new Attachment();
      fileUpload.setPurchaseOrderId(idPo);
      fileUpload.setName(multipart.getOriginalFilename());
      fileUpload.setContentType("unknow");
      fileUpload.setContent(fileData);
      attachments.add(fileUpload);
    }

    CreateAttachmentRequest caRequest = new CreateAttachmentRequest(attachments, note);
    CreateAttachmentResponse caResponse = epinStoreEndpoint
        .updatePurchaseOrderAttachment(caRequest);

    if (caResponse.getStatus().getCode() == 0) {
      SessionUtil.setAttribute(SESSION_MESSAGE_NOTIFY,
          new MessageNotify(SUCCESS_CODE, validation.notify(MESAGE_SUCCESS)));
      return REDIRECT + PURCHASE_ORDER_LIST;
    } else {
      model.put(CODE_ERR_MODELMAP, caResponse.getStatus().getCode());
      model.put(MESERR_MODELMAP, caResponse.getStatus().getValue());
      model.put(LIST_PROVIDER_RQP, epinStoreEndpoint.listProvider());
      model.put("id", idPo);
      return PAGE_PURCHASE_MANAGER_UPLOAD_FILE;
    }

  }

  @RequestMapping(value = "/edit", method = RequestMethod.GET)
  @PreAuthorize(
      "hasAnyRole('" + ADMIN_OPERATION + "','" + SALESUPPORT + "','" + SALESUPPORT_MANAGER + "','"
          + SALESUPPORT_LEADER + "', '"
          + FINANCESUPPORT_LEADER + "','" + FA_MANAGER + "')")
  public String purchaseOrderEdit(HttpServletRequest request, ModelMap model)
      throws FrontEndException {

    String checkBoxSpecialCard = request.getParameter("checkBoxSpecialCard");

    Long id = NumberUtil.convertToLong(request.getParameter("id"));
    if (id == 0) {
      SessionUtil.setAttribute(SESSION_MESSAGE_NOTIFY,
          new MessageNotify(ERROR_CODE, validation.notify(MESAGE_ERROR)));
      return REDIRECT + PURCHASE_ORDER_LIST;
    }
    try {
      GetPurchaseOrderRequest gpoRequest = new GetPurchaseOrderRequest(id);
      GetPurchaseOrderResponse gpoResponse = epinStoreEndpoint.getPurchaseOrder(gpoRequest);

      if (gpoResponse != null && gpoResponse.getPurchaseOrder() != null
          && gpoResponse.getStatus().getCode() == 0) {
        model.put(RESPONSE_PO_RQP, gpoResponse.getPurchaseOrder());
        model.put("poItem", gpoResponse.getPurchaseOrder());
        model.put("poDetailItems", gpoResponse.getPurchaseOrder().getPurchaseOrderDetails());
        model.put(LIST_PROVIDER_RQP, epinStoreEndpoint.listProvider());
        model.put(PO_TYPES_RQP, gpoResponse.getPurchaseOrder().getUpType());
        model.put("specialCustomer", gpoResponse.getPurchaseOrder().getSpecialCustomerCifList());

        Boolean isPrivate = gpoResponse.getPurchaseOrder().getIsPrivate();
        if (isPrivate) {
          checkBoxSpecialCard = "1";
        } else {
          checkBoxSpecialCard = "0";
        }
        model.put("checkBoxSpecialCard", checkBoxSpecialCard);

        try {
          model.put("listSpecialCustomer", getListSpecialCustomer());


        } catch (Exception e) {
          e.printStackTrace();
        }
        return PAGE_PURCHASE_MANAGER_EDIT_DECLARE_PO;

      } else {
        SessionUtil.setAttribute(SESSION_MESSAGE_NOTIFY,
            new MessageNotify(ERROR_CODE, gpoResponse.getStatus().getValue()));
        return REDIRECT + PURCHASE_ORDER_LIST;
      }
    } catch (FrontEndException e) {
      LOGGER.error("purchaseOrderEdit", e);
      SessionUtil.setAttribute(SESSION_MESSAGE_NOTIFY,
          new MessageNotify(ERROR_CODE, validation.notify(MESAGE_ERROR)));
      return REDIRECT + PURCHASE_ORDER_LIST;
    }

  }

  /**
   * Luồng import Edit po
   */
  @RequestMapping(value = "/edit", method = RequestMethod.POST)
  @PreAuthorize("hasAnyRole('" + ADMIN_OPERATION + "','" +
      SALESUPPORT + "','" + SALESUPPORT_MANAGER + "', '" + SALESUPPORT_LEADER + "','"
      + FINANCESUPPORT_LEADER + "', '" + FA_MANAGER
      + "')")
  public String purchaseOrderEditAction(HttpServletRequest request, ModelMap model)
      throws FrontEndException {

    String checkBoxSpecialCard = request.getParameter("checkBoxSpecialCard");
    String[] specialCustomer = request.getParameterValues("specialCustomer");

    Long poId = NumberUtil.convertToLong(request.getParameter("id"));
    if (poId == 0) {
      SessionUtil.setAttribute(SESSION_MESSAGE_NOTIFY,
          new MessageNotify(ERROR_CODE, validation.notify(MESAGE_ERROR)));
      return REDIRECT + PURCHASE_ORDER_LIST;
    }
    try {

      GetPurchaseOrderRequest gpoRequest = new GetPurchaseOrderRequest(poId);
      GetPurchaseOrderResponse gpoResponse = epinStoreEndpoint.getPurchaseOrder(gpoRequest);

      model.put(RESPONSE_PO_RQP, gpoResponse);
      model.put(LIST_PROVIDER_RQP, epinStoreEndpoint.listProvider());

      Integer totalTelco = NumberUtil.convertToInt(request.getParameter("totalTelco"));
      String provider = request.getParameter(PROVIDER_RQP);
      String poCode = request.getParameter(PO_CODE_RQP);
      String poType = request.getParameter(PO_TYPES_RQP);

      Long totalQuantity = 0L;
      Long totalValue = 0L;
      Long totalCapitalValue = 0L;

      List<PurchaseOrderDetailItem> listPOdetail = new ArrayList<>();
      for (int i = 1; i < totalTelco + 1; i++) {
        PurchaseOrderDetailItem detailItem = new PurchaseOrderDetailItem();

        String cardType = request.getParameter("telco_" + i);
        Integer faceValue = NumberUtil.convertToInt(request.getParameter("value_" + i));
        Integer quantity = NumberUtil.convertToInt(request.getParameter("quantity_" + i));
        Double discount = NumberUtil.convertToDouble(request.getParameter("discount_" + i));

        BigDecimal sumFaceValue = new BigDecimal(Long.valueOf(faceValue) * quantity);
        BigDecimal discountPercentRate = new BigDecimal(discount / 100);
        BigDecimal sumCapitalValue = sumFaceValue
            .subtract(sumFaceValue.multiply(discountPercentRate));
        totalCapitalValue += sumCapitalValue.setScale(0, RoundingMode.HALF_UP).longValueExact();

        detailItem.setCardType(cardType);
        detailItem.setFaceValue(faceValue);
        detailItem.setQuantity(quantity);
        detailItem.setDiscountRate(discount);
        detailItem.setPoId(poId);
        listPOdetail.add(detailItem);

        totalQuantity += (quantity * 1L);
        totalValue += (quantity * 1L) * faceValue;
      }
      PurchaseOrderItem purchaseOrderItem = new PurchaseOrderItem();
      purchaseOrderItem.setProvider(provider);
      purchaseOrderItem.setId(poId);
      purchaseOrderItem.setPoCode(poCode);
      purchaseOrderItem.setPurchaseOrderDetails(listPOdetail);
      purchaseOrderItem.setTotalQuantity(totalQuantity);
      purchaseOrderItem.setTotalValue(totalValue);
      purchaseOrderItem.setCapitalValue(totalCapitalValue);
      purchaseOrderItem.setUpType(NumberUtil.convertToInt(poType));
      if ("1".equals(checkBoxSpecialCard)) {
        purchaseOrderItem.setIsPrivate(true);
        purchaseOrderItem.setSpecialCustomerCifList(Arrays.asList(specialCustomer));
      } else {
        purchaseOrderItem.setIsPrivate(false);
        purchaseOrderItem.setSpecialCustomerCifList(null);
      }

      UpdatePurchaseOrderRequest upoRequest = new UpdatePurchaseOrderRequest();
      upoRequest.setPurchaseOrder(purchaseOrderItem);
      if (!listPOdetail.isEmpty()) {
        upoRequest.setIncludePODetail(true);
      }

      UpdatePurchaseOrderResponse upoResponse = epinStoreEndpoint.updatePurchaseOrder(upoRequest);

      if (upoResponse.getStatus().getCode() == 0) {
        SessionUtil.setAttribute(SESSION_MESSAGE_NOTIFY,
            new MessageNotify(SUCCESS_CODE, validation.notify(MESAGE_SUCCESS)));
        return REDIRECT + PURCHASE_ORDER_LIST;
      } else {
        model.put(CODE_ERR_MODELMAP, upoResponse.getStatus().getCode());
        model.put(MESERR_MODELMAP, upoResponse.getStatus().getValue());
        model.put("poId", poId);
        return PAGE_PURCHASE_MANAGER_EDIT_DECLARE_PO;
      }
    } catch (FrontEndException e) {
      LOGGER.error("purchaseOrderEditAction", e);
      return REDIRECT + PURCHASE_ORDER_LIST;
    }
  }

  @RequestMapping(value = "/verify", method = RequestMethod.GET)
  @PreAuthorize(
      "hasAnyRole('" + ADMIN_OPERATION + "','" + FINANCE + "','" + FINANCESUPPORT_LEADER + "','"
          + FA_MANAGER + "','" + SALESUPPORT_MANAGER + "')")
  public String purchaseOrderVerify(HttpServletRequest request, ModelMap model)
      throws FrontEndException {

    /* Get PO & PO Detail from Database to show for User */
    return "/purchase_manager/display_verify";
  }

  @RequestMapping(value = "/verify", method = RequestMethod.POST)
  @PreAuthorize(
      "hasAnyRole('" + ADMIN_OPERATION + "','" + FINANCE + "','" + FINANCESUPPORT_LEADER + "','"
          + FA_MANAGER + "','" + SALESUPPORT_MANAGER + "')")
  public String purchaseOrderVerifySubmit(HttpServletRequest request, ModelMap model)
      throws FrontEndException {

    /* Get password from client */
    String password = request.getParameter(PASSW_RQP);
    Long poID = NumberUtil.convertToLong(request.getParameter("poId"));
    String poCode = request.getParameter(PO_CODE_RQP);

    try {
      if (poID > 0) {

        GetPurchaseOrderRequest gpoRequest = new GetPurchaseOrderRequest(poID);
        GetPurchaseOrderResponse gpoResponse = epinStoreEndpoint.getPurchaseOrder(gpoRequest);

        if (gpoResponse != null && gpoResponse.getPurchaseOrder() != null
            && gpoResponse.getStatus().getCode() == 0) {
          model.put("specialCustomer", gpoResponse.getPurchaseOrder().getSpecialCustomerCifList());
        }
        try {
          model.put("listSpecialCustomer", getListSpecialCustomer());
        } catch (Exception e) {
          e.printStackTrace();
        }
        VerifyPurchaseOrderFileRequest verifyPoRequest = new VerifyPurchaseOrderFileRequest(poID,
            password);

        LOGGER.error("poID--" + poID);
        LOGGER.error("password--" + password);

        VerifyPurchaseOrderFileResponse verifyPoResponse = epinStoreEndpoint
            .verifyPurchaseOrderFile(verifyPoRequest);

        List<POFileCompareResult> compareResult = new ArrayList<>();
        boolean isPOdetail =
            verifyPoResponse.getpODetailList() != null && !verifyPoResponse.getpODetailList()
                .isEmpty();
        boolean isPoFile =
            verifyPoResponse.getpOFileList() != null && !verifyPoResponse.getpOFileList().isEmpty();
        if (isPOdetail && isPoFile) {
          compareResult = FileCompareUtil
              .compare((List) verifyPoResponse.getpODetailList(),
                  (List) verifyPoResponse.getpOFileList());
        }

        model.put(CODE_ERR_MODELMAP, verifyPoResponse.getStatus().getCode());
        model.put(MESERR_MODELMAP, verifyPoResponse.getStatus().getValue());

        model.put("poId", poID);
        model.put(PO_CODE_RQP, poCode);
        model.put(PASSW_RQP, password);
        model.put(RESPONSE_PO_RQP, verifyPoResponse);
        model.put("compareResult", compareResult);
      } else {
        model.put(CODE_ERR_MODELMAP, MessageNotify.ERROR_CODE);
        model.put(MESERR_MODELMAP, MessageNotify.ERROR_NAME);
      }
    } catch (FrontEndException e) {
      LOGGER.error("purchaseOrderVerifySubmit", e);
      model.put(CODE_ERR_MODELMAP, 1);
      model.put(MESERR_MODELMAP, e.getMessage());
    }
    /* Compare excel data with data in database return to client */
    return "/purchase_manager/verify";
  }

  @RequestMapping(value = "/verify/commit", method = RequestMethod.POST)
  @PreAuthorize(
      "hasAnyRole('" + ADMIN_OPERATION + "','" + FINANCE + "','" + FINANCESUPPORT_LEADER + "','"
          + FA_MANAGER + "','" + SALESUPPORT_MANAGER + "')")
  public String purchaseOrderVerifyCommit(HttpServletRequest request, ModelMap model)
      throws FrontEndException {

		/* Get some parameter */
    Long poID = NumberUtil.convertToLong(request.getParameter("poid"));
    String action = request.getParameter(ACTION_RQP);
    String password = request.getParameter(PASSW_RQP);
    String note = request.getParameter("note");

    try {
      if (poID > 0 && StringUtils.isNotBlank(action)) {

        if (action.equals(WorkflowState.CONFIRMED.name())) {

          List<KeyValue> unstructuredData = new ArrayList<>();
          unstructuredData.add(new KeyValue(PASSW_RQP, password));

          PurchaseOrderFlowApproveRequest poFaRequest = new PurchaseOrderFlowApproveRequest(poID,
              note);
          poFaRequest.setUnstructuredData(unstructuredData);

          PurchaseOrderFlowApproveResponse poFaResponse = epinStoreEndpoint
              .verifyPOApprove(poFaRequest);

          if (poFaResponse.getStatus().getCode() != 0) {
            SessionUtil.setAttribute(SESSION_MESSAGE_NOTIFY,
                new MessageNotify(ERROR_CODE, poFaResponse.getStatus().getValue()));
            return REDIRECT + PURCHASE_ORDER_LIST;
          }
        } else if (action.equals(WorkflowState.REJECTED.name())) {

          List<KeyValue> unstructuredData = new ArrayList<>();
          unstructuredData.add(new KeyValue(PASSW_RQP, password));

          PurchaseOrderFlowRejectRequest poFrRequest = new PurchaseOrderFlowRejectRequest(poID,
              note);
          poFrRequest.setUnstructuredData(unstructuredData);
          PurchaseOrderFlowRejectResponse poFrResponse = epinStoreEndpoint
              .verifyPOReject(poFrRequest);

          if (poFrResponse.getStatus().getCode() != 0) {
            SessionUtil.setAttribute(SESSION_MESSAGE_NOTIFY,
                new MessageNotify(ERROR_CODE, poFrResponse.getStatus().getValue()));
            return REDIRECT + PURCHASE_ORDER_LIST;
          }
        } else {
          message = new MessageNotify(ERROR_CODE, validation.notify(MESAGE_ERROR_EPIN_FOLLOW));
        }
      } else {
        message = new MessageNotify(ERROR_CODE, validation.notify(MESAGE_ERROR_EPIN_FOLLOW_PARAM));
      }
    } catch (FrontEndException e) {
      LOGGER.error("purchaseOrderVerifyCommit", e);
      message = new MessageNotify(ERROR_CODE, validation.notify(MESAGE_ERROR));
    }
    SessionUtil.setAttribute(SESSION_MESSAGE_NOTIFY, message);
    return REDIRECT + PURCHASE_ORDER_LIST;
  }

  @RequestMapping(value = "/update-status", method = RequestMethod.POST)
  @PreAuthorize(
      "hasAnyRole('" + ADMIN_OPERATION + "','" + FINANCESUPPORT_LEADER + "','" + FA_MANAGER + "','"
          + SALESUPPORT_MANAGER + "')")
  @ResponseBody
  public AjaxResponse purchaseOrderUpdateStatusSubmit(HttpServletRequest request,
      HttpServletResponse response) {

    String poID = request.getParameter("poid");
    String poCode = request.getParameter(PO_CODE_RQP);
    String status = request.getParameter(ACTION_RQP);
    String note = request.getParameter("note");

    try {
      if (!StringUtils.EMPTY.equals(poID) && !StringUtils.EMPTY.equals(status)) {
        ChangePurchaseOrderStatusRequest requestPO = new ChangePurchaseOrderStatusRequest();

        requestPO.setActiveOrInactive("ACTIVE".equals(status) ? true : false);
        requestPO.setPoCode(poCode);
        requestPO.setNote(note);

        ChangePurchaseOrderStatusResponse responsePO = epinStoreEndpoint
            .updatePurchaseOrderStatus(requestPO);
        if (responsePO.getStatus().getCode() == 0) {
          return new AjaxResponse(0, MessageNotify.SUCCESS_NAME);
        } else {
          return new AjaxResponse(responsePO.getStatus().getCode(),
              responsePO.getStatus().getValue());
        }
      } else {
        return new AjaxResponse(1, MessageNotify.ERROR_NAME);
      }
    } catch (FrontEndException e) {
      LOGGER.error("purchaseOrderUpdateStatusSubmit", e);
      return new AjaxResponse(1, e.getMessage());
    }
  }

  @RequestMapping(value = "/transfer-po", method = RequestMethod.POST)
  @PreAuthorize(
      "hasAnyRole('" + ADMIN_OPERATION + "','" + FINANCESUPPORT_LEADER + "','" + FA_MANAGER + "','"
          + SALESUPPORT_MANAGER + "')")
  @ResponseBody
  public AjaxResponse purchaseOrderTransfer(HttpServletRequest request,
      HttpServletResponse response) {

    String[] customerCifs = request.getParameterValues("specialCustomer");

    List<String> customerLists = new ArrayList<>();
    if (customerCifs != null) {
      customerLists = Arrays.asList(customerCifs);
    }
    Long poId = Long.valueOf(request.getParameter("poid"));
    boolean transferToMerchant = request.getParameter("checkBoxSpecialCard").equalsIgnoreCase("1");

    try {
      if (transferToMerchant) {
        TransferPOToOtherCustomerRequest transferPOToOtherCustomerRequest =
            new TransferPOToOtherCustomerRequest();
        transferPOToOtherCustomerRequest.setCustomerLists(customerLists);
        transferPOToOtherCustomerRequest.setPurchaseOrderId(poId);
        TransferPOToOtherCustomerResponse transferPOToOtherCustomerResponse =
            epinStoreEndpoint.transferToMerchant(transferPOToOtherCustomerRequest);
        if (transferPOToOtherCustomerResponse.getStatus().getCode() == 0) {
          return new AjaxResponse(0, MessageNotify.SUCCESS_NAME);
        } else {
          return new AjaxResponse(transferPOToOtherCustomerResponse.getStatus().getCode(),
              transferPOToOtherCustomerResponse.getStatus().getValue());
        }

      } else {
        TransferPOToGeneralStoreRequest transferPOToGeneralStoreRequest =
            new TransferPOToGeneralStoreRequest();
        transferPOToGeneralStoreRequest.setPurchaseOrderId(poId);
        TransferPOToGeneralStoreResponse transferPOToGeneralStoreResponse =
            epinStoreEndpoint.transferToGeneral(transferPOToGeneralStoreRequest);
        if (transferPOToGeneralStoreResponse.getStatus().getCode() == 0) {
          return new AjaxResponse(0, MessageNotify.SUCCESS_NAME);
        } else {
          return new AjaxResponse(transferPOToGeneralStoreResponse.getStatus().getCode(),
              transferPOToGeneralStoreResponse.getStatus().getValue());
        }
      }
    } catch (Exception e) {
      LOGGER.error("purchase order transfer", e);
      return new AjaxResponse(1, e.getMessage());
    }
  }

  @RequestMapping(value = "/submit-po", method = RequestMethod.POST)
  @ResponseBody
  public AjaxResponse submitPurchaseOrderFlow(HttpServletRequest request,
      HttpServletResponse response) {

    //TODO ROLE

    String poID = request.getParameter("poid");
    String action = request.getParameter(ACTION_RQP);
    String note = request.getParameter("note");

    try {
      if (!StringUtils.EMPTY.equals(poID) && !StringUtils.EMPTY.equals(action)) {
        if (action.equals(WorkflowState.REJECTED.name())) {

          PurchaseOrderFlowSubmitProcessRequest requestPO = new PurchaseOrderFlowSubmitProcessRequest();
          requestPO.setPurchaseOrderId(Long.parseLong(poID));
          requestPO.setInfo(note);

          PurchaseOrderFlowSubmitProcessResponse responsePO = epinStoreEndpoint
              .submitPurchaseOrder(requestPO);
          if (responsePO.getStatus().getCode() != 0) {
            return new AjaxResponse(responsePO.getStatus().getCode(),
                responsePO.getStatus().getValue());
          }
          return new AjaxResponse(0, MessageNotify.SUCCESS_NAME);

        } else if (action.equals(WorkflowState.INIT.name())) {

          PurchaseOrderFlowStartProcessRequest requestPO = new PurchaseOrderFlowStartProcessRequest();
          requestPO.setPurchaseOrderId(Long.parseLong(poID));
          requestPO.setInfo(note);

          PurchaseOrderFlowStartProcessResponse responsePO = epinStoreEndpoint
              .startPurchaseOrder(requestPO);
          if (responsePO.getStatus().getCode() == 0) {
            return new AjaxResponse(0, MessageNotify.SUCCESS_NAME);
          } else {
            return new AjaxResponse(responsePO.getStatus().getCode(),
                responsePO.getStatus().getValue());
          }
        } else {
          return new AjaxResponse(1, MessageNotify.ERROR_NAME);
        }
      } else {
        return new AjaxResponse(1, MessageNotify.ERROR_NAME);
      }
    } catch (FrontEndException e) {
      LOGGER.error("submitPurchaseOrderFlow", e);
      return new AjaxResponse(1, e.getMessage());
    }
  }

  @RequestMapping(value = "/getPoDetail", method = RequestMethod.POST)
  @ResponseBody
  public GetPurchaseOrderResponse getPODetail(HttpServletRequest request,
      HttpServletResponse response) {

    //TODO role

    GetPurchaseOrderRequest requestPO = new GetPurchaseOrderRequest();
    GetPurchaseOrderResponse responsePO = new GetPurchaseOrderResponse();
    try {
      Long poId = NumberUtil.convertToLong(request.getParameter("poid"));
      requestPO.setPurchaseOrderId(poId);

      responsePO = epinStoreEndpoint.getPurchaseOrder(requestPO);
    } catch (FrontEndException e) {
      LOGGER.error("getPODetail", e);
    }

    return responsePO;
  }

  @RequestMapping(value = "/getFileExistCard", method = RequestMethod.POST)
  public String getFileExistCard(HttpServletRequest request, HttpServletResponse response,
      ModelMap model)
      throws IOException {
    //TODO ROLE

    Long poID = NumberUtil.convertToLong(request.getParameter("poid"));
    String password = request.getParameter(PASSW_RQP);

    try {
      if (poID > 0) {
        VerifyPurchaseOrderFileRequest vpoRequest = new VerifyPurchaseOrderFileRequest(poID,
            password);
        VerifyPurchaseOrderFileResponse vpoResponse = epinStoreEndpoint
            .verifyPurchaseOrderFile(vpoRequest);

        if (vpoResponse.getExistedPinQuantity() + vpoResponse.getExistedSerialQuantity() != 0
            && vpoResponse.getExistedFile() != null) {
          response.setContentType(APPLICATION_VND_MS_EXCEL);
          response.setHeader("Content-Disposition",
              "attachment; filename=" + vpoResponse.getExistedFileName());
          ServletOutputStream out = response.getOutputStream();
          out.write(vpoResponse.getExistedFile());
          out.flush();
          out.close();
        }
      }
    } catch (FrontEndException e) {
      LOGGER.error("getFileExistCard", e);
    }
    return "/purchase_manager/verify";
  }

  @RequestMapping(value = "/files/{file_name}", method = RequestMethod.GET)
  public void getFile(@PathVariable("file_name") String fileName, HttpServletResponse response)
      throws IOException {
    //TODO ROLE

    try {
      String contentType = "";
      InputStream inputStream = null;
      String file64 = null;
      String extensionFile = "";
      if (EPAY_NAME.equals(fileName)) {
        inputStream = new ClassPathResource(EPAY).getInputStream();
        contentType = APPLICATION_VND_MS_EXCEL;
        extensionFile = "xls";
      } else if (ZOTA_NAME.equals(fileName)) {
        file64 = "UEsDBBQABgAIAAAAIQCnlfmZhAEAABQGAAATAN0BW0NvbnRlbnRfVHlwZXNdLnhtbCCi2QEooAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAMxUyW7CMBC9V+o/RL5WxEClqqoSOHQ5tkjQDzDxQCwS2/IMFP6+k1BQqdJINBx6SZTFb5tnJ+NtWUQbCGicTcUg7osIbOa0sctUvM9eevciQlJWq8JZSMUOUIxH11fJbOcBI15tMRU5kX+QErMcSoWx82D5y8KFUhE/hqX0KlupJchhv38nM2cJLPWowhCj5AkWal1Q9Lzl13slc2NF9Lj/r6JKhfK+MJkiFio3Vv8g6bnFwmSgXbYuGTpGH0BpzAGoLGIfDDOGKRCxMRRylLyx6WA0RBMV6FWVzCC3hSR2APvrIGYPnUTUYDcVyu+ESLsCsDPVqd896IG5Id4ABZ5n7WuAMa+sZ4C58djC0J5deyYfLqzmzq0unUrVhrhUxh50N5WAKzQJzqPkwnUWAFWjNeieZ0gIZOCYWRM3F7DyXtcWZX0bdtZwWo0jflsGDTpu/4mO7rvyb3lgrgLoKfFJsrz4dv2O3TaXYzczF+D8gRz2cLW6oZGyPtNHnwAAAP//AwBQSwMEFAAGAAgAAAAhALVVMCP1AAAATAIAAAsAzgFfcmVscy8ucmVscyCiygEooAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIySz07DMAzG70i8Q+T76m5ICKGlu0xIuyFUHsAk7h+1jaMkQPf2hAOCSmPb0fbnzz9b3u7maVQfHGIvTsO6KEGxM2J712p4rZ9WD6BiImdpFMcajhxhV93ebF94pJSbYtf7qLKLixq6lPwjYjQdTxQL8exypZEwUcphaNGTGahl3JTlPYa/HlAtPNXBaggHeweqPvo8+bK3NE1veC/mfWKXToxAnhM7y3blQ2YLqc/bqJpCy0mDFfOc0xHJ+yJjA54m2lxP9P+2OHEiS4nQSODzPN+Kc0Dr64Eun2ip+L3OPOKnhOFNZPhhwcUPVF8AAAD//wMAUEsDBBQABgAIAAAAIQDeCf0oAgEAANQDAAAaAAgBeGwvX3JlbHMvd29ya2Jvb2sueG1sLnJlbHMgogQBKKAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAC8k89qwzAMxu+DvYPRfXGSbmWUOr2MQa9b9wAmUeLQxDaW9idvP5NDukDJLqEXgyT8fT/Qp/3hp+/EFwZqnVWQJSkItKWrWtso+Di9PjyDINa20p2zqGBAgkNxf7d/w05z/ESm9SSiiiUFhtnvpKTSYK8pcR5tnNQu9JpjGRrpdXnWDco8Tbcy/NWAYqYpjpWCcKw2IE6Dj87/a7u6bkt8ceVnj5avWMhvF85kEDmK6tAgK5haJMfJJonEIK/D5DeGyZdgshvDZEsw2zVhyOiA1TuHmEK6rGrWXoJ5WhWGhy6GfgoMjfWS/eOa9hxPCS/uYynHd9qHnN1i8QsAAP//AwBQSwMEFAAGAAgAAAAhALYtiEtoAQAAggIAAA8AAAB4bC93b3JrYm9vay54bWyMUstuwjAQvFfqP1i+lwRDKEIkSFVblUuFVB5nN94QC8eObIfA33djRErVHnry7O54PDvyfHGqFDmCddLolA4HMSWgcyOk3qd0s359mFLiPNeCK6MhpWdwdJHd381bYw+fxhwICmiX0tL7ehZFLi+h4m5gatA4KYytuMfS7iNXW+DClQC+UhGL40lUcanpRWFm/6NhikLm8GzypgLtLyIWFPdo35WydjSbF1LB9rIR4XX9ziv0fVKUKO78i5AeRErHWJoWfjRsUz81UnXTJJ7QKOuXXFmCqh7sysojz8+YFCUCCt4ov8aFr+9hn40ZC3e7cLYSWvct05XktJNamDalGPX5ilnCsGzDZCeFL1EpGU/73hvIfelTOonjuDMW3aiHRPGVcBId1v3oUkaPobfEjRDbmURgl2LYKfxisxs24p7N/mSPbtiIe/YouAviaCnnKsfsuiOYYMkjSwLj+n2yLwAAAP//AwBQSwMEFAAGAAgAAAAhAOmmJbiCBgAAUxsAABMAAAB4bC90aGVtZS90aGVtZTEueG1s7FlPb9s2FL8P2HcgdG9tJ7YbB3WK2LGbrU0bxG6HHmmZllhTokDSSX0b2uOAAcO6YZcBu+0wbCvQArt0nyZbh60D+hX2SEqyGMtL0gYb1tWHRCJ/fP/f4yN19dqDiKFDIiTlcdurXa56iMQ+H9M4aHt3hv1LGx6SCsdjzHhM2t6cSO/a1vvvXcWbKiQRQbA+lpu47YVKJZuVivRhGMvLPCExzE24iLCCVxFUxgIfAd2IVdaq1WYlwjT2UIwjIHt7MqE+QUNN0tvKiPcYvMZK6gGfiYEmTZwVBjue1jRCzmWXCXSIWdsDPmN+NCQPlIcYlgom2l7V/LzK1tUK3kwXMbVibWFd3/zSdemC8XTN8BTBKGda69dbV3Zy+gbA1DKu1+t1e7WcngFg3wdNrSxFmvX+Rq2T0SyA7OMy7W61Ua27+AL99SWZW51Op9FKZbFEDcg+1pfwG9VmfXvNwRuQxTeW8PXOdrfbdPAGZPHNJXz/SqtZd/EGFDIaT5fQ2qH9fko9h0w42y2FbwB8o5rCFyiIhjy6NIsJj9WqWIvwfS76ANBAhhWNkZonZIJ9iOIujkaCYs0AbxJcmLFDvlwa0ryQ9AVNVNv7MMGQEQt6r55//+r5U/Tq+ZPjh8+OH/50/OjR8cMfLS1n4S6Og+LCl99+9ufXH6M/nn7z8vEX5XhZxP/6wye//Px5ORAyaCHRiy+f/PbsyYuvPv39u8cl8G2BR0X4kEZEolvkCB3wCHQzhnElJyNxvhXDEFNnBQ6Bdgnpngod4K05ZmW4DnGNd1dA8SgDXp/dd2QdhGKmaAnnG2HkAPc4Zx0uSg1wQ/MqWHg4i4Ny5mJWxB1gfFjGu4tjx7W9WQJVMwtKx/bdkDhi7jMcKxyQmCik5/iUkBLt7lHq2HWP+oJLPlHoHkUdTEtNMqQjJ5AWi3ZpBH6Zl+kMrnZss3cXdTgr03qHHLpISAjMSoQfEuaY8TqeKRyVkRziiBUNfhOrsEzIwVz4RVxPKvB0QBhHvTGRsmzNbQH6Fpx+A0O9KnX7HptHLlIoOi2jeRNzXkTu8Gk3xFFShh3QOCxiP5BTCFGM9rkqg+9xN0P0O/gBxyvdfZcSx92nF4I7NHBEWgSInpkJ7Uso1E79jWj8d8WYUajGNgbeFeO2tw1bU1lK7J4owatw/8HCu4Nn8T6BWF/eeN7V3Xd113vr6+6qXD5rtV0UWKi9unmwfbHpkqOVTfKEMjZQc0ZuStMnS9gsxn0Y1OvMAZHkh6YkhMe0uDu4QGCzBgmuPqIqHIQ4gR675mkigUxJBxIlXMLZzgyX0tZ46NOVPRk29JnB1gOJ1R4f2+F1PZwdDXIyZssJzPkzY7SuCZyV2fqVlCio/TrMalqoM3OrGdFMqXO45SqDD5dVg8HcmtCFIOhdwMpNOKJr1nA2wYyMtd3tBpy5xXjhIl0kQzwmqY+03ss+qhknZbFiLgMgdkp8pM95p1itwK2lyb4Bt7M4qciuvoJd5r038VIWwQsv6bw9kY4sLiYni9FR22s11hoe8nHS9iZwrIXHKAGvS934YRbA3ZCvhA37U5PZZPnCm61MMTcJanBTYe2+pLBTBxIh1Q6WoQ0NM5WGAIs1Jyv/WgPMelEK2Eh/DSnWNyAY/jUpwI6ua8lkQnxVdHZhRNvOvqallM8UEYNwfIRGbCYOMLhfhyroM6YSbidMRdAvcJWmrW2m3OKcJl3xAsvg7DhmSYjTcqtTNMtkCzd5nMtg3grigW6lshvlzq+KSfkLUqUYxv8zVfR+AtcF62PtAR9ucgVGOl/bHhcq5FCFkpD6fQGNg6kdEC1wHQvTEFRwn2z+C3Ko/9ucszRMWsOpTx3QAAkK+5EKBSH7UJZM9J1CrJbuXZYkSwmZiCqIKxMr9ogcEjbUNbCp93YPhRDqppqkZcDgTsaf+55m0CjQTU4x35waku+9Ngf+6c7HJjMo5dZh09Bk9s9FLNlV7XqzPNt7i4roiUWbVc+yApgVtoJWmvavKcI5t1pbsZY0XmtkwoEXlzWGwbwhSuDSB+k/sP9R4TP7cUJvqEN+ALUVwbcGTQzCBqL6km08kC6QdnAEjZMdtMGkSVnTpq2Ttlq2WV9wp5vzPWFsLdlZ/H1OY+fNmcvOycWLNHZqYcfWdmylqcGzJ1MUhibZQcY4xnzVKn544qP74OgduOKfMSVNMMFnJYGh9RyYPIDktxzN0q2/AAAA//8DAFBLAwQUAAYACAAAACEAO20yS8EAAABCAQAAIwAAAHhsL3dvcmtzaGVldHMvX3JlbHMvc2hlZXQxLnhtbC5yZWxzhI/BisIwFEX3A/5DeHuT1oUMQ1M3IrhV5wNi+toG25eQ9xT9e7McZcDl5XDP5Tab+zypG2YOkSzUugKF5GMXaLDwe9otv0GxOOrcFAktPJBh0y6+mgNOTkqJx5BYFQuxhVEk/RjDfsTZsY4JqZA+5tlJiXkwyfmLG9Csqmpt8l8HtC9Ote8s5H1Xgzo9Uln+7I59Hzxuo7/OSPLPhEk5kGA+okg5yEXt8oBiQet39p5rfQ4Epm3My/P2CQAA//8DAFBLAwQUAAYACAAAACEAuEpLLRMBAAC3AQAAGAAAAHhsL3dvcmtzaGVldHMvc2hlZXQyLnhtbIxQwUrEMBC9C/5DmLtNV1mVpe0iLIseBBH1nm0nbdgkE5JZV//etGUXwYu3eXlvXua9av3lrPjEmAz5GhZFCQJ9S53xfQ3vb9urexCJle+UJY81fGOCdXN5UR0p7tOAyCI7+FTDwBxWUqZ2QKdSQQF9ZjRFpzjD2MsUIqpuWnJWXpflrXTKeJgdVvE/HqS1aXFD7cGh59kkolWc70+DCQmaqjOZGwOJiLqGhwXIppq+/TB4TL9mMabYEe1H4qmroRyl8o92O6V4iaJDrQ6WX+n4iKYfOFe2PLtvFKu8HlSPzyr2xidhUWdNWdyBiLN+mpnC9LoEsSNmcic05IIwF1EWNyA0EZ/AeNa58uYHAAD//wMAUEsDBBQABgAIAAAAIQC4SkstEwEAALcBAAAYAAAAeGwvd29ya3NoZWV0cy9zaGVldDMueG1sjFDBSsQwEL0L/kOYu01XWZWl7SIsix4EEfWebSdt2CQTkllX/960ZRfBi7d5eW9e5r1q/eWs+MSYDPkaFkUJAn1LnfF9De9v26t7EImV75QljzV8Y4J1c3lRHSnu04DIIjv4VMPAHFZSpnZAp1JBAX1mNEWnOMPYyxQiqm5aclZel+WtdMp4mB1W8T8epLVpcUPtwaHn2SSiVZzvT4MJCZqqM5kbA4mIuoaHBcimmr79MHhMv2YxptgR7UfiqauhHKXyj3Y7pXiJokOtDpZf6fiIph84V7Y8u28Uq7weVI/PKvbGJ2FRZ01Z3IGIs36amcL0ugSxI2ZyJzTkgjAXURY3IDQRn8B41rny5gcAAP//AwBQSwMEFAAGAAgAAAAhAOHVP6/UAgAA4AcAABgAAAB4bC93b3Jrc2hlZXRzL3NoZWV0MS54bWycVU1z2jAQvXem/0Gje7ENGAiDySSA2xw602n6cRa2jDWRLVcSkOTXdyUjG2Om04QDknefnvbtSqvF7XPB0YFKxUQZ4WDgY0TLRKSs3EX454/40wwjpUmZEi5KGuEXqvDt8uOHxVHIJ5VTqhEwlCrCudbV3PNUktOCqIGoaAmeTMiCaPiUO09VkpLULiq4N/T9iVcQVuKaYS7/h0NkGUvoWiT7gpa6JpGUEw3xq5xVCi8XKQOfEYQkzSJ8F8zjMfaWC7vzL0aP6myONNk+Uk4TTVNIAEZG2FaIJwN8AJMPjMoCDCNJNDvQFeU8wp8nkJs/dg+YwgZes8P53O0W21R8kyilGdlzvRL8N0t1DruOBrMwHE9m0xA773dx/ELZLtfgDg15IjgwwT8qmCkVRgV5riOuWcamUi8cigS+LVU6ZmYxRsleaVG4vU5cNcvwxALj8RTLcBCM/ckQInkz2+jEBuOJ7eZM2JvpQJCVCKMLbvz+4ECQZYPRsYXvZ4PSWzYYHZt/pvXf6ffqWtrTsiaaLBdSHBGcfyiWqoi5TcF8AucuMcY7Y40wlAjKac73YTlaeAc4YskJcd9HTLuIVR8x6yLWfcRNF7HpIwK/C4mvQIIG4oHKRirIuSLVWE0ajMh2oU3DvfO1aQjChttCVg5il/vw6/rXzt9SjLuITR9xwRH3EcGwIelIhGtwRaKxOontwlqi87Xx9SQ6iJEILbQn0flbioskbfqIi0zHVxDtietIND2nf2CN1UlsF9YSna+NryfRQYzE8IpE528pJk0B7CabPuIi0/Ag1CG2HEF7FGqJdTev72dFdvQrkTtWKsRpBhfRH0wxknWDtnMtKmuF/rIVGhqu+8rh0aNwj/0B5DUTQrsPaOqG95HqfYWEZPCg2XcswpWQWhKmMcrB/irAwdcVgybgwwMNz7VmyblFzlkaYfmQBvYZat7m5V8AAAD//wMAUEsDBBQABgAIAAAAIQCfPl+RBwEAAD4CAAAUAAAAeGwvc2hhcmVkU3RyaW5ncy54bWx80VtrwyAYBuD7wf5D8H71kDVNhrGwE9tF10Kz3kvytRESdWpG++/nYDBIaMAb38fvAPL1ue+Sb3BeGV0iuiAoAV2bRulTiT6r17scJT5I3cjOaCjRBTxai9sb7n1IYq32JWpDsA8Y+7qFXvqFsaCjHI3rZYhXd8LeOpCNbwFC32FGSIZ7qTRKajPoEOfGKYNWXwM8/QUZEtwrwYM4bPaEspykBc1TjoPg+BemeD+HyzHuq2ocUVas0rygK8oYnUM2h5Mda+ma6mJhXHSUNRxkN0zAKj1+68Ep2Y1TOFvl4FmGSQtKcDyM0GxcQ5dXJbsmm+3j++5t+/Hy3wzH/xc/AAAA//8DAFBLAwQUAAYACAAAACEAfh6/TUsCAABVBQAADQAAAHhsL3N0eWxlcy54bWy0VNuK2zAQfS/0H4Tes75sso2D7YUkayhsl4Wk0FfFlhOBLkaSg93Sf+/IduyE7fWhL9ZoPHPOzNFI8WMjODpTbZiSCQ7ufIyozFXB5DHBn/fZbImRsUQWhCtJE9xSgx/T9+9iY1tOdydKLQIIaRJ8srZaeZ7JT1QQc6cqKuFPqbQgFrb66JlKU1IYlyS4F/r+gycIkziNSyWtQbmqpU1wODjS2HxFZ8KhrgB7aZwrrjSyAA+FdB5JBO0jNoSzg2YurCSC8bZ3h87RVTTECSaVdk7PUfbEaXxwUf+dq6M0wMk4v20WHGlcEWuplhls0GDv2wpalaB8X3IX59J/E33UpA3CxVWC1xFCl0oXcNIXmQOQuXelMaelBQ00O57calUF34OyVgkwCkaOShIOpnfJGAxoJ6ec79w0fClvsJsSyVpkwn4sEgxz5QS/mNDCYPZ4/cbhX6P12Few91Dyv8Oiphzxb7Ln0d9UNaYjUlW8fanFgeqsG+thDH8JGgD+z1v9A2hPlYFiA0WnCyhxJfeN2KNsyN2JBL+4+jieaA4145bJUYhJaMAsmunofDc5lhzgdrtDHVngBAtakprb/fgzwZP9iRasFqDoEPXKzsp2EAme7Gc3YcGD46CNfTZwBWFFtWYJ/va0/hBtn7JwtvTXy9n8ni5m0WK9nS3mm/V2m0V+6G++Q0/uvVk1wfzNmyNYrpVRpb3LYXBVWbKcvn11Ii+6vDsAsjIcovTQ7FD8bvIl+GrTl9/dLSgbxvXShGfG9zD9AQAA//8DAFBLAwQUAAYACAAAACEABrZEw0UAAADcAAAAJwAAAHhsL3ByaW50ZXJTZXR0aW5ncy9wcmludGVyU2V0dGluZ3MxLmJpbmKgEDCyMLDdAZrh/L6BlZGBkeEVVz5HCpDmZzjBwASkIaQPQypDCRCmMhRRaB9IOyPUDBDNBOX/BwKoMJwCAAAA//8DAFBLAwQUAAYACAAAACEAcA7pEUABAABRAgAAEQAIAWRvY1Byb3BzL2NvcmUueG1sIKIEASigAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAfJJRa8MgFIXfB/sPwfdETaHtJElhG31aYbCMjb2J3rZh0Yi6pf33M0mbplAGvnjPud89XsxWB1VHv2Bd1egc0YSgCLRoZKV3OXov1/ESRc5zLXndaMjRERxaFfd3mTBMNBZebWPA+gpcFEjaMWFytPfeMIyd2IPiLgkOHcRtYxX34Wp32HDxzXeAU0LmWIHnknuOO2BsRiI6IaUYkebH1j1ACgw1KNDeYZpQfPF6sMrdbOiViVNV/mjCm05xp2wpBnF0H1w1Gtu2TdpZHyPkp/hz8/LWPzWudLcrAajIpGDCAveNLTI8vYTF1dz5TdjxtgL5eAz6jZoUfdwBAjIKAdgQ96x8zJ6eyzUquh3G5CGm85IQ1p+vbuRVfxdoKKjT4H+JdBGTNE6XJSVsljK6mBDPgCH39Sco/gAAAP//AwBQSwMEFAAGAAgAAAAhAJw8u1iLAQAANAMAABAACAFkb2NQcm9wcy9hcHAueG1sIKIEASigAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAnJNBT+MwEIXvSPsfIt+p04IQqhwjBIs4LKJSW/ZsnElj4dqRZ4hafj2TRKXpsnvZnMbznp4+jyfqZrf1WQsJXQyFmE5ykUGwsXRhU4j16uH8WmRIJpTGxwCF2AOKG/3jTC1SbCCRA8w4ImAhaqJmLiXaGrYGJywHVqqYtob4mDYyVpWzcB/t+xYCyVmeX0nYEYQSyvPmK1AMifOW/je0jLbjw5fVvmFgrW6bxjtriG+pn5xNEWNF2c+dBa/kWFRMtwT7nhztda7k+KiW1ni442BdGY+g5LGhHsF0Q1sYl1CrluYtWIopQ/fBY5uJ7NUgdDiFaE1yJhBjdbbh0Ne+QUr6d0xvWAMQKsmGodmXY++4dpf6ojdwcWrsAgYQFk4RV4484HO1MIn+QnwxJu4ZBt4BZ9nxTcd8X6S9NPu3NJCOb9UPivn+IPrlwhuum1W8NwSHiZ821bI2CUp+pIN+bKhHHnbyXchdbcIGyoPnu9Dtx8vwE+jpbJLz16/Foafkcd31JwAAAP//AwBQSwECLQAUAAYACAAAACEAp5X5mYQBAAAUBgAAEwAAAAAAAAAAAAAAAAAAAAAAW0NvbnRlbnRfVHlwZXNdLnhtbFBLAQItABQABgAIAAAAIQC1VTAj9QAAAEwCAAALAAAAAAAAAAAAAAAAAJIDAABfcmVscy8ucmVsc1BLAQItABQABgAIAAAAIQDeCf0oAgEAANQDAAAaAAAAAAAAAAAAAAAAAH4GAAB4bC9fcmVscy93b3JrYm9vay54bWwucmVsc1BLAQItABQABgAIAAAAIQC2LYhLaAEAAIICAAAPAAAAAAAAAAAAAAAAAMAIAAB4bC93b3JrYm9vay54bWxQSwECLQAUAAYACAAAACEA6aYluIIGAABTGwAAEwAAAAAAAAAAAAAAAABVCgAAeGwvdGhlbWUvdGhlbWUxLnhtbFBLAQItABQABgAIAAAAIQA7bTJLwQAAAEIBAAAjAAAAAAAAAAAAAAAAAAgRAAB4bC93b3Jrc2hlZXRzL19yZWxzL3NoZWV0MS54bWwucmVsc1BLAQItABQABgAIAAAAIQC4SkstEwEAALcBAAAYAAAAAAAAAAAAAAAAAAoSAAB4bC93b3Jrc2hlZXRzL3NoZWV0Mi54bWxQSwECLQAUAAYACAAAACEAuEpLLRMBAAC3AQAAGAAAAAAAAAAAAAAAAABTEwAAeGwvd29ya3NoZWV0cy9zaGVldDMueG1sUEsBAi0AFAAGAAgAAAAhAOHVP6/UAgAA4AcAABgAAAAAAAAAAAAAAAAAnBQAAHhsL3dvcmtzaGVldHMvc2hlZXQxLnhtbFBLAQItABQABgAIAAAAIQCfPl+RBwEAAD4CAAAUAAAAAAAAAAAAAAAAAKYXAAB4bC9zaGFyZWRTdHJpbmdzLnhtbFBLAQItABQABgAIAAAAIQB+Hr9NSwIAAFUFAAANAAAAAAAAAAAAAAAAAN8YAAB4bC9zdHlsZXMueG1sUEsBAi0AFAAGAAgAAAAhAAa2RMNFAAAA3AAAACcAAAAAAAAAAAAAAAAAVRsAAHhsL3ByaW50ZXJTZXR0aW5ncy9wcmludGVyU2V0dGluZ3MxLmJpblBLAQItABQABgAIAAAAIQBwDukRQAEAAFECAAARAAAAAAAAAAAAAAAAAN8bAABkb2NQcm9wcy9jb3JlLnhtbFBLAQItABQABgAIAAAAIQCcPLtYiwEAADQDAAAQAAAAAAAAAAAAAAAAAFYeAABkb2NQcm9wcy9hcHAueG1sUEsFBgAAAAAOAA4AsgMAABchAAAAAA==";
        byte[] fileByte = Base64.getDecoder().decode(file64);
        inputStream = new ByteArrayInputStream(fileByte);
        contentType = APPLICATION_VND_MS_EXCEL_XLSX;
        extensionFile = "xlsx";
      } else if (VIETTEL_NAME.equals(fileName)) {
        contentType = TEXT_PLAIN;
        inputStream = new ClassPathResource(VIETTEL).getInputStream();
        extensionFile = "txt";
      } else if (VNTP_NAME.equals(fileName)) {
        file64 =    "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";
        byte[] fileByte = Base64.getDecoder().decode(file64);
        inputStream = new ByteArrayInputStream(fileByte);
        contentType = APPLICATION_VND_MS_EXCEL_XLSX;
        extensionFile = "xlsx";
      } else if (VTC_NAME.equals(fileName)) {
        inputStream = new ClassPathResource(VTC).getInputStream();
        contentType = TEXT_PLAIN;
        extensionFile = "txt";
      } else if (MOBIFONE_NAME.equals(fileName)) {
        inputStream = new ClassPathResource(MOBIFONE).getInputStream();
        contentType = TEXT_PLAIN;
        extensionFile = "dat";
      } else if (VINPLAY_NAME.equals(fileName)) {
        inputStream = new ClassPathResource(VINPLAY).getInputStream();
        contentType = TEXT_PLAIN;
        extensionFile = "txt";
      } else if (VNPT_NAME.equals(fileName)) {
        file64 = "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";
        byte[] fileByte = Base64.getDecoder().decode(file64);
        inputStream = new ByteArrayInputStream(fileByte);
        contentType = APPLICATION_VND_MS_EXCEL_XLSX;
        extensionFile = "xlsx";
      } else if (DATA_MOBIFONE_NAME.equals(fileName)) {
        inputStream = new ClassPathResource(TPTELECOM).getInputStream();
        contentType = APPLICATION_VND_MS_EXCEL_XLSX;
        extensionFile = "xlsx";
      } else if (DT_VTM_NAME.equals(fileName)) {
        inputStream = new ClassPathResource(VMG).getInputStream();
        contentType = TEXT_PLAIN;
        extensionFile = "csv";
      } else if (ZOPAY_NAME.equals(fileName)) {
        file64 = "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";
        byte[] fileByte = Base64.getDecoder().decode(file64);
        inputStream = new ByteArrayInputStream(fileByte);
        contentType = APPLICATION_VND_MS_EXCEL_XLSX;
        extensionFile = "xlsx";
      } else if (VPAY_NAME.equals(fileName)) {
        file64 = "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";
        byte[] fileByte = Base64.getDecoder().decode(file64);
        inputStream = new ByteArrayInputStream(fileByte);
        contentType = APPLICATION_VND_MS_EXCEL_XLSX;
        extensionFile = "xlsx";
      } else if (IMEDIA_NAME.equals(fileName)) {
        inputStream = new ClassPathResource(IMEDIA).getInputStream();
        contentType = APPLICATION_VND_MS_EXCEL_XLSX;
        extensionFile = "csv";
      } else if (IOMEDIA_NAME.equals(fileName)) {
        file64 = "0M8R4KGxGuEAAAAAAAAAAAAAAAAAAAAAPgADAP7/CQAGAAAAAAAAAAAAAAABAAAAKAAAAAAAAAAAEAAA/v///wAAAAD+////AAAAACcAAAD///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////8JCBAAAAYFAFpPzQfJAAIABggAAOEAAgCwBMEAAgAAAOIAAABcAHAADgABYwCwAaEBAANuAGcAIABuAGcAdQB5AOoAAwNuACAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEIAAgCwBGEBAgAAAMABAAA9AQIAAQCcAAIAEQAZAAIAAAASAAIAAAATAAIAAACvAQIAAAC8AQIAAAA9ABIAaAEUAVw6xCM4AAAAAAABAFgCQAACAAAAjQACAAAAIgACAAAADgACAAEAtwECAAAA2gACAAAAMQAaAMgAAAD/f5ABAAAAAAB/BQFBAHIAaQBhAGwAMQAaAMgAAAD/f5ABAAAAAAB/BQFBAHIAaQBhAGwAMQAaAMgAAAD/f5ABAAAAAAB/BQFBAHIAaQBhAGwAMQAaAMgAAAD/f5ABAAAAAAB/BQFBAHIAaQBhAGwA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AAAwMFwpO18oKg4ABQACBAAUAAMAZWYGAAAAO18oQF8pICB9CEEAfQgAAAAAAAAAAAAAAAATAAAAAwANABQAAwAAAAEAAAAwMFwpO18oKg4ABQACBAAUAAMAZWYHAAAAO18oQF8pICB9CEEAfQgAAAAAAAAAAAAAAAAUAAAAAwANABQAAwAAAAEAAAAwMFwpO18oKg4ABQACBAAUAAMAZWYIAAAAO18oQF8pICB9CEEAfQgAAAAAAAAAAAAAAAAVAAAAAwANABQAAwAAAAEAAAAwMFwpO18oKg4ABQACBAAUAAMAZWYJAAAAO18oQF8pICB9CEEAfQgAAAAAAAAAAAAAAAAWAAAAAwANABQAAwAAAAEAAAAwMFwpO18oKg4ABQACBAAUAAMAzEwEAAAAO18oQF8pICB9CEEAfQgAAAAAAAAAAAAAAAAXAAAAAwANABQAAwAAAAEAAAAwMFwpO18oKg4ABQACBAAUAAMAzEwFAAAAO18oQF8pICB9CEEAfQgAAAAAAAAAAAAAAAAYAAAAAwANABQAAwAAAAEAAAAwMFwpO18oKg4ABQACBAAUAAMAzEwGAAAAO18oQF8pICB9CEEAfQgAAAAAAAAAAAAAAAAZAAAAAwANABQAAwAAAAEAAAAwMFwpO18oKg4ABQACBAAUAAMAzEwHAAAAO18oQF8pICB9CEEAfQgAAAAAAAAAAAAAAAAaAAAAAwANABQAAwAAAAEAAAAwMFwpO18oKg4ABQACBAAUAAMAzEwIAAAAO18oQF8pICB9CEEAfQgAAAAAAAAAAAAAAAAbAAAAAwANABQAAwAAAAEAAAAwMFwpO18oKg4ABQACBAAUAAMAzEwJAAAAO18oQF8pICB9CEEAfQgAAAAAAAAAAAAAAAAcAAAAAwANABQAAwAAAAAAAAAwMFwpO18oKg4ABQACBAAUAAMAMjMEAAAAO18oQF8pICB9CEEAfQgAAAAAAAAAAAAAAAAdAAAAAwANABQAAwAAAAAAAAAwMFwpO18oKg4ABQACBAAUAAMAMjMFAAAAO18oQF8pICB9CEEAfQgAAAAAAAAAAAAAAAAeAAAAAwANABQAAwAAAAAAAAAwMFwpO18oKg4ABQACBAAUAAMAMjMGAAAAO18oQF8pICB9CEEAfQgAAAAAAAAAAAAAAAAfAAAAAwANABQAAwAAAAAAAAAw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AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP7/AAAKAAIAAAAAAAAAAAAAAAAAAAAAAAEAAAAC1c3VnC4bEJOXCAArLPmuMAAAAMAAAAAIAAAAAQAAAEgAAAAXAAAAUAAAAAsAAABYAAAAEAAAAGAAAAATAAAAaAAAABYAAABwAAAADQAAAHgAAAAMAAAAnQAAAAIAAADkBAAAAwAAAAAAEAALAAAAAAAAAAsAAAAAAAAACwAAAAAAAAALAAAAAAAAAB4QAAABAAAAGQAAAFZUXzIwXzcwMDBfRW5jcnlwdGVkLnR4dAAMEAAAAgAAAB4AAAALAAAAV29ya3NoZWV0cwADAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAgAAAAMAAAAEAAAABQAAAAYAAAAHAAAACAAAAAkAAAAKAAAACwAAAAwAAAANAAAADgAAAA8AAAAQAAAAEQAAABIAAAATAAAAFAAAABUAAAAWAAAA/v///xgAAAAZAAAAGgAAABsAAAAcAAAAHQAAAB4AAAD+////IAAAACEAAAAiAAAAIwAAACQAAAAlAAAAJgAAAP7////9/////v///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////1IAbwBvAHQAIABFAG4AdAByAHkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAWAAUB//////////8CAAAAIAgCAAAAAADAAAAAAAAARgAAAAAAAAAAAAAAADAaN5AONtUB/v///wAAAAAAAAAAVwBvAHIAawBiAG8AbwBrAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABIAAgH///////////////8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAsi0AAAAAAAAFAFMAdQBtAG0AYQByAHkASQBuAGYAbwByAG0AYQB0AGkAbwBuAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAKAACAQEAAAADAAAA/////wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABcAAAAAEAAAAAAAAAUARABvAGMAdQBtAGUAbgB0AFMAdQBtAG0AYQByAHkASQBuAGYAbwByAG0AYQB0AGkAbwBuAAAAAAAAAAAAAAA4AAIB////////////////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAHwAAAAAQAAAAAAAA";
        byte[] fileByte = Base64.getDecoder().decode(file64);
        inputStream = new ByteArrayInputStream(fileByte);
        extensionFile = "xls";
      } else if (THANHSON_NAME.equals(fileName)) {
        file64 = "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";
        byte[] fileByte = Base64.getDecoder().decode(file64);
        inputStream = new ByteArrayInputStream(fileByte);
        contentType = APPLICATION_VND_MS_EXCEL_XLSX;
        extensionFile = "xlsx";
      }

      response.addHeader("Content-disposition",
          "attachment;filename=" + fileName + "." + extensionFile);
      response.setContentType(contentType);

      // Copy the stream to the response's output stream.
      if (inputStream != null) {
        IOUtils.copy(inputStream, response.getOutputStream());
      }
      response.flushBuffer();

    } catch (IOException e) {
      LOGGER.error(
          String.format("Error writing file to output stream. Filename was '{%s}'", fileName), e);
      throw new RuntimeException("IOError writing file to output stream");
    }
  }

  @RequestMapping(value = "/findProviderProfiles", method = RequestMethod.POST)
  @ResponseBody
  public FindProviderProfileResponse findProviderProfiles(HttpServletRequest request)
      throws FrontEndException {

    //TODO ROLE
    String providerCode = request.getParameter(PROVIDER_RQP);
    FindProviderProfileRequest requestProfile = new FindProviderProfileRequest(providerCode);
    return epinStoreEndpoint.findProviderProfiles(requestProfile);
  }

  private List<SpecialCustomerItem> getListSpecialCustomer() throws Exception {
    List<SpecialCustomerItem> lstPrivateMerchantItems = new ArrayList<>();
    try {

      FindSpecialCustomerRequest request = new FindSpecialCustomerRequest();
      request.setIsActive(true);

      FindSpecialCustomerResponse response = epinStoreEndpoint.getPrivateMerchant(request);
      if (response != null && response.getStatus().getCode() == 0) {
        lstPrivateMerchantItems = response.getSpecialCustomerList();
      }
    } catch (Exception ex) {
      LOGGER.error(ex.getMessage());
    }
    return lstPrivateMerchantItems;
  }

}
