package vn.mog.ewallet.contract.epin.store;

import vn.mog.ewallet.contract.epin.store.beans.CardItem;
import vn.mog.framework.contract.base.MobiliserRequestType;

@SuppressWarnings("serial")
public class CreateCardItemRequestType extends MobiliserRequestType {

  protected CardItem cardItem;

  public CardItem getCardItem() {
    return cardItem;
  }

  public void setCardItem(CardItem cardItem) {
    this.cardItem = cardItem;
  }
}
