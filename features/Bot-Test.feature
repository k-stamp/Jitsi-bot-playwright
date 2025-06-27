Feature: Jitsi Bot-Tests

  @test1
  Scenario: Ein Bot tritt einer Konferenz bei
    Given ein Bot mit dem Namen "Bot1" wird gestartet
    When der Bot der Konferenz "test1" beitritt 