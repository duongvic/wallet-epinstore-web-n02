package vn.mog.ewallet.web.filters;

/*
 * @WebFilter(filterName = "CompressResponseFilter", urlPatterns =
 * {"/balance/balance-monitoring
 *//*
 * ", "/setting/account-setting
 *//*
 * ", "/dashboard
 *//*
 * ", "/merchant-po
 *//*
 * ", "/wallet/fund-in-history
 *//*
 * ", "/wallet/fund-in
 *//*
 * ", "/wallet/fund-out-history
 *//*
 * ", "/wallet/fund-out
 *//*
 * ", "/provider/provider-profile
 *//*
 * ", "/wallet/balance-deduction-reconcilation-report
 *//*
 * ", "/service/service-profile
 *//*
 * ", "/wallet/money-transfer
 *//*
 * ", "/service/transaction-history
 *//*
 * ", "/service/reversal-history
 *//*
 * ", "/transaction/rule
 *//*
 * "}) public class
 * CompressResponseFilter
 * implements Filter {
 *
 * private HtmlCompressor
 * compressor;
 *
 *
 * public void
 * doFilter(ServletRequest req,
 * ServletResponse resp,
 * FilterChain chain) throws
 * IOException, ServletException {
 *
 * HttpServletRequest httpReq =
 * (HttpServletRequest) req; if
 * ("GET".equals(httpReq.getMethod(
 * ))) { CharResponseWrapper
 * responseWrapper = new
 * CharResponseWrapper((
 * HttpServletResponse) resp);
 * chain.doFilter(req,
 * responseWrapper); String
 * servletResponse = new
 * String(responseWrapper.toString(
 * )); resp.getWriter().write(
 * compressor.compress(
 * servletResponse)); } }
 *
 *
 * public void init(FilterConfig
 * config) throws ServletException
 * { compressor = new
 * HtmlCompressor(); //
 * compressor.setCompressCss(true);
 * //
 * compressor.setCompressJavaScript
 * (true);
 * compressor.setRemoveMultiSpaces(
 * true); }
 *
 * public void destroy() { }
 *
 * }
 */
