package vn.mog.ewallet.contract.epin.store;

import vn.mog.ewallet.contract.epin.store.beans.CardItem;
import vn.mog.framework.contract.base.MobiliserResponseType;

@SuppressWarnings("serial")
public class GetCardItemResponseType extends MobiliserResponseType {

  protected CardItem cardItem;

  public CardItem getCardItem() {
    return cardItem;
  }

  public void setCardItem(CardItem cardItem) {
    this.cardItem = cardItem;
  }
}
