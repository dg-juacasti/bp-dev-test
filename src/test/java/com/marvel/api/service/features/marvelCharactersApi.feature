Feature:  Escenarios de API para gestión de personajes Marvel (microservicio para personajes)

  Background:
    Given url "http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/"

# Escenario 1: Obtener todos los personajes (200)
  @id:1 @obtenerPersonajes @exito200
  Scenario: Obtener todos los personajes exitosamente 200
    Given path 'characters'
    When method GET
    Then status 200


  # Escenario 2: Obtener personaje por ID (200)
  @id:2 @obtenerPersonajePorId @exito200
  Scenario: Obtener personaje por ID exitosamente 200
    Given path 'characters',2533
    When method GET
    Then status 200



  # Escenario 3: Obtener personaje por ID (404)
  @id:3 @obtenerPersonajePorId @error404
  Scenario: T-API-HU-RET-444-CA03-Obtener personaje por ID no existente 404 - karate
    Given path 'characters',999
    When method GET
    Then status 404


    # Escenario 4: Crear personaje exitosamente (201)
  @id:4 @crearPersonaje @exito201

  Scenario: Crear personaje exitosamente 201
    * def body_crear_usuario = read('classpath:data/request/body_create_personaje.json')
    Given path 'characters'
    And request body_crear_usuario
    When method POST
    Then status 201

  @id:5 @crearPersonaje @error400
  Scenario: Crear personaje con nombre duplicado 400
    * def crear_personaje_duplicado = read('classpath:data/request/body_crear_persona_duplicado.json')
    Given path 'characters'
    And request crear_personaje_duplicado
    When method POST
    Then status 400


    # Escenario 6: Crear personaje con campos requeridos faltantes (400)
  @id:6 @crearPersonaje @error400
  Scenario: Crear personaje con campos requeridos faltantes 400
    * def crear_personajes_faltan_campos = read('classpath:data/request/body_crear_personaje_faltan_campos.json')
    Given path 'characters'
    And request crear_personajes_faltan_campos
    When method POST
    Then status 400


# Escenario 7: Actualizar personaje exitosamente (200)
  @id:7 @actualizarPersonaje @exito200
  Scenario: Actualizar personaje exitosamente 200
    * def actualizar_personaje = read('classpath:data/request/body_actualizar_personaje.json')
    Given path 'characters',2533
    And request actualizar_personaje
    When method PUT
    Then status 200


# Escenario 8: Actualizar personaje no existente (404)
  @id:8 @actualizarPersonaje @error404
  Scenario: Actualizar personaje no existente 404
    * def actualizar_personaje_no_existente = read('classpath:data/request/body_actualizar_personaje_no_existente.json')
    Given path 'characters',999
    And request actualizar_personaje_no_existente
    When method PUT
    Then status 404


# Escenario 9: Eliminar personaje exitosamente (204)
  @id:9 @eliminarPersonaje @exito204
  Scenario: Eliminar personaje exitosamente 204
    Given path 'characters',2533
    When method DELETE
    Then status 204


# Escenario 10: Eliminar personaje no existente (404)
  @id:10 @eliminarPersonaje @error404
  Scenario: Eliminar personaje no existente 404 - karate
    Given path 'characters',999
    When method DELETE
    Then status 404
