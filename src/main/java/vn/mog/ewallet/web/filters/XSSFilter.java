package vn.mog.ewallet.web.filters;

import java.io.IOException;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

/**
 * Created by binhminh on 29/09/2017.
 */
@Component
// public class XSSFilter implements Filter {
public class XSSFilter extends OncePerRequestFilter {

  @Override
  protected void doFilterInternal(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, FilterChain filterChain)
      throws ServletException, IOException {

    // Respect the client-specified character encoding
    // (see HTTP specification section 3.4.1)
    if (null == httpServletRequest.getCharacterEncoding()) {
      httpServletRequest.setCharacterEncoding("UTF-8");
    }

    // Set the default response content type and encoding
    httpServletResponse.setContentType("text/html; charset=UTF-8");
    httpServletResponse.setCharacterEncoding("UTF-8");

    filterChain.doFilter(new XSSRequestWrapper(httpServletRequest), httpServletResponse);
  }

  /*
   * @Override public void init(FilterConfig filterConfig) throws
   * ServletException { }
   *
   * @Override public void doFilter(ServletRequest request, ServletResponse
   * response, FilterChain chain) throws IOException, ServletException {
   * chain.doFilter(new XSSRequestWrapper((HttpServletRequest) request),
   * response); }
   *
   * @Override public void destroy() { }
   */
}
