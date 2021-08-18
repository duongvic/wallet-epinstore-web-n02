package vn.mog.ewallet.web.utils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import vn.mog.ewallet.contract.epin.store.beans.POFileCompareResult;
import vn.mog.ewallet.contract.epin.store.beans.PurchaseOrderDetailItem;

public class FileCompareUtil {

  public static List<POFileCompareResult> compare(List<PurchaseOrderDetailItem> pODetailList, List<PurchaseOrderDetailItem> pOFileList) {

    List<POFileCompareResult> result = new ArrayList<POFileCompareResult>();
    Map<String, PurchaseOrderDetailItem> dbDetailMap = new LinkedHashMap();
    Map<String, PurchaseOrderDetailItem> fileDetailMap = new LinkedHashMap();
    Map<String, Integer> keyMap = new HashMap();

    for (PurchaseOrderDetailItem item : pODetailList) {
      String key = item.getCardType() + item.getFaceValue();
      dbDetailMap.put(key, item);
      keyMap.put(key, 0);
    }

    for (PurchaseOrderDetailItem item : pOFileList) {
      String key = item.getCardType() + item.getFaceValue();
      fileDetailMap.put(key, item);
      keyMap.put(key, 0);
    }

    for (Map.Entry<String, Integer> entry : keyMap.entrySet()) {
      String key = entry.getKey();
      PurchaseOrderDetailItem declared = dbDetailMap.remove(key);
      PurchaseOrderDetailItem file = fileDetailMap.remove(key);
      POFileCompareResult rs = new POFileCompareResult();

      if (declared == null && file != null) {
        declared = new PurchaseOrderDetailItem();
        declared.setCardType(file.getCardType());
        declared.setFaceValue(file.getFaceValue());
        declared.setQuantity(0);
        rs.setMatch(false);
      } else if (file == null && declared != null) {
        file = new PurchaseOrderDetailItem();
        file.setCardType(declared.getCardType());
        file.setFaceValue(declared.getFaceValue());
        file.setQuantity(0);
        rs.setMatch(false);
      } else {
        if (file.getQuantity().equals(declared.getQuantity())) {
          rs.setMatch(true);
        }
      }
      rs.setDeclared(declared);
      rs.setFile(file);
      result.add(rs);
    }

    return result;
  }
}
