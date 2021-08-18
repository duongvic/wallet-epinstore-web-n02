package vn.mog.ewallet.web.controller.po.beans;

public enum PurchaseOrderStatus {

  INACTIVE(0, "po.status.inactive"), ACTIVE(1, "po.status.active"), NA(2, "po.status.na");

  public int code;
  public String name;

  // private PurchaseOrderStatus(int value) {
  // this.code = value;
  // }
  PurchaseOrderStatus(int value, String name) {

    this.code = value;
    this.name = name;
  }

  //
  // public static PurchaseOrderStatus getByValue(String value) {
  // for (PurchaseOrderStatus item : PurchaseOrderStatus.values()) {
  // if (value.equalsIgnoreCase(String.valueOf(item.code))) {
  // return item;
  // }
  // }
  // return null;
  // }
  public static PurchaseOrderStatus getPurchaseOrderStatus(int value) {
    for (PurchaseOrderStatus item : PurchaseOrderStatus.values()) {
      if (item.code == value) {
        return item;
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
