package vn.mog.ewallet.contract.epin.store;

import java.util.List;

public class DataTableResponse<T> {
  private Long draw;
  private Long recordsTotal;
  private Long recordsFiltered;
  private List<T> dataList;

  public Long getDraw() {
    return draw;
  }

  public void setDraw(Long draw) {
    this.draw = draw;
  }

  public Long getRecordsTotal() {
    return recordsTotal;
  }

  public void setRecordsTotal(Long recordsTotal) {
    this.recordsTotal = recordsTotal;
  }

  public Long getRecordsFiltered() {
    return recordsFiltered;
  }

  public void setRecordsFiltered(Long recordsFiltered) {
    this.recordsFiltered = recordsFiltered;
  }

  public List<T> getDataList() {
    return dataList;
  }

  public void setDataList(List<T> dataList) {
    this.dataList = dataList;
  }
}
