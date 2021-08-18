package vn.mog.ewallet.contract.epin.store.beans;

import java.io.Serializable;
import vn.mog.ewallet.web.controller.dashboard.beans.CardType;

@SuppressWarnings("serial")
public class CardDashBoardItemTable implements Serializable {

  private CardType cardType;
  private Integer faceValue;
  private Long inCard;
  private Long outCard;

  public CardType getCardType() {
    return cardType;
  }

  public void setCardType(CardType cardType) {
    this.cardType = cardType;
  }

  public Integer getFaceValue() {
    return faceValue;
  }

  public void setFaceValue(Integer faceValue) {
    this.faceValue = faceValue;
  }

  public Long getInCard() {
    return inCard;
  }

  public void setInCard(Long inCard) {
    this.inCard = inCard;
  }

  public Long getOutCard() {
    return outCard;
  }

  public void setOutCard(Long outCard) {
    this.outCard = outCard;
  }

}
