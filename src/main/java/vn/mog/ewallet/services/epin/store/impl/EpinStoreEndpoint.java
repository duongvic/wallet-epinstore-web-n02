package vn.mog.ewallet.services.epin.store.impl;

import static vn.mog.ewallet.constant.SharedConstants.PLATFORM_BACKEND_EPINSTORE_SERVICE_API_ENDPOINT;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.oauth2.client.OAuth2RestTemplate;
import org.springframework.stereotype.Service;
import vn.mog.ewallet.contract.epin.store.AddOrUpdateSpecialCustomerRequest;
import vn.mog.ewallet.contract.epin.store.AddOrUpdateSpecialCustomerResponse;
import vn.mog.ewallet.contract.epin.store.ChangePurchaseOrderStatusRequest;
import vn.mog.ewallet.contract.epin.store.ChangePurchaseOrderStatusResponse;
import vn.mog.ewallet.contract.epin.store.ChangeStatusSpecialCustomerRequest;
import vn.mog.ewallet.contract.epin.store.CreateAttachmentRequest;
import vn.mog.ewallet.contract.epin.store.CreateAttachmentResponse;
import vn.mog.ewallet.contract.epin.store.CreateFullPurchaseOrderRequest;
import vn.mog.ewallet.contract.epin.store.CreateFullPurchaseOrderResponse;
import vn.mog.ewallet.contract.epin.store.DeleteSpecialCustomerRequest;
import vn.mog.ewallet.contract.epin.store.FindCardRequest;
import vn.mog.ewallet.contract.epin.store.FindCardResponse;
import vn.mog.ewallet.contract.epin.store.FindProviderProfileRequest;
import vn.mog.ewallet.contract.epin.store.FindProviderProfileResponse;
import vn.mog.ewallet.contract.epin.store.FindPurchaseOrderRequest;
import vn.mog.ewallet.contract.epin.store.FindPurchaseOrderResponse;
import vn.mog.ewallet.contract.epin.store.FindSpecialCustomerRequest;
import vn.mog.ewallet.contract.epin.store.FindSpecialCustomerResponse;
import vn.mog.ewallet.contract.epin.store.GetCardDashBoardRequest;
import vn.mog.ewallet.contract.epin.store.GetCardDashBoardResponse;
import vn.mog.ewallet.contract.epin.store.GetPurchaseOrderRequest;
import vn.mog.ewallet.contract.epin.store.GetPurchaseOrderResponse;
import vn.mog.ewallet.contract.epin.store.GetSpecialCustomerRequest;
import vn.mog.ewallet.contract.epin.store.GetSpecialCustomerResponse;
import vn.mog.ewallet.contract.epin.store.TransferPOToGeneralStoreRequest;
import vn.mog.ewallet.contract.epin.store.TransferPOToGeneralStoreResponse;
import vn.mog.ewallet.contract.epin.store.TransferPOToOtherCustomerRequest;
import vn.mog.ewallet.contract.epin.store.TransferPOToOtherCustomerResponse;
import vn.mog.ewallet.contract.epin.store.UpdatePurchaseOrderRequest;
import vn.mog.ewallet.contract.epin.store.UpdatePurchaseOrderResponse;
import vn.mog.ewallet.contract.epin.store.VerifyPurchaseOrderFileRequest;
import vn.mog.ewallet.contract.epin.store.VerifyPurchaseOrderFileResponse;
import vn.mog.ewallet.contract.epin.store.follow.PurchaseOrderFlowApproveRequest;
import vn.mog.ewallet.contract.epin.store.follow.PurchaseOrderFlowApproveResponse;
import vn.mog.ewallet.contract.epin.store.follow.PurchaseOrderFlowRejectRequest;
import vn.mog.ewallet.contract.epin.store.follow.PurchaseOrderFlowRejectResponse;
import vn.mog.ewallet.contract.epin.store.follow.PurchaseOrderFlowStartProcessRequest;
import vn.mog.ewallet.contract.epin.store.follow.PurchaseOrderFlowStartProcessResponse;
import vn.mog.ewallet.contract.epin.store.follow.PurchaseOrderFlowSubmitProcessRequest;
import vn.mog.ewallet.contract.epin.store.follow.PurchaseOrderFlowSubmitProcessResponse;
import vn.mog.ewallet.exception.FrontEndException;
import vn.mog.ewallet.services.epin.store.IEpinStoreEndpoint;
import vn.mog.ewallet.web.contract.CardProvider;
import vn.mog.ewallet.web.controller.dashboard.beans.CardStatus;
import vn.mog.ewallet.web.controller.dashboard.beans.CardType;
import vn.mog.ewallet.web.controller.po.beans.PurchaseOrderStatus;
import vn.mog.framework.contract.base.MobiliserResponseType;

@Service
public class EpinStoreEndpoint implements IEpinStoreEndpoint {

  @Autowired
  OAuth2RestTemplate restTemplate;

  @Override
  public CreateFullPurchaseOrderResponse createFullPurchaseOrder(CreateFullPurchaseOrderRequest request) throws FrontEndException {
    return restTemplate.postForEntity(PLATFORM_BACKEND_EPINSTORE_SERVICE_API_ENDPOINT + "/api/createFullPurchaseOrder", request, CreateFullPurchaseOrderResponse.class).getBody();
  }

  @Override
  public UpdatePurchaseOrderResponse updatePurchaseOrder(UpdatePurchaseOrderRequest request) throws FrontEndException {
    return restTemplate.postForEntity(PLATFORM_BACKEND_EPINSTORE_SERVICE_API_ENDPOINT + "/api/updatePurchaseOrder", request, UpdatePurchaseOrderResponse.class).getBody();
  }

  @Override
  public CreateAttachmentResponse updatePurchaseOrderAttachment(CreateAttachmentRequest request) throws FrontEndException {
    return restTemplate.postForEntity(PLATFORM_BACKEND_EPINSTORE_SERVICE_API_ENDPOINT + "/api/createAttachment", request, CreateAttachmentResponse.class).getBody();
  }

  @Override
  public ChangePurchaseOrderStatusResponse updatePurchaseOrderStatus(ChangePurchaseOrderStatusRequest request) throws FrontEndException {
    return restTemplate.postForEntity(PLATFORM_BACKEND_EPINSTORE_SERVICE_API_ENDPOINT + "/api/changePurchaseOrderStatus", request, ChangePurchaseOrderStatusResponse.class).getBody();
  }

  @Override
  public FindPurchaseOrderResponse findPurchaseOrders(FindPurchaseOrderRequest request) throws FrontEndException {
    return restTemplate.postForEntity(PLATFORM_BACKEND_EPINSTORE_SERVICE_API_ENDPOINT + "/api/findPurchaseOrders", request, FindPurchaseOrderResponse.class).getBody();
  }

  @Override
  public VerifyPurchaseOrderFileResponse verifyPurchaseOrderFile(VerifyPurchaseOrderFileRequest request) throws FrontEndException {

    return restTemplate.postForEntity(PLATFORM_BACKEND_EPINSTORE_SERVICE_API_ENDPOINT + "/api/verifyPurchaseOrderFile", request, VerifyPurchaseOrderFileResponse.class).getBody();
  }

  @Override
  public List<CardProvider> listProvider() throws FrontEndException {
    return (List<CardProvider>) restTemplate.postForEntity(PLATFORM_BACKEND_EPINSTORE_SERVICE_API_ENDPOINT + "/api/listProvider", null, List.class).getBody();
  }

  @Override
  public List<CardType> listType() throws FrontEndException {
    return (List<CardType>) restTemplate.postForEntity(PLATFORM_BACKEND_EPINSTORE_SERVICE_API_ENDPOINT + "/api/listOperator", null, List.class).getBody();
  }

  @Override
  public List<CardStatus> listCardStatus() throws FrontEndException {
    return (List<CardStatus>) restTemplate.postForEntity(PLATFORM_BACKEND_EPINSTORE_SERVICE_API_ENDPOINT + "/api/listCardStatus", null, List.class).getBody();
  }

  @Override
  public GetPurchaseOrderResponse getPurchaseOrder(GetPurchaseOrderRequest request) throws FrontEndException {
    return restTemplate.postForEntity(PLATFORM_BACKEND_EPINSTORE_SERVICE_API_ENDPOINT + "/api/getPurchaseOrder", request, GetPurchaseOrderResponse.class).getBody();
  }

  @Override
  public FindCardResponse findCards(FindCardRequest request) throws FrontEndException {
    return restTemplate.postForEntity(PLATFORM_BACKEND_EPINSTORE_SERVICE_API_ENDPOINT + "/api/findCard", request, FindCardResponse.class).getBody();
  }

  @Override
  public PurchaseOrderFlowSubmitProcessResponse submitPurchaseOrder(PurchaseOrderFlowSubmitProcessRequest request) throws FrontEndException {
    return restTemplate.postForEntity(PLATFORM_BACKEND_EPINSTORE_SERVICE_API_ENDPOINT + "/api/workflows/purchaseOrder/submit", request, PurchaseOrderFlowSubmitProcessResponse.class)
        .getBody();
  }

  @Override
  public PurchaseOrderFlowStartProcessResponse startPurchaseOrder(PurchaseOrderFlowStartProcessRequest request) throws FrontEndException {
    return restTemplate
        .postForEntity(PLATFORM_BACKEND_EPINSTORE_SERVICE_API_ENDPOINT + "/api/workflows/purchaseOrder/startProcess", request, PurchaseOrderFlowStartProcessResponse.class)
        .getBody();
  }

  @Override
  public GetCardDashBoardResponse getCardDashBoard(GetCardDashBoardRequest request) throws FrontEndException {
    return restTemplate.postForEntity(PLATFORM_BACKEND_EPINSTORE_SERVICE_API_ENDPOINT + "/api/getCardDashBoard", request, GetCardDashBoardResponse.class).getBody();
  }

  @Override
  public PurchaseOrderFlowApproveResponse verifyPOApprove(PurchaseOrderFlowApproveRequest request) throws FrontEndException {
    return restTemplate.postForEntity(PLATFORM_BACKEND_EPINSTORE_SERVICE_API_ENDPOINT + "/api/workflows/purchaseOrder/approve", request, PurchaseOrderFlowApproveResponse.class)
        .getBody();
  }

  @Override
  public PurchaseOrderFlowRejectResponse verifyPOReject(PurchaseOrderFlowRejectRequest request) throws FrontEndException {
    return restTemplate.postForEntity(PLATFORM_BACKEND_EPINSTORE_SERVICE_API_ENDPOINT + "/api/workflows/purchaseOrder/reject", request, PurchaseOrderFlowRejectResponse.class)
        .getBody();
  }

  @Override
  public List<PurchaseOrderStatus> listPOStatus() throws FrontEndException {
    return (List<PurchaseOrderStatus>) restTemplate.postForEntity(PLATFORM_BACKEND_EPINSTORE_SERVICE_API_ENDPOINT + "/api/listPOStatus", null, List.class).getBody();
  }

  @Override
  public FindProviderProfileResponse findProviderProfiles(FindProviderProfileRequest request) throws FrontEndException {
    return restTemplate.postForEntity(PLATFORM_BACKEND_EPINSTORE_SERVICE_API_ENDPOINT + "/api/findProviderProfiles", request, FindProviderProfileResponse.class).getBody();
  }

  @Override
  public FindSpecialCustomerResponse getPrivateMerchant(FindSpecialCustomerRequest request) throws FrontEndException {
    return restTemplate.postForEntity(PLATFORM_BACKEND_EPINSTORE_SERVICE_API_ENDPOINT + "/api/customer/specialCustomer/find",request, FindSpecialCustomerResponse.class).getBody();
  }

  @Override
  public GetSpecialCustomerResponse getAccount(GetSpecialCustomerRequest request) throws Exception {
    return restTemplate.postForEntity(PLATFORM_BACKEND_EPINSTORE_SERVICE_API_ENDPOINT + "/api/customer/specialCustomer/get",request, GetSpecialCustomerResponse.class).getBody();
  }

  @Override
  public MobiliserResponseType removeAccount(DeleteSpecialCustomerRequest request)
      throws Exception {
    return restTemplate.postForEntity(PLATFORM_BACKEND_EPINSTORE_SERVICE_API_ENDPOINT + "/api/customer/specialCustomer/delete",request, MobiliserResponseType.class).getBody();
  }

  @Override
  public AddOrUpdateSpecialCustomerResponse addAccount(AddOrUpdateSpecialCustomerRequest request)
      throws Exception {
    return restTemplate.postForEntity(PLATFORM_BACKEND_EPINSTORE_SERVICE_API_ENDPOINT + "/api/customer/specialCustomer/add",request, AddOrUpdateSpecialCustomerResponse.class).getBody();
  }

  @Override
  public AddOrUpdateSpecialCustomerResponse updateAccount(AddOrUpdateSpecialCustomerRequest request)
      throws Exception {
    return restTemplate.postForEntity(PLATFORM_BACKEND_EPINSTORE_SERVICE_API_ENDPOINT + "/api/customer/specialCustomer/update",request, AddOrUpdateSpecialCustomerResponse.class).getBody();
  }

  @Override
  public MobiliserResponseType changeStatus(ChangeStatusSpecialCustomerRequest request)
      throws Exception {
    return restTemplate.postForEntity(PLATFORM_BACKEND_EPINSTORE_SERVICE_API_ENDPOINT + "/api/customer/specialCustomer/changeStatus",request, MobiliserResponseType.class).getBody();
  }

  @Override
  public TransferPOToOtherCustomerResponse transferToMerchant(TransferPOToOtherCustomerRequest request)
      throws Exception {
    return restTemplate.postForEntity(PLATFORM_BACKEND_EPINSTORE_SERVICE_API_ENDPOINT + "/api/purchaseOrder/transfer/toOtherCustomer", request, TransferPOToOtherCustomerResponse.class).getBody();
  }

  @Override
  public TransferPOToGeneralStoreResponse transferToGeneral(TransferPOToGeneralStoreRequest request)
      throws Exception {
    return restTemplate.postForEntity(PLATFORM_BACKEND_EPINSTORE_SERVICE_API_ENDPOINT + "/api/purchaseOrder/transfer/toGeneralStore", request, TransferPOToGeneralStoreResponse.class).getBody();
  }

}
