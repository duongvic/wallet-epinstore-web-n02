package vn.mog.ewallet.contract.epin.store;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import vn.mog.ewallet.contract.epin.store.beans.Attachment;
import vn.mog.ewallet.contract.epin.store.beans.PurchaseOrderItem;
import vn.mog.framework.contract.base.MobiliserRequestType;

@SuppressWarnings("serial")
public class CreateFullPurchaseOrderRequestType extends MobiliserRequestType implements Serializable {

  protected PurchaseOrderItem purchaseOrder;
  protected List<Attachment> attachments;

  public PurchaseOrderItem getPurchaseOrder() {
    return purchaseOrder;
  }

  public void setPurchaseOrder(PurchaseOrderItem purchaseOrder) {
    this.purchaseOrder = purchaseOrder;
  }

  public List<Attachment> getAttachments() {
    if (attachments == null) {
      attachments = new ArrayList<Attachment>();
    }
    return attachments;
  }

  public void setAttachments(List<Attachment> attachments) {
    this.attachments = attachments;
  }
}
