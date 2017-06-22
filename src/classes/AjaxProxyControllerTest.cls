@isTest
public class AjaxProxyControllerTest {

	@isTest
	static void testAjaxProxyRequest() {
		Test.setMock(HttpCalloutMock.class, new AjaxProxyServiceTest.HttpCalloutMockImpl());
		AjaxProxyController.request(new Map<String, Object> {
			'url' => 'http://www.example.com'
		});
	}
}
