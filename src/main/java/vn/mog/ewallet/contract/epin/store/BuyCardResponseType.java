package vn.mog.ewallet.contract.epin.store;

import vn.mog.framework.contract.base.MobiliserResponseType;

@SuppressWarnings("serial")
public class BuyCardResponseType extends MobiliserResponseType {

  private String listCard;

  public BuyCardResponseType() {
    super();
    // TODO Auto-generated constructor stub
  }

  public String getListCard() {
    return listCard;
  }

  public void setListCard(String listCard) {
    this.listCard = listCard;
  }

}
