package vn.mog.ewallet.web.controller.dashboard.beans;

import java.util.LinkedHashMap;
import java.util.Map;

public enum UpType {
  NEW(0, "po.type.enter.new"), REUP(1, "po.type.re.enter");

  private int code;
  private String name;

  public static final Map<Integer, String> FULL_UP_TYPE = new LinkedHashMap<>();

  static {
    FULL_UP_TYPE.put(NEW.code, NEW.name);
    FULL_UP_TYPE.put(REUP.code, REUP.name);
  }

  UpType(int code, String name) {
    this.code = code;
    this.name = name;
  }

  public int getCode() {
    return code;
  }

  public String getName() {
    return name;
  }

  public static UpType getUpTypeByName(String label) {
    for (UpType item : UpType.values()) {
      if (item.name().equalsIgnoreCase(label) || item.name.equalsIgnoreCase(label)) {
        return item;
      }
    }
    return null;
  }

  public static UpType getUpTypeByCode(Integer code) {
    if (code == null) {
      return null;
    }

    for (UpType item : UpType.values()) {
      if (item.code == code) {
        return item;
      }
    }
    return null;
  }
}
