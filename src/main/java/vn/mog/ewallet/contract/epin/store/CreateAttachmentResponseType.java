package vn.mog.ewallet.contract.epin.store;

import java.io.Serializable;
import java.util.List;
import vn.mog.framework.contract.base.MobiliserResponseType;

@SuppressWarnings("serial")
public class CreateAttachmentResponseType extends MobiliserResponseType implements Serializable {

  protected List<Long> attachmentIds;

  public List<Long> getAttachmentIds() {
    return attachmentIds;
  }

  public void setAttachmentIds(List<Long> attachmentIds) {
    this.attachmentIds = attachmentIds;
  }
}
