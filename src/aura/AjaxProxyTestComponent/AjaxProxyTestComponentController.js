({
	init: function(cmp, event, helper) {
		var proxy = helper.getAjaxProxy(cmp);
		// It is required to define GoogleApi named credential
		// to connect google api (https://www.googleapis.com/)
		proxy.request({
			method: 'GET',
			url: 'callout:GoogleApi/oauth2/v3/userinfo'
		}).then(function(res) {
			console.log(res.statusCode, res.body);
			cmp.set('v.email', res.body.email);
		}).catch(function(err) {
			console.error(err);
		});
	}
})
