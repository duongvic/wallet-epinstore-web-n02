package vn.mog.ewallet.contract.epin.store;

import java.io.Serializable;
import java.util.List;
import vn.mog.ewallet.contract.epin.store.beans.Attachment;

@SuppressWarnings("serial")
public class CreateAttachmentRequest extends CreateAttachmentRequestType implements Serializable {

  public CreateAttachmentRequest(List<Attachment> attachment, String note) {
    this.attachment = attachment;
    this.note = note;
  }

  public CreateAttachmentRequest() {

  }
}
