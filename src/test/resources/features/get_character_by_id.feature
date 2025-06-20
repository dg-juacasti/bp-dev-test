Feature: Get character by ID

  Scenario: Get existing character
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters/1'
    When method get
    Then status 200
    And match response == { id: 1, name: 'Iron Man', alterego: 'Tony Stark', description: 'Genius billionaire', powers: ['Armor', 'Flight'] }

  Scenario: Get non-existing character
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters/999'
    When method get
    Then status 404
    And match response.error == 'Character not found'