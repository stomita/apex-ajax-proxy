global with sharing class AjaxProxyController {
	public AjaxProxyController() {}

	@AuraEnabled
	@RemoteAction
	global static Map<String, Object> request(Map<String, Object> params) {
		Http h = new Http();
		HttpRequest req = new HttpRequest();
		String url = (String)params.get('url');
		req.setEndpoint(url);
		String method = (String)params.get('method');
		req.setMethod(method);
		Map<String, String> reqHeaders = (Map<String, String>)params.get('headers');
		if (reqHeaders != null) {
			for (String key: reqHeaders.keySet()) {
				req.setHeader(key, reqHeaders.get(key));
			}
		}
		String body = (String)params.get('body');
		if (body != null) {
			req.setBody(body);
		}
		HttpResponse res = h.send(req);
		Map<String, String> resHeaders = new Map<String, String>();
		for (String key: res.getHeaderKeys()) {
			resHeaders.put(key, res.getHeader(key));
		}
		return new Map<String, Object> {
			'status' => res.getStatus(),
			'statusCode' => res.getStatusCode(),
			'headers' => resHeaders,
			'body' => res.getBody()
		};
	}
}
