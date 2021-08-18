package vn.mog.framework.common.utils;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateUtils;

/**
 * Created by binhminh on 17/07/2017.
 */
public class DateUtil {

  public static String dateToString(String format, Date date) { // lay ra
    // ngay,
    // thang, nam,
    // gio, phu,
    // giay hien
    // tai
    try {
      return new SimpleDateFormat(format).format(date);
    } catch (Exception e) {
    }
    return StringUtils.EMPTY;
  }

  public static Date stringToDate(String sDate, String format) {
    try {
      return new SimpleDateFormat(format).parse(sDate);
    } catch (Exception e) {
    }
    return null;
  }

  public static boolean isDate(String sDate, String format) {
    try {
      new SimpleDateFormat(format).parse(sDate);
      return true;
    } catch (Exception e) {
      return false;
    }
  }

  public static String getDateAfterNumberDay(int soNgayAfterCurrentDay) {
    try {
      Calendar calendar = Calendar.getInstance();
      calendar.setTime(new Date());
      calendar.add(Calendar.DAY_OF_YEAR, soNgayAfterCurrentDay);

      return dateToString("dd/MM/yyyy", calendar.getTime());
    } catch (Exception e) {

    }
    return "";
  }

  public static Date addTime(Date date, int hour, int minutes, int second) {
    Calendar calendar = new GregorianCalendar();
    calendar.setTime(date);
    calendar.set(Calendar.HOUR_OF_DAY, hour);
    calendar.set(Calendar.MINUTE, minutes);
    calendar.set(Calendar.SECOND, second);

    return calendar.getTime();
  }

  public static Date getEndOfDay(Date date) {
    return DateUtils.addMilliseconds(DateUtils.ceiling(date, Calendar.DATE), -1);
  }

  public static Date getStartOfDay(Date date) {
    return DateUtils.truncate(date, Calendar.DATE);
  }
}
