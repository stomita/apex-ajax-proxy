@isTest
public class AjaxProxyServiceTest {

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
		Map<String, Object> req1 = new Map<String, Object> {
			'url' => 'http://www.example.com'
		};
		Map<String, Object> res1 = proxy.request(req1);
		System.assert(res1.get('statusCode') == 200);
		System.assert(res1.get('body') == '{"foo":"bar"}');

		Map<String, Object> req2 = new Map<String, Object> {
			'method' => 'POST',
			'url' => 'http://www.example.com',
			'headers' => new Map<String, String> {
				'Content-Type' => 'application/json'
			},
			'body' => '{"abc":"def"}'
		};
		Map<String, Object> res2 = proxy.request(req2);
		System.assert(res2.get('statusCode') == 200);
		System.assert(res2.get('body') == '{"foo":"bar"}');

		try {
			Map<String, Object> req3 = new Map<String, Object> {};
			Map<String, Object> res3 = proxy.request(req3);
			System.assert(false);
		} catch (Exception e) {
			System.assert(true);
		}

		try {
			Map<String, Object> req4 = new Map<String, Object> {
				'method' => 'UNKNOWN',
				'url' => 'http://www.example.com'
			};
			Map<String, Object> res4 = proxy.request(req4);
			System.assert(false);
		} catch (Exception e) {
			System.assert(true);
		}
	}
}
