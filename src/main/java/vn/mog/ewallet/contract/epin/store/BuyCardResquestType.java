package vn.mog.ewallet.contract.epin.store;

import vn.mog.framework.contract.base.MobiliserRequestType;

@SuppressWarnings("serial")
public class BuyCardResquestType extends MobiliserRequestType {

  private String cardType;
  private Integer faceValue;
  private Integer quantity;
  private Double commission;
  private String customerCif;
  private String customerId;

  public BuyCardResquestType() {
    super();
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

  public Double getCommission() {
    return commission;
  }

  public void setCommission(Double commission) {
    this.commission = commission;
  }

  public String getCustomerCif() {
    return customerCif;
  }

  public void setCustomerCif(String customerCif) {
    this.customerCif = customerCif;
  }

  public String getCustomerId() {
    return customerId;
  }

  public void setCustomerId(String customerId) {
    this.customerId = customerId;
  }
}
