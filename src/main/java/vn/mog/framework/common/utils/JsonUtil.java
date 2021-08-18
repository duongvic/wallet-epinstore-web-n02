package vn.mog.framework.common.utils;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.log4j.Logger;

/**
 * Created by binhminh on 06/12/2016.
 */
public class JsonUtil {

  protected static ObjectMapper objectMapper = new ObjectMapper();
  private static Logger log = Logger.getLogger(JsonUtil.class);

  public static String objectToJson(Object obj) {
    try {
      return objectMapper.writeValueAsString(obj);
    } catch (JsonProcessingException e) {
      log.error("objectToJson", e);
    }
    return null;
  }
}
