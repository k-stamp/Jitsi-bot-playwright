Feature: Jitsi Bot-Tests

  
  @test-join1
  Scenario: Ein Bot joint
    Given Bot 1 joint der Sitzung "hallo2" ohne Video
    When warte 20 Sekunden

  @test-join4
  Scenario: Vier Bots joint
    Given Bot 1 joint der Sitzung "hallo2" ohne Video
    Given Bot 2 joint der Sitzung "hallo2" ohne Video
    Given Bot 3 joint der Sitzung "hallo2" ohne Video
    Given Bot 4 joint der Sitzung "hallo2" ohne Video
    When warte 20 Sekunden


  @test-join8
  Scenario: Ein Bot joint
    Given Bot 1 joint der Sitzung "hallo5" ohne Video
    Given Bot 2 joint der Sitzung "hallo5" ohne Video
    Given Bot 3 joint der Sitzung "hallo5" ohne Video
    Given Bot 4 joint der Sitzung "hallo5" ohne Video
    Given Bot 5 joint der Sitzung "hallo5" ohne Video
    Given Bot 6 joint der Sitzung "hallo5" ohne Video
    Given Bot 7 joint der Sitzung "hallo5" ohne Video
    Given Bot 8 joint der Sitzung "hallo5" ohne Video
    When warte 20 Sekunden
  
  
  Scenario: Ein Bot tritt einer Konferenz bei ohne Audio und Video
    Given Bot 1 joint der Sitzung "h6" ohne Video
    When warte 10 Sekunden
    When Bot 1 Taste M betätigt
    When warte 20 Sekunden

  
  Scenario: Vier Bots tritt einer Konferenz bei ohne Audio und Video
    Given Bot 1 joint der Sitzung "debug" ohne Video
    Given Bot 3 joint der Sitzung "debug" ohne Video
    Given Bot 4 joint der Sitzung "debug" ohne Video
    Given Bot 2 joint der Sitzung "debug" ohne Video
    When Bot 1 Taste M betätigt
    When Bot 1 Taste M betätigt
    When warte 10 Sekunden


  
  Scenario: Ein Bot tritt einer Konferenz bei
    Given Bot 1 joint der Sitzung "h2" ohne Video
    When warte 5 Sekunden
    When Bot 1 hebt die Stummschaltung auf
    When warte 10 Sekunden
    And Bot 1 schaltet sich stumm
    When warte 20 Sekunden

  
  Scenario: Debug mit Inspector - Bot tritt bei und Inspector öffnet sich
    Given Bot 1 joint der Sitzung "debug5" ohne Video
    When warte 5 Sekunden
    When Ich den Inspector öffne
    When Bot 1 Taste M betätigt
    When Bot 1 Taste M betätigt
    When warte 10 Sekunden

