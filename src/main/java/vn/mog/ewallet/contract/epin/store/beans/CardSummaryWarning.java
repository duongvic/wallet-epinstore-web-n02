package vn.mog.ewallet.contract.epin.store.beans;

/**
 * Created by binhminh on 16/03/2017.
 */
public class CardSummaryWarning {

  private String faceValue;
  private long level;

  public CardSummaryWarning(String faceValue, long level) {
    this.faceValue = faceValue;
    this.level = level;
  }

  public String getFaceValue() {
    return faceValue;
  }

  public void setFaceValue(String faceValue) {
    this.faceValue = faceValue;
  }

  public long getLevel() {
    return level;
  }

  public void setLevel(long level) {
    this.level = level;
  }
}
