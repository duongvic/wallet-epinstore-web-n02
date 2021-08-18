package vn.mog.ewallet.contract.epin.store;

import java.util.Collection;
import vn.mog.ewallet.contract.epin.store.beans.PurchaseOrderItem;
import vn.mog.framework.contract.base.MobiliserResponseType;

@SuppressWarnings("serial")
public class FindPurchaseOrderResponseType extends MobiliserResponseType {

  private Collection<PurchaseOrderItem> purchaseOrders;
  private Long count;// tổng số PO
  private Long quantity;// tổng số card
  private Long amount;// tổng mệnh giá
  private Long capital;// tổng giá mua

  public Collection<PurchaseOrderItem> getPurchaseOrders() {
    return purchaseOrders;
  }

  public void setPurchaseOrders(Collection<PurchaseOrderItem> purchaseOrders) {
    this.purchaseOrders = purchaseOrders;
  }

  public Long getCount() {
    if (count == null) {
      count = 0l;
    }
    return count;
  }

  public void setCount(Long count) {
    this.count = count;
  }

  public Long getQuantity() {
    if (quantity == null) {
      quantity = 0l;
    }
    return quantity;
  }

  public void setQuantity(Long quantity) {
    this.quantity = quantity;
  }

  public Long getAmount() {
    return amount;
  }

  public void setAmount(Long amount) {
    this.amount = amount;
  }

  public Long getCapital() {
    return capital;
  }

  public void setCapital(Long capital) {
    this.capital = capital;
  }
}
