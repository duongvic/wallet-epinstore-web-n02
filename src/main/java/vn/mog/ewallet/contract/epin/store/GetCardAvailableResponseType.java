package vn.mog.ewallet.contract.epin.store;

import java.util.Map;
import vn.mog.framework.contract.base.MobiliserResponseType;

@SuppressWarnings("serial")
public class GetCardAvailableResponseType extends MobiliserResponseType {

  private Map<Integer, Long> cardAvailable;

  public Map<Integer, Long> getCardAvailable() {
    return cardAvailable;
  }

  public void setCardAvailable(Map<Integer, Long> cardAvailable) {
    this.cardAvailable = cardAvailable;
  }
}
