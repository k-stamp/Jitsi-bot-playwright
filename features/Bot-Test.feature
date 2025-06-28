Feature: Jitsi Bot-Tests

  @test1
  Scenario: Ein Bot tritt einer Konferenz bei
    Given Bot 1 joint der Sitzung "test1" ohne Video
    When warte 5 Sekunden
    When Bot 1 hebt die Stummschaltung auf
    When warte 10 Sekunden
    And Bot 1 schaltet sich stumm
    When warte 20 Sekunden


  @test2
  Scenario: Drei Bots tritt einer Konferenz bei
    Given Bot 1 joint der Sitzung "test1" ohne Video
    Given Bot 2 joint der Sitzung "test1" ohne Video
    Given Bot 3 joint der Sitzung "test1" ohne Video
    When warte 5 Sekunden
    When Bot 1 hebt die Stummschaltung auf
    When warte 10 Sekunden
    And Bot 1 schaltet sich stumm
    When warte 20 Sekunden

