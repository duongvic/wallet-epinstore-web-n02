package vn.mog.ewallet.services.walletservice.impl;

import static vn.mog.ewallet.constant.SharedConstants.PLATFORM_BACKEND_EPINSTORE_SERVICE_API_ENDPOINT;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.oauth2.client.OAuth2RestTemplate;
import org.springframework.stereotype.Service;
import vn.mog.ewallet.contract.customer.CustomerRequest;
import vn.mog.ewallet.contract.customer.CustomerResponse;
import vn.mog.ewallet.exception.FrontEndException;
import vn.mog.ewallet.services.walletservice.IWaletServiceEndpoint;
import vn.mog.framework.contract.base.MobiliserRequestType;

@Service
public class WalletServiceEndpoint implements IWaletServiceEndpoint {

  @Autowired
  OAuth2RestTemplate restTemplate;

  @Override
  public CustomerResponse findCustomer(String username, String cif, String email, String phone) throws FrontEndException {
    CustomerRequest request = new CustomerRequest();
    request.setUsername(username);
    request.setCif(cif);
    request.setEmail(email);
    request.setMsisdn(phone);

    return (CustomerResponse) restTemplate.postForEntity(PLATFORM_BACKEND_EPINSTORE_SERVICE_API_ENDPOINT + "/api/customer/findCustomer", request, CustomerResponse.class).getBody();
  }

  @Override
  public long getBalance() throws FrontEndException {
    return (long) restTemplate.postForEntity(PLATFORM_BACKEND_EPINSTORE_SERVICE_API_ENDPOINT + "/api/customer/getBalance", new MobiliserRequestType(), Long.class).getBody();
  }
}
