# Ajax Proxy in Apex (Named Credential / Lightning Ready)

An Ajax proxy implementation in Apex, which supports not only usual HTTP callout but also Named Credential callout.

## Background

[Ajax Proxy](https://developer.salesforce.com/index.php?title=Ajax_Proxy&oldid=31033) is a built-in feature of Salesforce to call out from front end JavaScript to external web resources, supplied with Ajax Toolkit function of `remoteFunction`. The proxy is possible to callout to any remote sites which are already registered in the organization, but not possible to callout with the named credential. Additionally the feature is only available in Visualforce page and cannot be invoked from Lightning Components.

This program is an implementation of alternative Ajax proxy written in Apex code. As it is written in Apex any lightning component can use this proxy using `@AuraEnabled` annotation in controller. In visualforce page the `@RemoteAction` annotation enables you to invoke via JavaScript remoting.

It also includes examples of Visualforce page / Lightning Component bundle to use this proxy to call out to external API resources.

## Setup

If you want to run the examples included, you need to create appropriate named credential entry and set its name to `GoogleApi`.

```
Name: GoogleApi
URL: https://www.googleapis.com/
Identity Type: Named Principal
Authentication Protocol: OAuth 2.0
Authentication Provider: Google (<< you need to setup Auth Provider of Google first)
Scope: openid profile email
```

You also need to create Authentication Provider of Google, which authorize access to Google APIs.
