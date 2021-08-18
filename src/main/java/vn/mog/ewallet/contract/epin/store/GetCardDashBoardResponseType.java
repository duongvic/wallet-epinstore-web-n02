package vn.mog.ewallet.contract.epin.store;

import java.util.List;
import java.util.Map;
import vn.mog.ewallet.contract.epin.store.beans.CardDashBoardItem;
import vn.mog.ewallet.contract.epin.store.beans.CardDashBoardItemTable;
import vn.mog.ewallet.contract.epin.store.beans.PieChartItem;
import vn.mog.ewallet.contract.epin.store.beans.StoreNotfInfo;
import vn.mog.framework.contract.base.MobiliserResponseType;

@SuppressWarnings("serial")
public class GetCardDashBoardResponseType extends MobiliserResponseType {

  private List<PieChartItem> lineMap;
  private List<PieChartItem> pieProvider;
  private List<PieChartItem> pieCardType;
  private List<PieChartItem> pieFaceValue;

  private List<CardDashBoardItem> cardDashBoardItems;
  private List<CardDashBoardItemTable> cardDashBoardItemsTable;

  private Map<String, Map<Integer, StoreNotfInfo>> warningLevelResult;

  public List<PieChartItem> getLineMap() {
    return lineMap;
  }

  public void setLineMap(List<PieChartItem> lineMap) {
    this.lineMap = lineMap;
  }

  public List<PieChartItem> getPieProvider() {
    return pieProvider;
  }

  public void setPieProvider(List<PieChartItem> pieProvider) {
    this.pieProvider = pieProvider;
  }

  public List<PieChartItem> getPieCardType() {
    return pieCardType;
  }

  public void setPieCardType(List<PieChartItem> pieCardType) {
    this.pieCardType = pieCardType;
  }

  public List<PieChartItem> getPieFaceValue() {
    return pieFaceValue;
  }

  public void setPieFaceValue(List<PieChartItem> pieFaceValue) {
    this.pieFaceValue = pieFaceValue;
  }

  public List<CardDashBoardItem> getCardDashBoardItems() {
    return cardDashBoardItems;
  }

  public void setCardDashBoardItems(List<CardDashBoardItem> cardDashBoardItems) {
    this.cardDashBoardItems = cardDashBoardItems;
  }

  public List<CardDashBoardItemTable> getCardDashBoardItemsTable() {
    return cardDashBoardItemsTable;
  }

  public void setCardDashBoardItemsTable(List<CardDashBoardItemTable> cardDashBoardItemsTable) {
    this.cardDashBoardItemsTable = cardDashBoardItemsTable;
  }

  public Map<String, Map<Integer, StoreNotfInfo>> getWarningLevelResult() {
    return warningLevelResult;
  }

  public void setWarningLevelResult(Map<String, Map<Integer, StoreNotfInfo>> warningLevelResult) {
    this.warningLevelResult = warningLevelResult;
  }
}
