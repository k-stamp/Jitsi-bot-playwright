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
    Given Bot 1 joint der Sitzung "debug1" ohne Video
    Given Bot 2 joint der Sitzung "debug1" ohne Video
    Given Bot 3 joint der Sitzung "debug1" ohne Video
    Given Bot 4 joint der Sitzung "debug1" ohne Video
    Given Bot 5 joint der Sitzung "debug1" ohne Video
    Given Bot 6 joint der Sitzung "debug1" ohne Video
    Given Bot 7 joint der Sitzung "debug1" ohne Video
    Given Bot 8 joint der Sitzung "debug1" ohne Video
    When warte 20 Sekunden
  
  @test-audio1
  Scenario: Ein Bot mit Testaudio
    Given Bot 1 joint der Sitzung "debug1" ohne Video
    When Bot 1 Taste M betätigt
    When warte 20 Sekunden

  @test-audio4
  Scenario: 4er Lokalisation
    Given Bot 1 joint der Sitzung "debug2" ohne Video
    Given Bot 2 joint der Sitzung "debug2" ohne Video
    Given Bot 3 joint der Sitzung "debug2" ohne Video
    Given Bot 4 joint der Sitzung "debug2" ohne Video
    When Bot 1 Taste M betätigt
    When Bot 1 Taste M betätigt
    When Bot 2 Taste M betätigt
    When Bot 2 Taste M betätigt
    When Bot 3 Taste M betätigt
    When Bot 3 Taste M betätigt
    When Bot 4 Taste M betätigt
    When Bot 4 Taste M betätigt
    When Bot 3 Taste M betätigt
    When Bot 3 Taste M betätigt
    When Bot 2 Taste M betätigt
    When Bot 2 Taste M betätigt
    When Bot 1 Taste M betätigt
    When Bot 1 Taste M betätigt
    When warte 10 Sekunden


  @test-audio8
  Scenario: 8er Lokalisation
    Given Bot 1 joint der Sitzung "debug10" ohne Video
    Given Bot 2 joint der Sitzung "debug10" ohne Video
    Given Bot 3 joint der Sitzung "debug10" ohne Video
    Given Bot 4 joint der Sitzung "debug10" ohne Video
    Given Bot 5 joint der Sitzung "debug10" ohne Video
    Given Bot 6 joint der Sitzung "debug10" ohne Video
    Given Bot 7 joint der Sitzung "debug10" ohne Video
    Given Bot 8 joint der Sitzung "debug10" ohne Video
    When Bot 1 Taste M betätigt
    When Bot 1 Taste M betätigt
    When Bot 2 Taste M betätigt
    When Bot 2 Taste M betätigt
    When Bot 3 Taste M betätigt
    When Bot 3 Taste M betätigt
    When Bot 4 Taste M betätigt
    When Bot 4 Taste M betätigt
    When Bot 5 Taste M betätigt
    When Bot 5 Taste M betätigt
    When Bot 6 Taste M betätigt
    When Bot 6 Taste M betätigt
    When Bot 7 Taste M betätigt
    When Bot 7 Taste M betätigt
    When Bot 8 Taste M betätigt
    When Bot 8 Taste M betätigt
    When Bot 7 Taste M betätigt
    When Bot 7 Taste M betätigt
    When Bot 6 Taste M betätigt
    When Bot 6 Taste M betätigt
    When Bot 5 Taste M betätigt
    When Bot 5 Taste M betätigt
    When Bot 4 Taste M betätigt
    When Bot 4 Taste M betätigt
    When Bot 3 Taste M betätigt
    When Bot 3 Taste M betätigt
    When Bot 2 Taste M betätigt
    When Bot 2 Taste M betätigt
    When Bot 1 Taste M betätigt
    When Bot 1 Taste M betätigt
    When warte 10 Sekunden


  @test-cp-4
  Scenario: 4er Cocktailparty
    Given Bot 1 joint der Sitzung "debug11" ohne Video
    Given Bot 2 joint der Sitzung "debug11" ohne Video
    Given Bot 3 joint der Sitzung "debug11" ohne Video
    Given Bot 4 joint der Sitzung "debug11" ohne Video
    When Bot 1 Taste M betätigt
    When Bot 3 Taste M betätigt
    When warte 20 Sekunden

  
  @test-cp-8
  Scenario: 8er Cocktailparty
    Given Bot 1 joint der Sitzung "debug12" ohne Video
    Given Bot 2 joint der Sitzung "debug12" ohne Video
    Given Bot 3 joint der Sitzung "debug12" ohne Video
    Given Bot 4 joint der Sitzung "debug12" ohne Video
    Given Bot 5 joint der Sitzung "debug12" ohne Video
    Given Bot 6 joint der Sitzung "debug12" ohne Video
    Given Bot 7 joint der Sitzung "debug12" ohne Video
    Given Bot 8 joint der Sitzung "debug12" ohne Video
    When Bot 1 Taste M betätigt
    When Bot 8 Taste M betätigt
    When warte 20 Sekunden
