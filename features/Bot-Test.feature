Feature: Jitsi Bot-Tests

  @test1
  Scenario: Ein Bot tritt einer Konferenz bei ohne Audio und Video
    Given Bot 1 joint der Sitzung "h6" ohne Video
    When warte 10 Sekunden
    When Bot 1 Taste M betätigt
    When warte 20 Sekunden

  @test2
  Scenario: Vier Bots tritt einer Konferenz bei ohne Audio und Video
    Given Bot 1 joint der Sitzung "debug6" ohne Video
    Given Bot 3 joint der Sitzung "debug6" ohne Video
    Given Bot 4 joint der Sitzung "debug6" ohne Video
    Given Bot 2 joint der Sitzung "debug6" ohne Video
    When Bot 1 Taste M betätigt
    When Bot 1 Taste M betätigt
    When warte 10 Sekunden


  @test3
  Scenario: Ein Bot tritt einer Konferenz bei
    Given Bot 1 joint der Sitzung "h2" ohne Video
    When warte 5 Sekunden
    When Bot 1 hebt die Stummschaltung auf
    When warte 10 Sekunden
    And Bot 1 schaltet sich stumm
    When warte 20 Sekunden

  @test4
  Scenario: Debug mit Inspector - Bot tritt bei und Inspector öffnet sich
    Given Bot 1 joint der Sitzung "debug5" ohne Video
    When warte 5 Sekunden
    When Ich den Inspector öffne
    When Bot 1 Taste M betätigt
    When Bot 1 Taste M betätigt
    When warte 10 Sekunden

