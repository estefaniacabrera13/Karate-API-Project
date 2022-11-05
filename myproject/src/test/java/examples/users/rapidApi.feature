@RapidApiRequests
Feature: RapidApi

  Background:
    Given url urlShorten
    And path 'shorten'

  @SuccessfullRequest
  Scenario Outline: Status 200 - Response
    * def body = {"url": "https://crowdar.com.ar"}
    And header x-rapidapi-key = '<key>'
    And request body
    When method POST
    Then status 200
    And  match <response>
    Examples:
      | key                                                | response                         |
      | 5bc1a34c40mshe27d32ebba28f93p1f3a18jsn222d7956a53b | response.result_url == '#string' |

  @ErrorRequest
  Scenario Outline: Status 400 - Empty URL
    And header x-rapidapi-key = '<key>'
    And request {}
    When method POST
    Then status 400
    And  match <response>
    Examples:
      | key                                                | response                                                              |
      | 5bc1a34c40mshe27d32ebba28f93p1f3a18jsn222d7956a53b | response ==  read('classpath:examples/users/response/empty_url.json') |

  @ErrorRequest
  Scenario Outline: Status 400 - Invalid URL
    * def body = {"url": "sdfadfadsfdfsdf"}
    And header x-rapidapi-key = '<key>'
    And request body
    When method POST
    Then status 400
    And  match <response>
    Examples:
      | key                                                | response                                                                |
      | 5bc1a34c40mshe27d32ebba28f93p1f3a18jsn222d7956a53b | response ==  read('classpath:examples/users/response/invalid_url.json') |

  @ErrorRequest
  Scenario Outline: Status 403 - Invalid Token
    * def body = {"url": "https://crowdar.com.ar"}
    And header x-rapidapi-key = '<key>'
    And request body
    When method POST
    Then status 403
    And  match <response>
    Examples:
      | key      | response                                                                  |
      | asdasdas | response ==  read('classpath:examples/users/response/invalid_token.json') |


