package vn.mog.ewallet.web.contract;

import java.util.LinkedHashMap;
import java.util.Map;

/**
 * Created by binhminh on 28/12/2016.
 */
public enum CardFaceValue {
  TEN(10000, "10.000"), TWENTY(20000, "20.000"), THIRTY(30000, "30.000"), FIFTY(50000, "50.000"), HUNDRED(100000, "100.000"), TWO_HUNDRED(200000,
      "200.000"), THREE_HUNDRED(300000, "300.000"), FIVE_HUNDRED(500000, "500.000"), ONE_MILLION(1000000, "1.000.000"), TWO_MILLION(2000000, "2.000.000");

  public static final Map<Integer, String> FULL_FACE_VALUE = new LinkedHashMap<>();

  static {
    FULL_FACE_VALUE.put(TEN.code, TEN.name);
    FULL_FACE_VALUE.put(TWENTY.code, TWENTY.name);
    FULL_FACE_VALUE.put(THIRTY.code, THIRTY.name);
    FULL_FACE_VALUE.put(FIFTY.code, FIFTY.name);
    FULL_FACE_VALUE.put(HUNDRED.code, HUNDRED.name);

    FULL_FACE_VALUE.put(TWO_HUNDRED.code, TWO_HUNDRED.name);
    FULL_FACE_VALUE.put(THREE_HUNDRED.code, THREE_HUNDRED.name);
    FULL_FACE_VALUE.put(FIVE_HUNDRED.code, FIVE_HUNDRED.name);
    FULL_FACE_VALUE.put(ONE_MILLION.code, ONE_MILLION.name);
    FULL_FACE_VALUE.put(TWO_MILLION.code, TWO_MILLION.name);
  }

  public int code;
  public String name;

  private CardFaceValue(int code, String name) {
    this.code = code;
    this.name = name;
  }

  public String getName() {
    return name;
  }

  public Integer getCode() {
    return code;
  }
}
