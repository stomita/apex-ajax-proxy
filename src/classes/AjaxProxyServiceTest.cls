@isTest
private class AjaxProxyServiceTest {

	public class HttpCalloutMockImpl implements HttpCalloutMock {
		public HttpResponse respond(HttpRequest req) {
			HttpResponse res = new HttpResponse();
			// Create a fake response
			res.setHeader('Content-Type', 'application/json');
			res.setBody('{"foo":"bar"}');
			res.setStatusCode(200);
			return res;
		}
	}

	@isTest
	static void testAjaxProxyRequest() {
		Test.setMock(HttpCalloutMock.class, new HttpCalloutMockImpl());
		AjaxProxyService proxy = new AjaxProxyService();
		Map<String, Object> req = new Map<String, Object> {
			'method' => 'GET',
			'url' => 'http://www.example.com',
			'headers' => new Map<String, String> {
				'X-TEST-TOKEN' => 'abcd123'
			}
		};
		Map<String, Object> res = proxy.request(req);
		System.assert(res.get('status') == 200);
		System.assert(res.get('body') == '{"foo":"bar"}');
	}
}