@REQ_BPON-123
Feature: Pruebas rest para la API marverl
  Background:
    * url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api'

  @id:1 @ValidarPersonajes
  Scenario: T-API-CA1-Validar personaje con muchos poderes
    Given path '/characters'
    When method Get
    Then status 200
    * def personajes = response
    * match each personajes.id == '#number'
    * match each personajes.name == '#string'
    * match each personajes.alterego == '#string'
    * match personajes[0].id == 4
    * match personajes[0].name == 'Character with many powers'
    * match personajes[0].alterego == 'Many Powers Alter'
    * match personajes[1].id == 8
    * match personajes[1].name == 'DROP TABLE characters; --'
    * match personajes[1].alterego == 'SQL Injection Test'


  @id:2 @ValidarEncontrarPersonajeExitoso
  Scenario Outline: T-API-CA2-Validar encontrar personaje exitoso
    Given path '/characters/<id>'
    When method Get
    Then status 200
    * def personaje = response
    * match personaje.id == <id>
    * match personaje.name == <name>
    * match personaje.alterego == <alterego>
    * match personaje.powers.length == 10
    * match personaje.description == <descripcion>
    Examples:
      | id | name                       | alterego          | descripcion                    |
      | 4  | Character with many powers | Many Powers Alter | "Personaje con muchos poderes" |

  @id:3 @ValidarEncontrarPersonajeNoExitoso
  Scenario Outline: T-API-CA3-Validar no encontrar personaje
    Given path '/characters/<id>'
    When method Get
    Then status 404
    * match response.error == 'Character not found'
    * match response == { error: 'Character not found' }
    * match response.error contains 'not found'
    Examples:
      | id   |
      | 1000 |

  @id:4 @ValidarCrearPersonaje
  Scenario Outline: T-API-CA4-Validar crear personaje exitoso
    Given path '/characters'
    And request { "name": "<name>", "powers": ["<power1>","<power2>"], "description": "<description>" }
    When header Content-Type = 'application/json'
    When method Post
    Then status 201
    * def personaje = response
    * match personaje.name == <name>
    * match personaje.powers1[1] == <power1>
    * match personaje.description == <description>
    Examples:
      | name       | power1 | power2   | description          |
      | Iron Man21 | Armor  | Flight21 | Genius billionaire21 |

  @id:5 @ValidarPersonajeDuplicado
  Scenario Outline: T-API-CA5-Validar personaje duplicado
    Given path '/characters'
    And request { "name": "<name>", "powers": ["<power1>","<power2>"], "description": "<description>" }
    When header Content-Type = 'application/json'
    When method Post
    Then status 400
    * def personaje = response
    * match personaje.error == 'Character name already exists'
    * match personaje == { error: 'Character name already exists' }
    * match personaje.error contains 'already exists'
    Examples:
      | name       | power1 | power2   | description          |
      | Iron Man21 | Armor  | Flight21 | Genius billionaire21 |

  @id:6 @ValidarFaltaCamposPersonaje
  Scenario: T-API-CA6-Validar falta campos personaje
    Given path '/characters'
    And request { "name": "", "powers": [], "description": "" }
    When header Content-Type = 'application/json'
    When method Post
    Then status 400
    * match response.name == 'Name is required'
    * match response.description == 'Description is required'
    * match response.powers == 'Powers are required'
    * match response == { name: 'Name is required', description: 'Description is required', powers: 'Powers are required', alterego: 'Alterego is required' }

  @id:7 @ValidarActualizarPersonaje
  Scenario Outline: T-API-CA7-Validar actualizar personaje exitoso
    Given path '/characters/<id>'
    And request { "name": "<name>", "powers": ["<power1>","<power2>"], "description": "<description>" }
    When header Content-Type = 'application/json'
    When method Put
    Then status 200
    * def personaje = response
    * match personaje.id == <id>
    * match personaje.name == <name>
    * match personaje.powers[1] == <power1>
    * match personaje.description == <description>
    Examples:
      | id   | name       | power1 | power2   | description          |
      | 1379 | Iron Man22 | Armor  | Flight21 | Genius billionaire22 |

  @id:8 @ValidarActualizarPersonajeNoExiste
  Scenario Outline: T-API-CA8-Validar actualizar personaje no existe
    Given path '/characters/<id>'
    And request { "name": "<name>", "powers": ["<power1>","<power2>"], "description": "<description>" }
    When header Content-Type = 'application/json'
    When method Put
    Then status 404
    * match response.error == 'Character not found'
    * match response == { error: 'Character not found' }
    * match response.error contains 'not found'
    Examples:
      | id   | name       | power1 | power2   | description          |
      | 9999 | Iron Man22 | Armor  | Flight21 | Genius billionaire22 |

  @id:9 @ValidarEliminarPersonaje
  Scenario Outline: T-API-CA9-Validar eliminar personaje exitoso
    Given path '/characters/<id>'
    When header Content-Type = 'application/json'
    When method Delete
    Then status 204
    Examples:
      | id   |
      | 1379 |

  @id:10 @ValidarEliminarPersonajeNoExiste
  Scenario Outline: T-API-CA10-Validar eliminar personaje no existe
    Given path '/characters/<id>'
    When header Content-Type = 'application/json'
    When method Delete
    Then status 404
    * match response.error == 'Character not found'
    * match response == { error: 'Character not found' }
    * match response.error contains 'not found'
    Examples:
      | id   |
      | 9999 |



