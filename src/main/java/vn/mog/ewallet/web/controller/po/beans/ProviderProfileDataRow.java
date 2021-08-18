package vn.mog.ewallet.web.controller.po.beans;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.io.Serializable;

@Data
@AllArgsConstructor
public class ProviderProfileDataRow implements Serializable {
  private static final long serialVersionUID = 1L;

  private String providerCode;
  private String serviceType;
  private String cardType;
  private Long faceValue;
  private Double discountRate;
}
