package vn.mog.ewallet.web.filters;

import java.beans.PropertyEditorSupport;
import org.apache.commons.lang3.StringUtils;
import org.springframework.web.util.HtmlUtils;

/**
 * Created by binhminh on 28/09/2017.
 */
public class HtmlEscapeStringEditor extends PropertyEditorSupport {

  // encode content in *.properties
  @Override
  public String getAsText() {
    String out = (String) getValue();
    if (out == null) {
      out = StringUtils.EMPTY;
    }
    return out;
  }

  @Override
  public void setAsText(String text) throws IllegalArgumentException {
    String out = StringUtils.EMPTY;
    if (text != null) {
      out = HtmlUtils.htmlEscape(text.trim());
    }
    setValue(out);
  }
}