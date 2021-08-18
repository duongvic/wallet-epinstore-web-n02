package vn.mog.ewallet.contract.epin.store.beans;

/**
 * Created by binhminh on 20/12/2016.
 */
public enum Stage {
  OFF(0), ON(1);

  private int value;

  private Stage(int value) {
    this.value = value;
  }

  public int value() {
    return this.value;
  }
}
