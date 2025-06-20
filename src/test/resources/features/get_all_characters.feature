Feature: Get all characters

  Scenario: Get all characters (empty list expected)
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters'
    When method get
    Then status 200
    And match response == []