package vn.mog.ewallet.web.controller.dashboard.beans;

public enum CardStatus {
  // NOTAVAILABLE(0), IN_STOCK(1), SOLD(2), EXPIRED(3), NEAR_EXP(4);

  NOTAVAILABLE(0, "cardStatus.notavailable"), IN_STOCK(1, "cardStatus.instock"), SOLD(2, "cardStatus.sold"), EXPIRED(3, "cardStatus.expired"), NEAR_EXP(4,
      "cardStatus.near.exp");

  public int code;
  public String name;

  CardStatus(int value, String name) {
    this.code = value;
    this.name = name;
  }

  public static CardStatus getCardStatus(int value) {
    for (CardStatus status : CardStatus.values()) {
      if (status.code == value) {
        return status;
      }
    }
    return null;
  }

  public int getCode() {
    return this.code;
  }

  public String getName() {
    return this.name;
  }

}
