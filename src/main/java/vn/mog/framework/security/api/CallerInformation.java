package vn.mog.framework.security.api;

import java.util.List;

public final class CallerInformation {

  private final String accessToken;
  private final Long actorId;// CustomerID
  private final String actorCif;// CustomerCIF
  private final int actorType;// CustomerType
  private final String actorIdentifier;// UserName
  private final List<String> actorPrivs;
  private final String ip;
  private final String userAgent;

  public CallerInformation(String accessToken, Long actorId, String actorCif, int actorType, String actorIdentifier, List<String> actorPrivs, String ip,
      String userAgent) {
    this.accessToken = accessToken;
    this.actorId = actorId;
    this.actorCif = actorCif;
    this.actorType = actorType;
    this.actorIdentifier = actorIdentifier;
    this.actorPrivs = actorPrivs;
    this.ip = ip;
    this.userAgent = userAgent;
  }

  public String getAccessToken() {
    return accessToken;
  }

  public Long getActorId() {
    return this.actorId;
  }

  public String getActorCif() {
    return actorCif;
  }

  public int getActorType() {
    return actorType;
  }

  public String getActorIdentifier() {
    return this.actorIdentifier;
  }

  public List<String> getActorPrivs() {
    return this.actorPrivs;
  }

  public String getIp() {
    return this.ip;
  }

  public String getUserAgent() {
    return this.userAgent;
  }

  public boolean hasPrivilege(String privilege) {
    final String prefix = "ROLE_";
    String strPrivilege = privilege.toUpperCase().trim();
    if (!strPrivilege.startsWith(prefix)) {
      strPrivilege = prefix + strPrivilege;
    }
    if (this.actorPrivs.contains(strPrivilege) || this.actorPrivs.contains(strPrivilege.replace(prefix, ""))) {
      return true;
    }
    return false;
  }
}
