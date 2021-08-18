package vn.mog.ewallet.web.controller.dashboard.beans;

public enum CardType {
  // TelCard
  VIETTEL("VTM", "VIETTEL"),
  MOBIFONE("VMS", "MOBIFONE"),
  VINAPHONE("VNP", "VINAPHONE"),
  VNMOBILE("VNM", "VNMOBILE"),
  GMOBILE("GMOBILE", "GMOBILE"),
  BEELINE("BEELINE","BEELINE"),

  // GameCard
  GATE("GATE", "GATE"),
  VCOIN("VCOIN", "VCOIN"),
  ZING("ZING", "ZING"),
  GARENA("GARENA", "GARENA"),
  ONCASH("ONCASH", "ONCASH"),
  BIT("BIT", "BIT"),
  VCARD("VCARD", "VCARD"),
  VINPLAY("VINPLAY", "VINPLAY"),
  ANPAY("ANPAY", "ANPAY"),
  MGC("MGC", "MEGACARD"),
  APPOTA("APPOTA", "APPOTA"),
  SOHA("SOHA","SOHA"),
  FUNCARD("FUNCARD","FUNCARD"),
  SOFTNYX("SOFTNYX","SOFTNYX"),
  SCOIN("SCOIN","SCOIN"),

  // Data Card
  DATA_VINAPHONE("DT_VNP", "DATA_VINAPHONE"), //vinaPhone
  DATA_MOBIFONE("DT_VMS", "DATA_MOBIFONE"), // DataCode mobiPhone
  DATA_VIETTEL("DT_VTM", "DATA_VIETTEL"); //viettel3G

  public String code;
  public String name;

  private CardType(String code, String name) {
    this.code = code;
    this.name = name;
  }

  public static CardType getCardType(String label) {
    for (CardType cardType : CardType.values()) {
      if (cardType.name().equalsIgnoreCase(label) || cardType.code.equalsIgnoreCase(label) || cardType.name
          .equalsIgnoreCase(label)) {
        return cardType;
      }
    }
    return null;
  }

  public static void main(String[] args) {
    System.out.println(getCardType("VTM"));
  }

  public String getName() {
    return name;
  }

  public String getCode() {
    return code;
  }
}
