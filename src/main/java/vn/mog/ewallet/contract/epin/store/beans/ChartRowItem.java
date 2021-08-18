package vn.mog.ewallet.contract.epin.store.beans;

import java.io.Serializable;

/**
 * Created by binhminh on 20/12/2016.
 */

@SuppressWarnings("serial")
public class ChartRowItem implements Serializable {

  private String header;
  private String faceValue;
  private Long cardInputted;
  private Long cardSold;
  private Long cardActivate;
  private Long cardDeactivate;
  private Long cardPreExpired;
  private Long cardExpired;
  private Long leverWarning;

  public ChartRowItem() {

  }

  public ChartRowItem(String header, String faceValue, Long cardInputted, Long cardSold, long cardActivate, long cardDeactivate, long cardPreExpired,
      long cardExpired) {
    this.header = header;
    this.faceValue = faceValue;
    this.cardInputted = cardInputted;
    this.cardSold = cardSold;
    this.cardActivate = cardActivate;
    this.cardDeactivate = cardDeactivate;
    this.setCardPreExpired(cardPreExpired);
    this.setCardExpired(cardExpired);
  }

  public ChartRowItem(String cardType, String faceValue, long cardInputted, long cardSold, long cardActivate, long cardDeactivate, long cardPreExpired,
      long cardExpired, long levelWarning) {
    this.header = cardType;
    this.faceValue = faceValue;
    this.cardInputted = cardInputted;
    this.cardSold = cardSold;
    this.cardActivate = cardActivate;
    this.cardDeactivate = cardDeactivate;
    this.cardPreExpired = cardPreExpired;
    this.cardExpired = cardExpired;
    this.leverWarning = levelWarning;
  }

  public String getFaceValue() {
    return faceValue;
  }

  public void setFaceValue(String faceValue) {
    this.faceValue = faceValue;
  }

  public Long getLeverWarning() {
    return leverWarning;
  }

  public void setLeverWarning(Long leverWarning) {
    this.leverWarning = leverWarning;
  }

  public String getHeader() {
    return header;
  }

  public void setHeader(String header) {
    this.header = header;
  }

  public Long getCardInputted() {
    return cardInputted;
  }

  public void setCardInputted(Long cardInputted) {
    this.cardInputted = cardInputted;
  }

  public Long getCardSold() {
    return cardSold;
  }

  public void setCardSold(Long cardSold) {
    this.cardSold = cardSold;
  }

  public Long getCardActivate() {
    return cardActivate;
  }

  public void setCardActivate(Long cardActivate) {
    this.cardActivate = cardActivate;
  }

  public Long getCardDeactivate() {
    return cardDeactivate;
  }

  public void setCardDeactivate(Long cardDeactivate) {
    this.cardDeactivate = cardDeactivate;
  }

  public Long getCardPreExpired() {
    return cardPreExpired;
  }

  public void setCardPreExpired(Long cardPreExpired) {
    this.cardPreExpired = cardPreExpired;
  }

  public Long getCardExpired() {
    return cardExpired;
  }

  public void setCardExpired(Long cardExpired) {
    this.cardExpired = cardExpired;
  }
}
