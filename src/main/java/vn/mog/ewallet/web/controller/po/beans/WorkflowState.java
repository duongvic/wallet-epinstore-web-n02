package vn.mog.ewallet.web.controller.po.beans;

public enum WorkflowState {

  INIT(0, "po.state.declared"), REJECTED(1, "po.state.rejected"), READY_TO_VERIFY(2, "po.state.wait.approve"), CONFIRMED(4, "po.state.approved");

  public int code;
  public String displayText;

  private WorkflowState(int value, String displayText) {
    this.code = value;
    this.displayText = displayText;
  }

  public static WorkflowState getWorkFlowState(int value) {
    for (WorkflowState state : WorkflowState.values()) {
      if (state.code == value) {
        return state;
      }
    }
    return null;
  }

  public int value() {
    return this.code;
  }

  public String displayText() {
    return this.displayText;
  }
}
