package vn.mog.ewallet.web.utils;

import org.apache.commons.lang3.StringUtils;
import org.springframework.context.i18n.LocaleContextHolder;
import vn.mog.framework.common.utils.NumberUtil;
import vn.mog.framework.common.utils.StringUtil;
import vn.mog.framework.common.utils.Utils;

public class WalletTagLib {

  public static String numberToText(String number) {
    try {
      String langLocal = LocaleContextHolder.getLocale().getLanguage();
      if (langLocal.equals("vi")) {
        return Utils.numberToText(number);
      } else {
        number = number.replaceAll("\\D+", "");
        return Utils.numberToTextEn(NumberUtil.convertToLong(number));
      }
    } catch (Exception ex) {
      return number;
    }
  }

  public static String formatNumber(String number) {
    try {
      Long numberL = NumberUtil.convertToLong(number);
      return NumberUtil.formatNumber(numberL);
    } catch (Exception ex) {
      return StringUtils.EMPTY;
    }
  }

  public static String isSignature(String url, String menu) {
    try {
      if (StringUtils.isNotEmpty(menu)) {
        return url + StringUtil.QUESTION_MARK + "menu=" + menu;
      }
    } catch (Exception e) {
      return url;
    }
    return url;
  }

  public static String toUpperCase(String str) {
    String s = str;
    try {
      return s.toUpperCase();
    } catch (Exception ex) {
      return s;
    }
  }
}
