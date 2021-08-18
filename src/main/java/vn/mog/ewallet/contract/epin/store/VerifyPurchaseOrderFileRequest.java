package vn.mog.ewallet.contract.epin.store;

@SuppressWarnings("serial")
public class VerifyPurchaseOrderFileRequest extends VerifyPurchaseOrderFileRequestType {

  public VerifyPurchaseOrderFileRequest(Long poId, String password) {
    this.poId = poId;
    this.password = password;
  }

  public VerifyPurchaseOrderFileRequest() {

  }
}
