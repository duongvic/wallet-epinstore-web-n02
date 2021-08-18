package vn.mog.ewallet.contract.epin.store.beans;

import java.io.Serializable;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

@SuppressWarnings("serial")
public class PurchaseOrderDetailItem implements Serializable {

  private Long id;
  private Long poId;
  private String cardType;
  private Integer faceValue;
  private Integer quantity;
  private Double discountRate;

  // sort PO Detail items when return client
  @SuppressWarnings({"unchecked", "rawtypes"})
  public static void order(List<PurchaseOrderDetailItem> items) {

    Collections.sort(items, new Comparator() {

      public int compare(Object o1, Object o2) {
        // 1st sort by card type
        String x1 = ((PurchaseOrderDetailItem) o1).getCardType();
        String x2 = ((PurchaseOrderDetailItem) o2).getCardType();
        int sComp = x1.compareTo(x2);

        if (sComp != 0) {
          return sComp;
        } else {
          // 2st sort by face value
          Integer x3 = ((PurchaseOrderDetailItem) o1).getFaceValue();
          Integer x4 = ((PurchaseOrderDetailItem) o2).getFaceValue();
          return x3.compareTo(x4);
        }
      }
    });
  }

  public Long getId() {
    return id;
  }

  public void setId(Long id) {
    this.id = id;
  }

  public Long getPoId() {
    return poId;
  }

  public void setPoId(Long poId) {
    this.poId = poId;
  }

  public String getCardType() {
    return cardType;
  }

  public void setCardType(String cardType) {
    this.cardType = cardType;
  }

  public Integer getFaceValue() {
    return faceValue;
  }

  public void setFaceValue(Integer faceValue) {
    this.faceValue = faceValue;
  }

  public Integer getQuantity() {
    return quantity;
  }

  public void setQuantity(Integer quantity) {
    this.quantity = quantity;
  }

  public Double getDiscountRate() {
    return discountRate;
  }

  public void setDiscountRate(Double discountRate) {
    this.discountRate = discountRate;
  }
}
