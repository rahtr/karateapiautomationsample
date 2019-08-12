Feature: stateful mock server

  Background:
    * configure cors = true
    * def tenantId = function(){ return java.util.UUID.randomUUID() + '' }
    #* def jobtitles = {}

  Scenario: pathMatches('/v1/tenants/f06693bc-f5a5-47e6-b409-6dc545a122d7/jobtitles') && methodIs('get') && requestHeaders['Ocp-Apim-Subscription-Key'][0] == 'CorrectAPIKey'
    * def response =
    """
   {
  "pageSize": 100,
  "page": 1,
  "hasMoreResults": false,
  "results": \[{"title": "Test", "isSelectable": true, "xref": {"companyId": 882017, "jobTitleUid": "870da7df-ca60-4767-aab0-e3379f5001fc"},
      "isActive": true,
      "meta": {
        "dateCreated": "2019-01-07T20:56:11.1003281+00:00",
        "dateModified": "2019-01-07T20:56:11.1003281+00:00",
        "revision": 1,
        "dateModifiedSystemOfRecord": "2016-01-06T22:15:45.13+00:00"
      },
      "tenantId": "f06693bc-f5a5-47e6-b409-6dc545a122d7",
      "id": "a61e9539-0587-4261-b769-c5e292b9b0f6"
    }
  \]
}
"""

#  Scenario: pathMatches('/v1/tenants/{tid}/jobtitles')
#    * def response = jobtitles.*
#
#  Scenario: pathMatches('/jobtitles/{id}')
#    * def response = jobtitles[pathParams.id]
#
#  Scenario: pathMatches('/hardcoded')
#    * def response = { hello: 'world' }

  Scenario: pathMatches('/v1/tenants/f06693bc-f5a5-47e6-b409-6dc545a122d7/jobtitles') && methodIs('get') && requestHeaders['Ocp-Apim-Subscription-Key'][0] == 'InCorrectAPIKey'
    * def responseStatus = 401
    * def responseHeaders = { 'Content-Type': 'application/json' }
    * json response = { message: 'Access denied due to invalid subscription key. Make sure to provide a valid key for an active subscription.'}

  Scenario: pathMatches('/v1/tenants/f06693bc-f5a5-47e6-b409-6dc545a122d7/jobtitles') && methodIs('get') && requestHeaders['Ocp-Apim-Subscription-Key'][0] == 'APIKeyInsuffientPermission'
    * def responseStatus = 403
    * def responseHeaders = { 'Content-Type': 'application/json' }
    * json response = { message: 'Access denied due to invalid subscription key. Make sure to provide a valid key for an active subscription.'}

  Scenario:
    # catch-all
    * def responseStatus = 404
    * def responseHeaders = { 'Content-Type': 'text/html; charset=utf-8' }
    * def response = <html><body>Not Found</body></html>
