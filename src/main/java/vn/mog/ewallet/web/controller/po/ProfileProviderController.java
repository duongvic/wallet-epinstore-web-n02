package vn.mog.ewallet.web.controller.po;

import org.apache.log4j.Logger;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import vn.mog.ewallet.contract.epin.store.FindProviderProfileRequest;
import vn.mog.ewallet.contract.epin.store.FindProviderProfileResponse;
import vn.mog.ewallet.exception.FrontEndException;
import vn.mog.ewallet.web.controller.AbstractController;
import vn.mog.ewallet.web.controller.po.beans.ProviderProfile;
import vn.mog.ewallet.web.controller.po.beans.ProviderProfileDataRow;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import static vn.mog.ewallet.constant.RoleConstants.*;

@Controller
@RequestMapping(value = "/provider/profile-manager")
public class ProfileProviderController extends AbstractController {

  public static final String PROFILE_MANAGER_LIST = "/provider/profile-manager/list";
  private static final Logger log = Logger.getLogger(ProfileProviderController.class);

  @RequestMapping(value = "/list", method = RequestMethod.GET)
  @PreAuthorize("hasAnyRole('" + ADMIN_OPERATION + "','"
      + FINANCESUPPORT_LEADER + "','" + FA_MANAGER + "','" + FINANCE + "','"
      + SALESUPPORT + "','" + SALESUPPORT_MANAGER + "','" + SALESUPPORT_LEADER + "','"
      + SALE_DIRECTOR + "', '"
      + RECONCILIATION + "', '" + RECONCILIATION_LEADER + "','" + CUSTOMERCARE + "','" + CUSTOMERCARE_MANAGER + "')")
  public String profileProviderManager(HttpServletRequest request, ModelMap model)
      throws FrontEndException {

    try {
      model.put("listProvider", epinStoreEndpoint.listProvider());

      String param_providerCode = request.getParameter("provider");

      FindProviderProfileRequest requestProfile = new FindProviderProfileRequest(param_providerCode);
      FindProviderProfileResponse responseProfile = epinStoreEndpoint.findProviderProfiles(requestProfile);

      List<ProviderProfileDataRow> providerProfileDataRows = new ArrayList<>();
      List<ProviderProfile> providerProfiles = (List<ProviderProfile>) responseProfile.getProviderProfiles();
      if (providerProfiles != null && !providerProfiles.isEmpty()) {
        for (ProviderProfile providerProfile : providerProfiles) {
          // Provider Code
          String providerCode = providerProfile.getProviderCode();

          Map<String, Map<Long, Double>> discountRates = providerProfile.getDiscountRates();
          // Card Type
          for (String cardType : discountRates.keySet()) {
            if (!cardType.equalsIgnoreCase("DEFAULT")) {
              // FaceValue & CapitalValue
              Map<Long, Double> faceValueDiscountRates = discountRates.get(cardType);
              for (Long faceValue : faceValueDiscountRates.keySet()) {
                Double discountRate = faceValueDiscountRates.get(faceValue);
                ProviderProfileDataRow providerProfileDataRow = new ProviderProfileDataRow(providerCode, "EPIN", cardType, faceValue, discountRate);
                providerProfileDataRows.add(providerProfileDataRow);
              }
            }
          }
        }
      }


      Long total = 0L;
      Integer offset = 0;
      Integer limit = 50;
      if (request.getParameter("d-49520-p") != null) {
        Integer p = Integer.parseInt(request.getParameter("d-49520-p"));
        offset = limit * (p - 1);
      }

      model.put("list", providerProfileDataRows);
      model.put("provider",param_providerCode);
      model.put("pagesize", limit);
      model.put("offset", offset);
      model.put("total", providerProfileDataRows.size());


    } catch (Exception ex) {
      log.error(ex.getMessage(), ex);
    }

    return "/profile_provider/profile_provider";
  }

}
