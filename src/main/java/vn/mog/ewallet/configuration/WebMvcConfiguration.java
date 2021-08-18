package vn.mog.ewallet.configuration;

import java.util.Locale;
import javax.servlet.MultipartConfigElement;
import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.boot.web.servlet.MultipartConfigFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.security.web.session.HttpSessionEventPublisher;
import org.springframework.web.context.request.RequestContextListener;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.DefaultServletHandlerConfigurer;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.servlet.i18n.CookieLocaleResolver;
import org.springframework.web.servlet.i18n.LocaleChangeInterceptor;
import org.springframework.web.servlet.resource.VersionResourceResolver;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import vn.mog.ewallet.web.filters.AuthenticationInterceptor;
import vn.mog.ewallet.web.filters.LoggingInterceptor;

@Configuration
@EnableWebMvc
public class WebMvcConfiguration extends WebMvcConfigurerAdapter {

  private static String VERSION = "1.0";

  @Bean
  @ConditionalOnMissingBean(RequestContextListener.class)
  public RequestContextListener requestContextListener() {
    return new RequestContextListener();
  }

  @Bean
  public ViewResolver getViewResolver() {
    InternalResourceViewResolver resolver = new InternalResourceViewResolver();
    resolver.setPrefix("/WEB-INF/templates");
    resolver.setSuffix(".jsp");
    return resolver;
  }

  @Override
  public void configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer) {
    configurer.enable();
  }

  // Maps resources path to webapp/resources
  @Override
  public void addResourceHandlers(ResourceHandlerRegistry registry) {

    VersionResourceResolver vrr = new VersionResourceResolver().addFixedVersionStrategy(VERSION, "/**");

    registry.addResourceHandler("/resources/**").addResourceLocations("/resources/");
    registry.addResourceHandler("/assets/**").addResourceLocations("/assets/");

    registry.addResourceHandler("/static/**").addResourceLocations("classpath:/static/").setCachePeriod(60 * 60 * 24 * 365) /*
     * one
     * year
     */
        .resourceChain(true).addResolver(vrr);

    registry.addResourceHandler("/assets/development/static/css/**").addResourceLocations("/assets/development/static/css/").setCachePeriod(604800);
    registry.addResourceHandler("/assets/development/static/js/**").addResourceLocations("/assets/development/static/js/").setCachePeriod(604800);

    registry.addResourceHandler("/assets/development/static/**").addResourceLocations("/assets/development/static/").setCachePeriod(21600);

    registry.addResourceHandler("/favicon.ico", "/assets/favicon.ico").addResourceLocations("/").setCachePeriod(43200);
  }

  /******** i18n *********/
  @Bean
  public LocaleResolver localeResolver() {
    CookieLocaleResolver resolver = new CookieLocaleResolver();
    resolver.setDefaultLocale(new Locale("vi"));
    resolver.setCookieName("ewallet");
    resolver.setCookieMaxAge(43200);
    return resolver;
  }

  @Bean
  public LocaleChangeInterceptor localeChangeInterceptor() {
    LocaleChangeInterceptor lci = new LocaleChangeInterceptor();
    lci.setParamName("lang");
    return lci;
  }

  @Bean
  public ReloadableResourceBundleMessageSource messageSource() {
    ReloadableResourceBundleMessageSource source = new ReloadableResourceBundleMessageSource();
    source.setBasenames("classpath:i18n/common", "classpath:i18n/language", "classpath:i18n/messages"); // name
    // of
    // the
    // resource
    // bundle
    source.setUseCodeAsDefaultMessage(true);
    source.setCacheSeconds(43200);
    source.setDefaultEncoding("UTF-8");
    return source;
  }

  @Bean
  MultipartConfigElement multipartConfigElement() {
    MultipartConfigFactory factory = new MultipartConfigFactory();
    factory.setMaxFileSize("5MB");
    factory.setMaxRequestSize("5MB");
    return factory.createMultipartConfig();
  }

  @Bean
  public AuthenticationInterceptor autenticationInterceptor() {
    return new AuthenticationInterceptor();
  }

  @Bean
  public LoggingInterceptor loggingInterceptor() {
    return new LoggingInterceptor();
  }

  @Bean
  public HttpSessionEventPublisher httpSessionEventPublisher() {
    return new HttpSessionEventPublisher();
  }

  @Override
  public void addInterceptors(InterceptorRegistry registry) {
    super.addInterceptors(registry);
    registry.addInterceptor(localeChangeInterceptor());
    registry.addInterceptor(autenticationInterceptor());
    registry.addInterceptor(loggingInterceptor());
  }
}
