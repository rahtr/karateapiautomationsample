Feature: Get all Job Titles for the specified tenant (tenantId:guid)

  Background:
   # * url BaseUrl
    * def port = karate.env == 'mock' ? karate.start('job-titles-mock.feature').port : 8080
    * url 'http://localhost:' + port
    * header Accept = 'application/json'
    * header Ocp-Apim-Subscription-Key = 'CorrectAPIKey'

  Scenario Outline: Get all Job Titles for the specified tenant (tenantId:guid)
    Given path 'v1/tenants/f06693bc-f5a5-47e6-b409-6dc545a122d7/jobtitles'
    And param page = page
    And param pageSize = pageSize
    And param includeInactive = includeInactive
    And param sortProperty = sortProperty
    And param sortDirection = sortDirection
    And param includeTotalRecordCount = includeTotalRecordCount
    When method get
    Then status 200

   Examples:
      |page |pageSize |includeInactive |sortProperty |sortDirection |includeTotalRecordCount |searchFor |
      |1    |2        |true            |dateCreated  |descending    |true                    |11        |
      |1    |2        |false           |dateModified |ascending     |false                   |11        |

  Scenario: Verify response when incorrect Subscription Key is passed in the request
    Given path 'v1/tenants/f06693bc-f5a5-47e6-b409-6dc545a122d7/jobtitles'
    * header Ocp-Apim-Subscription-Key = 'InCorrectAPIKey'
    When method get
    Then status 401

  Scenario: Verify response when Subscription Key with insufficient permission for the tenantID is passed in the request
    Given path 'v1/tenants/f06693bc-f5a5-47e6-b409-6dc545a122d7/jobtitles'
    * header Ocp-Apim-Subscription-Key = 'APIKeyInsuffientPermission'
    When method get
    Then status 403

  Scenario: Verify response when incorrect tenantID is passed in the request
    And path 'v1/tenants/incorrectID/jobtitles'
    When method get
    Then status 404
