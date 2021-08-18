package vn.mog.ewallet.web.utils;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Component;

/**
 * Created by binhminh on 11/10/2017.
 */
@Component
public class ValidationUtil {

  public static final String MESAGE_ERROR = "message.response.value.error";
  public static final String MESAGE_SUCCESS = "message.response.value.success";

  public static final String MESAGE_ERROR_EPIN_FOLLOW = "message.error.epin.follow";
  public static final String MESAGE_ERROR_EPIN_FOLLOW_PARAM = "message.error.epin.follow.param";

  @Autowired
  protected MessageSource messageSource;

  public String notify(String code) {
    return messageSource.getMessage(code, null, LocaleContextHolder.getLocale());
  }

  public String notify(String code, String defaultMessage) {
    return messageSource.getMessage(code, null, (defaultMessage == null) ? "Thực hiện lỗi" : defaultMessage, LocaleContextHolder.getLocale());
  }

  public String notify(String code, Object[] params) {
    return messageSource.getMessage(code, params, LocaleContextHolder.getLocale());
  }

}
