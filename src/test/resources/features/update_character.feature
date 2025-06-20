Feature: Update character

  Scenario: Update existing character
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters/1'
    And request { name: 'Iron Man', alterego: 'Tony Stark', description: 'Updated description', powers: ['Armor', 'Flight'] }
    And header Content-Type = 'application/json'
    When method put
    Then status 200
    And match response.description == 'Updated description'

  Scenario: Update non-existing character
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters/999'
    And request { name: 'Iron Man', alterego: 'Tony Stark', description: 'Updated description', powers: ['Armor', 'Flight'] }
    And header Content-Type = 'application/json'
    When method put
    Then status 404
    And match response.error == 'Character not found'