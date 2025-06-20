Feature: Delete character

  Scenario: Delete existing character
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters/1'
    When method delete
    Then status 204

  Scenario: Delete non-existing character
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters/999'
    When method delete
    Then status 404
    And match response.error == 'Character not found'