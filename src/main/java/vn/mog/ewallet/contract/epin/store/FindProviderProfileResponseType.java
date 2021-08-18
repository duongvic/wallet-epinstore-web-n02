package vn.mog.ewallet.contract.epin.store;

import java.util.Collection;
import vn.mog.ewallet.web.controller.po.beans.ProviderProfile;
import vn.mog.framework.contract.base.MobiliserResponseType;

@SuppressWarnings("serial")
public class FindProviderProfileResponseType extends MobiliserResponseType {

  private Collection<ProviderProfile> providerProfiles;

  public Collection<ProviderProfile> getProviderProfiles() {
    return providerProfiles;
  }

  public void setProviderProfiles(Collection<ProviderProfile> providerProfiles) {
    this.providerProfiles = providerProfiles;
  }
}
