package vn.mog.ewallet.contract.epin.store.beans;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;

@SuppressWarnings("serial")
public class PieChartItem implements Serializable {

  public static final String ORDER_BY_DATE = "ORDER_BY_DATE";
  public static final String ORDER_BY_FACE_VALUE = "ORDER_BY_FACE_VALUE";
  private static final SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
  private String name;
  private Long value;

  public PieChartItem() {
    super();
  }

  public PieChartItem(String name, Long value) {
    super();
    this.name = name;
    this.value = value;
  }

  @SuppressWarnings({"unchecked", "rawtypes"})
  public static void orderLineChart(List<PieChartItem> items, final String keyOrder) {
    Collections.sort(items, new Comparator() {

      public int compare(Object o1, Object o2) {
        if (keyOrder.equals(ORDER_BY_DATE)) {
          Date x1 = null;
          Date x2 = null;
          try {
            x1 = sdf.parse(((PieChartItem) o1).getName());
            x2 = sdf.parse(((PieChartItem) o2).getName());
          } catch (Exception e) {
            e.printStackTrace();
          }

          return x1.compareTo(x2);
        } else if (keyOrder.equals(ORDER_BY_FACE_VALUE)) {
          Integer x1 = 0;
          Integer x2 = 0;
          try {
            x1 = Integer.parseInt(((PieChartItem) o1).getName());
            x2 = Integer.parseInt(((PieChartItem) o2).getName());
          } catch (Exception e) {
            e.printStackTrace();
          }
          return x1.compareTo(x2);
        }
        return 0;
      }
    });
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }

  public Long getValue() {
    return value;
  }

  public void setValue(Long value) {
    this.value = value;
  }
}
