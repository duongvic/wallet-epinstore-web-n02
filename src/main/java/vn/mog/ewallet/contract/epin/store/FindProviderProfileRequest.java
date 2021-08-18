package vn.mog.ewallet.contract.epin.store;

@SuppressWarnings("serial")
public class FindProviderProfileRequest extends FindProviderProfileRequestType {

  public FindProviderProfileRequest(String providerCode) {
    this.providerCode = providerCode;
  }
}
