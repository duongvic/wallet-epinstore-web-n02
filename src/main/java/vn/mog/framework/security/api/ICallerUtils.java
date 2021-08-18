package vn.mog.framework.security.api;

public interface ICallerUtils {

  public long getCallerId();

  public CallerInformation getCallerInformation();

  public boolean hasPrivilege(String privilege);

}
