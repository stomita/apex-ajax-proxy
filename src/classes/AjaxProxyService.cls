public with sharing class AjaxProxyService {
	public class AjaxProxyException extends Exception {}

	static Set<String> METHODS = new Set<String> { 'GET', 'POST', 'PUT', 'DELETE' };

	public AjaxProxyService() {}

	public Map<String, Object> request(Map<String, Object> params) {
		Http h = new Http();
		HttpRequest req = new HttpRequest();
		String url = (String)params.get('url');
		if (url == null) {
			throw new AjaxProxyException('request url is not provided');
		}
		req.setEndpoint(url);
		String method = (String)params.get('method');
		if (method == null) { method = 'GET'; }
		method = method.toUpperCase();
		if (!METHODS.contains(method)) {
			throw new AjaxProxyException('request method is not valid');
		}
		req.setMethod(method);
		Map<String, String> reqHeaders = (Map<String, String>)params.get('headers');
		if (reqHeaders != null) {
			System.debug(reqHeaders.keySet());
			for (String key: reqHeaders.keySet()) {
				if (key != null) {
					req.setHeader(key, reqHeaders.get(key));
				}
			}
		}
		String body = (String)params.get('body');
		if (body != null) {
			req.setBody(body);
		}
		HttpResponse res = h.send(req);
		Map<String, String> resHeaders = new Map<String, String>();
		System.debug(res.getHeaderKeys());
		for (String key: res.getHeaderKeys()) {
			if (key != null) {
				resHeaders.put(key, res.getHeader(key));
			}
		}
		return new Map<String, Object> {
			'status' => res.getStatus(),
			'statusCode' => res.getStatusCode(),
			'headers' => resHeaders,
			'body' => res.getBody()
		};
	}
}
