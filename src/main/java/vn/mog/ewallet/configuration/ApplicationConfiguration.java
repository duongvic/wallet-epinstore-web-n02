package vn.mog.ewallet.configuration;

import java.util.ArrayList;
import java.util.List;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.web.client.RestTemplate;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import vn.mog.ewallet.constant.SharedConstants;
import vn.mog.framework.cache.dynacache.PassiveDynaCache;
import vn.mog.framework.cache.dynacache.PassiveDynaHashTableCache;

@Configuration
public class ApplicationConfiguration {

  private PassiveDynaCache passiveDynaCache = new PassiveDynaHashTableCache();

  @Bean
  public PassiveDynaCache passiveDynaCache() {
    return passiveDynaCache;
  }

  @Bean(name = "apiRestTemplate")
  @Primary
  public RestTemplate apiRestTemplate() {
    /*
     * http://stackoverflow.com/questions/13837012/spring-resttemplate-
     * timeout
     */
    HttpComponentsClientHttpRequestFactory rf = new HttpComponentsClientHttpRequestFactory();
    rf.setConnectTimeout(SharedConstants.HTTP_CLIENT_CONNECT_TIMEOUT);
    rf.setConnectionRequestTimeout(SharedConstants.HTTP_CLIENT_SOCKET_TIMEOUT);
    rf.setReadTimeout(SharedConstants.HTTP_CLIENT_SOCKET_TIMEOUT);

    RestTemplate restTemplate = new RestTemplate(rf);

    ObjectMapper lax = new ObjectMapper().configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);

    MappingJackson2HttpMessageConverter jacksonConverter = new MappingJackson2HttpMessageConverter();
    jacksonConverter.setObjectMapper(lax);

    List<HttpMessageConverter<?>> messageConverters = new ArrayList<>();
    messageConverters.add(jacksonConverter);
    return restTemplate;
  }

}
