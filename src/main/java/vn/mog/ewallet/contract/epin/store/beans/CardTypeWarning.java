package vn.mog.ewallet.contract.epin.store.beans;

import java.util.HashMap;

/**
 * Created by binhminh on 02/03/2017.
 */
public class CardTypeWarning {

  private String dateModify;

  private HashMap<String, FaceValueWaring> telcoWarings;

  public String getDateModify() {
    return dateModify;
  }

  public void setDateModify(String dateModify) {
    this.dateModify = dateModify;
  }

  public HashMap<String, FaceValueWaring> getTelcoWarings() {
    return telcoWarings;
  }

  public void setTelcoWarings(HashMap<String, FaceValueWaring> telcoWarings) {
    this.telcoWarings = telcoWarings;
  }
}
