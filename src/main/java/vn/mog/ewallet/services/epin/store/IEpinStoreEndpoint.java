package vn.mog.ewallet.services.epin.store;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
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
import vn.mog.ewallet.web.contract.CardProvider;
import vn.mog.ewallet.web.controller.dashboard.beans.CardStatus;
import vn.mog.ewallet.web.controller.dashboard.beans.CardType;
import vn.mog.ewallet.web.controller.po.beans.PurchaseOrderStatus;
import vn.mog.framework.contract.base.MobiliserResponseType;

public interface IEpinStoreEndpoint {

  CreateFullPurchaseOrderResponse createFullPurchaseOrder(CreateFullPurchaseOrderRequest request)
      throws FrontEndException;

  UpdatePurchaseOrderResponse updatePurchaseOrder(UpdatePurchaseOrderRequest request)
      throws FrontEndException;

  CreateAttachmentResponse updatePurchaseOrderAttachment(CreateAttachmentRequest request)
      throws FrontEndException;

  ChangePurchaseOrderStatusResponse updatePurchaseOrderStatus(
      ChangePurchaseOrderStatusRequest request) throws FrontEndException;

  FindPurchaseOrderResponse findPurchaseOrders(FindPurchaseOrderRequest request)
      throws FrontEndException;

  VerifyPurchaseOrderFileResponse verifyPurchaseOrderFile(VerifyPurchaseOrderFileRequest request)
      throws FrontEndException;

  PurchaseOrderFlowApproveResponse verifyPOApprove(PurchaseOrderFlowApproveRequest request)
      throws FrontEndException;

  PurchaseOrderFlowRejectResponse verifyPOReject(PurchaseOrderFlowRejectRequest request)
      throws FrontEndException;

  List<CardProvider> listProvider() throws FrontEndException;

  List<CardType> listType() throws FrontEndException;

  List<CardStatus> listCardStatus() throws FrontEndException;

  GetPurchaseOrderResponse getPurchaseOrder(GetPurchaseOrderRequest request)
      throws FrontEndException;

  FindCardResponse findCards(FindCardRequest request) throws FrontEndException;

  PurchaseOrderFlowStartProcessResponse startPurchaseOrder(
      PurchaseOrderFlowStartProcessRequest request) throws FrontEndException;

  PurchaseOrderFlowSubmitProcessResponse submitPurchaseOrder(
      PurchaseOrderFlowSubmitProcessRequest request) throws FrontEndException;

  GetCardDashBoardResponse getCardDashBoard(GetCardDashBoardRequest request)
      throws FrontEndException;

  List<PurchaseOrderStatus> listPOStatus() throws FrontEndException;

  FindProviderProfileResponse findProviderProfiles(FindProviderProfileRequest request)
      throws FrontEndException;


  /*Special Customer*/
  FindSpecialCustomerResponse getPrivateMerchant(FindSpecialCustomerRequest request)
      throws FrontEndException;

  GetSpecialCustomerResponse getAccount (GetSpecialCustomerRequest request)throws Exception;

  MobiliserResponseType removeAccount(DeleteSpecialCustomerRequest request)throws Exception;

  AddOrUpdateSpecialCustomerResponse addAccount(AddOrUpdateSpecialCustomerRequest request)throws Exception;

  AddOrUpdateSpecialCustomerResponse updateAccount(AddOrUpdateSpecialCustomerRequest request)throws Exception;

  MobiliserResponseType changeStatus(ChangeStatusSpecialCustomerRequest request)throws Exception;

  TransferPOToOtherCustomerResponse transferToMerchant(TransferPOToOtherCustomerRequest request) throws Exception;

  TransferPOToGeneralStoreResponse transferToGeneral(TransferPOToGeneralStoreRequest request) throws Exception;
}
