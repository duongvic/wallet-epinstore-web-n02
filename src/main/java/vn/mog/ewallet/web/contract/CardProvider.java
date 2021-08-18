package vn.mog.ewallet.web.contract;

public enum CardProvider {
  VIETTEL(1, "Viettel Telecom"),
  /* VNPAY(2, "VnPay JSC"), */ // anhtatuan: do not remove comment
  VNTP(3, "Vinatopup"),
  EPAY(4, "EPAY JSC"),
  VTC(5, "VTC Intecom"),
  /* ESALE(6, "ESALE"),*/ // anhtatuan: do not remove comment
  ZOTA(7, "ZO-TA JSC"),
  MOBIFONE(8, "Mobifone"),
  VINPLAY(9, "Vinplay"),
  ZOPAY(10, "ZOPAY"),
  APPOTA(11, "Appota"),
  VPAY(11, "VPAY"),
  THANHSON(12, "Thanh Sơn"),
  GARENA(13, "Garena"),
  IMEDIA(14, "IMEDIA"),
  IOMEDIA(15, "IOMEDIA"),
  WHYPAY(16, "WHYPAY"),
  FIVIPAY1(17, "FIVIPAY1"),
  VIETTELPAY(18, "Viettel Pay"),
  TRANPHAT(19, "TRANPHAT")
  ;

  // Why is CardProvider frontend different from CardProvider backend ?

  public int code;
  public String name;

  private CardProvider(int code, String name) {
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
