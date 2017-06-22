public with sharing class AjaxProxyController {
	static AjaxProxyService ajaxProxy = new AjaxProxyService();

	@AuraEnabled
	@RemoteAction
	public static Map<String, Object> request(Map<String, Object> params) {
		return ajaxProxy.request(params);
	}
}
