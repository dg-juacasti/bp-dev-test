Feature: Create character

  Scenario: Create character successfully
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters'
    And request { name: 'Iron Man', alterego: 'Tony Stark', description: 'Genius billionaire', powers: ['Armor', 'Flight'] }
    And header Content-Type = 'application/json'
    When method post
    Then status 201
    And match response contains { name: 'Iron Man', alterego: 'Tony Stark' }

  Scenario: Create character with duplicate name
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters'
    And request { name: 'Iron Man', alterego: 'Otro', description: 'Otro', powers: ['Armor'] }
    And header Content-Type = 'application/json'
    When method post
    Then status 400
    And match response.error == 'Character name already exists'

  Scenario: Create character with missing required fields
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters'
    And request { name: '', alterego: '', description: '', powers: [] }
    And header Content-Type = 'application/json'
    When method post
    Then status 400
    And match response == { name: 'Name is required', alterego: 'Alterego is required', description: 'Description is required', powers: 'Powers are required' }