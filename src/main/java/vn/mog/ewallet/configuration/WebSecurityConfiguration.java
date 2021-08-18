package vn.mog.ewallet.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.security.oauth2.client.EnableOAuth2Sso;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.web.header.writers.StaticHeadersWriter;
import vn.mog.ewallet.constant.SharedConstants;
import vn.mog.ewallet.security.authentication.CustomAccessDeniedHandler;
import vn.mog.ewallet.security.authentication.CustomAuthenticationEntryPoint;

@Configuration
@EnableOAuth2Sso
@EnableWebSecurity
@EnableGlobalMethodSecurity(securedEnabled = true, prePostEnabled = true)
public class WebSecurityConfiguration extends WebSecurityConfigurerAdapter {

  private static String[] ROLE_CONFIG = new String[]{"STAFF", "MERCHANT", "CUSTOMER"};
  public static String UAA_URL_REDIRECT_LOGOUT = String.format("%s/logout?pre=%s", SharedConstants.WEB_DOMAIN_PLATFORM_UAA_URL, SharedConstants.WEB_DOMAIN_PLATFORM_OPERATION_SUBPATH_EPIN_STORE_N02_URL);


  @Autowired
  private CustomAuthenticationEntryPoint authenticationEntryPoint;

  @Autowired
  private CustomAccessDeniedHandler customAccessDeniedHandler;

  @Override
  protected void configure(HttpSecurity httpSecurity) throws Exception {

    // CSP (Content Security Policy)
    httpSecurity.headers().addHeaderWriter(
        new StaticHeadersWriter("X-Content-Security-Policy",
            "script-src 'self' www.google-analytics.com",
        "font-src 'self' https://fonts.googleapis.com"));
    // TODO, Khi trien khai product, add them

    httpSecurity.headers().xssProtection();

    // Content Type Options
    httpSecurity.headers().contentTypeOptions();

    // HTTP Strict Transport Security (HSTS)
    // httpSecurity.headers().httpStrictTransportSecurity();

    // X-Frame-Options
    httpSecurity.headers().frameOptions();

    // don't create session
    /*
     * httpSecurity.sessionManagement().sessionCreationPolicy(
     * SessionCreationPolicy.STATELESS);
     */
    httpSecurity.sessionManagement().maximumSessions(1);
    httpSecurity.sessionManagement().invalidSessionUrl("/logout");
    /* Session Fixation Protection with Spring Security */
    //httpSecurity.sessionManagement().sessionFixation().migrateSession();
    //httpSecurity.sessionManagement().invalidSessionUrl(UAA_URL_REDIRECT_LOGOUT);
    httpSecurity.sessionManagement().sessionAuthenticationErrorUrl(UAA_URL_REDIRECT_LOGOUT);

    /* disable csrf */
    /* httpSecurity.csrf().disable(); */

    httpSecurity

        .exceptionHandling().authenticationEntryPoint(authenticationEntryPoint).and()

        .authorizeRequests()
        .antMatchers(HttpMethod.GET, "/*.html", "/**/favicon.ico", "/**/*.html", "/**/*.css", "/**/*.js", "/**/*.json", "/**/*.js.map",
            "/**/*.png", "/**/*.jpg", "/**/*.ttf", "/**/*.woff", "/**/*.woff2").permitAll()
        .antMatchers("/resources/**", "/error/**").permitAll()
        .antMatchers(HttpMethod.GET, "/").permitAll()

        .and().logout()
        .logoutUrl("/logout")
        .logoutSuccessUrl(UAA_URL_REDIRECT_LOGOUT)
        .deleteCookies("JSESSIONID")
        .clearAuthentication(true)
        .invalidateHttpSession(true).permitAll()

        .and().exceptionHandling().accessDeniedHandler(customAccessDeniedHandler);

    // Custom JWT based security filter
    // httpSecurity.addFilterBefore(new MDCFilter(),
    // UsernamePasswordAuthenticationFilter.class);
    // httpSecurity.addFilterBefore(jwtAuthFilter,
    // UsernamePasswordAuthenticationFilter.class);
    // httpSecurity.addFilterBefore(xssFilter,
    // UsernamePasswordAuthenticationFilter.class);

    // disable page caching
    httpSecurity.headers().cacheControl();
  }
}
