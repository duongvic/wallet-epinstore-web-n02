package vn.mog.ewallet.web.controller.dashboard.beans;

import java.util.HashMap;
import java.util.List;

/**
 * Created by binhminh on 02/03/2017.
 */
public class FaceValueWaring {

  private HashMap<String, List<Integer>> faceValueWaring;

  public HashMap<String, List<Integer>> getFaceValueWaring() {
    return (faceValueWaring == null) ? new HashMap<String, List<Integer>>() : faceValueWaring;
  }

  public void setFaceValueWaring(HashMap<String, List<Integer>> faceValueWaring) {
    this.faceValueWaring = faceValueWaring;
  }
}
