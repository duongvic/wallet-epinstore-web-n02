package vn.mog.ewallet.contract.epin.store;

import java.util.Collection;
import vn.mog.ewallet.contract.epin.store.beans.CardItem;
import vn.mog.ewallet.contract.epin.store.beans.PurchaseOrderDetailItem;
import vn.mog.framework.contract.base.MobiliserResponseType;

@SuppressWarnings("serial")
public class VerifyPurchaseOrderFileResponseType extends MobiliserResponseType {

  private Collection<PurchaseOrderDetailItem> pODetailList;

  private Collection<PurchaseOrderDetailItem> pOFileList;

  private Collection<CardItem> cardItems;

  private boolean equal;

  private long totalQuantityDB;
  private long totalValueDB;
  private long totalQuantityFile;
  private long totalValueFile;
  private String note;

  private long existedPinQuantity;
  private long existedSerialQuantity;
  private String existedFileName;
  private byte[] existedFile;

  public Collection<PurchaseOrderDetailItem> getpODetailList() {
    return pODetailList;
  }

  public void setpODetailList(Collection<PurchaseOrderDetailItem> pODetailList) {
    this.pODetailList = pODetailList;
  }

  public Collection<PurchaseOrderDetailItem> getpOFileList() {
    return pOFileList;
  }

  public void setpOFileList(Collection<PurchaseOrderDetailItem> pOFileList) {
    this.pOFileList = pOFileList;
  }

  public boolean isEqual() {
    return equal;
  }

  public void setEqual(boolean equal) {
    this.equal = equal;
  }

  public long getTotalQuantityDB() {
    return totalQuantityDB;
  }

  public void setTotalQuantityDB(long totalQuantityDB) {
    this.totalQuantityDB = totalQuantityDB;
  }

  public long getTotalValueDB() {
    return totalValueDB;
  }

  public void setTotalValueDB(long totalValueDB) {
    this.totalValueDB = totalValueDB;
  }

  public long getTotalQuantityFile() {
    return totalQuantityFile;
  }

  public void setTotalQuantityFile(long totalQuantityFile) {
    this.totalQuantityFile = totalQuantityFile;
  }

  public long getTotalValueFile() {
    return totalValueFile;
  }

  public void setTotalValueFile(long totalValueFile) {
    this.totalValueFile = totalValueFile;
  }

  public String getNote() {
    return note;
  }

  public void setNote(String note) {
    this.note = note;
  }

  public Collection<CardItem> getCardItems() {
    return cardItems;
  }

  public void setCardItems(Collection<CardItem> cardItems) {
    this.cardItems = cardItems;
  }

  public long getExistedPinQuantity() {
    return existedPinQuantity;
  }

  public void setExistedPinQuantity(long existedPinQuantity) {
    this.existedPinQuantity = existedPinQuantity;
  }

  public long getExistedSerialQuantity() {
    return existedSerialQuantity;
  }

  public void setExistedSerialQuantity(long existedSerialQuantity) {
    this.existedSerialQuantity = existedSerialQuantity;
  }

  public String getExistedFileName() {
    return existedFileName;
  }

  public void setExistedFileName(String existedFileName) {
    this.existedFileName = existedFileName;
  }

  public byte[] getExistedFile() {
    return existedFile;
  }

  public void setExistedFile(byte[] existedFile) {
    this.existedFile = existedFile;
  }
}
