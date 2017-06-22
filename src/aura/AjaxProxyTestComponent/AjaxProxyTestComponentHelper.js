({
	getAjaxProxy: function(cmp) {
		var request = this.getPromisedAction(cmp, 'request', ['params']);
		return {
			request: function(params) {
				return request(params).then(function(res) {
					var headers = Object.keys(res.headers || {}).reduce(function(hds, key) {
						hds[key.toLowerCase()] = res.headers[key];
						return hds;
					}, {});
					if (/^application\/json($|;)/.test(headers['content-type'])) {
						res.body = JSON.parse(res.body);
					}
					return res;
				});
			}
		};
	},

	getPromisedAction: function(cmp, actionName, paramNames) {
		var _this = this;
		return function() {
			var args = arguments;
			var params = (paramNames || []).reduce(function(prms, name, i) {
				prms[name] = args[i];
				return prms;
			}, {});
			var action = cmp.get('c.' + actionName);
			action.setParams(params);
			return new Promise(function(resolve, reject) {
				action.setCallback(_this, function(response) {
					var state = response.getState();
					if (state === 'SUCCESS') {
						resolve(response.getReturnValue());
					} else {
						var errors = response.getError();
						if (errors && errors.length > 0) {
							reject(errors[0]);
						} else {
							reject(new Error('Unknown Error'));
						}
					}
				});
				$A.enqueueAction(action);
			});
		};
	}
})
