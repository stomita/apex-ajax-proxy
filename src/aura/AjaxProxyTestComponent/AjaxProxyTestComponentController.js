({
	init: function(cmp, event, helper) {
		var proxy = helper.getAjaxProxy(cmp);
		proxy.request({
			method: 'GET',
			url: 'callout:GoogleApi/oauth2/v3/userinfo'
		}).then(function(res) {
			console.log(res.statusCode, res.body);
		}).catch(function(err) {
			console.error(err);
		});
	}
})
