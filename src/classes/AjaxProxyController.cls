global with sharing class AjaxProxyController {
	static AjaxProxyService ajaxProxy = new AjaxProxyService();

	@AuraEnabled
	@RemoteAction
	global static Map<String, Object> request(Map<String, Object> params) {
		return ajaxProxy.request(params);
	}
}
