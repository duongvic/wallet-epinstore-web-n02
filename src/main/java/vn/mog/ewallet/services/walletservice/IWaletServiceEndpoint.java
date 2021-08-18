package vn.mog.ewallet.services.walletservice;

import vn.mog.ewallet.contract.customer.CustomerResponse;
import vn.mog.ewallet.exception.FrontEndException;

public interface IWaletServiceEndpoint {

  CustomerResponse findCustomer(String username, String cif, String email, String phone) throws FrontEndException;

  long getBalance() throws FrontEndException;

}
