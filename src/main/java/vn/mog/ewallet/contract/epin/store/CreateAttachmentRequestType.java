package vn.mog.ewallet.contract.epin.store;

import java.io.Serializable;
import java.util.List;
import vn.mog.ewallet.contract.epin.store.beans.Attachment;
import vn.mog.framework.contract.base.MobiliserRequestType;

@SuppressWarnings("serial")
public class CreateAttachmentRequestType extends MobiliserRequestType implements Serializable {

  protected List<Attachment> attachment;
  protected String note;

  public List<Attachment> getAttachment() {
    return attachment;
  }

  public void setAttachment(List<Attachment> attachment) {
    this.attachment = attachment;
  }

  public String getNote() {
    return note;
  }

  public void setNote(String note) {
    this.note = note;
  }
}
