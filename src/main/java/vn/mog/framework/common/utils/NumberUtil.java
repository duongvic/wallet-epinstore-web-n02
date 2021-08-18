package vn.mog.framework.common.utils;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;

public class NumberUtil {

  private static final Logger LOG = Logger.getLogger(NumberUtil.class);

  public static String formatNumber(Long x) {
    try {
      return String.format("%,d", x).replace(',', '.');
    } catch (NumberFormatException e) {
    }
    return "";
  }

  public static String formatNumber(String x) {
    try {
      return String.format("%,d", convertToLong(x)).replace(',', '.');
    } catch (NumberFormatException e) {
    }
    return "";
  }

  public static int randomNumber(int min, int max) {
    int range = (max - min) + 1;
    Random random = new Random();
    int result = random.nextInt(range) + min;

    return result;
  }

  public static List<Long> convertListToLong(String[] params) {
    List<Long> items = new ArrayList<>();
    for (String item : params) {
      items.add(NumberUtil.convertToLong(item));
    }
    return items;
  }

  public static List<Integer> convertListToInt(String[] params) {
    List<Integer> items = new ArrayList<>();
    for (String item : params) {
      items.add(NumberUtil.convertToInt(item));
    }
    return items;
  }

  public static Long convertToLong(String number) {
    try {
      if (StringUtils.isEmpty(number)) {
        return 0L;
      }
      Long n = Long.parseLong(number);
      return n;
    } catch (Exception ex) {
      LOG.error(ex.getMessage());
      return 0L;
    }

  }

  public static int convertToInt(String number) {
    try {
      if (StringUtils.isEmpty(number)) {
        return 0;
      }
      int n = Integer.parseInt(number);
      return n;
    } catch (Exception ex) {
      LOG.error(ex.getMessage());
      return 0;
    }

  }

  public static Double convertToDouble(String number) {
    try {
      if (StringUtils.isEmpty(number)) {
        return 0D;
      }
      Double n = Double.parseDouble(number);
      return n;
    } catch (Exception ex) {
      LOG.error(ex.getMessage());
      return 0D;
    }

  }
}
