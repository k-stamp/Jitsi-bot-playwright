Feature: Lasttest

  @Lasttest-1
  Scenario: Ein Bot joint
    Given Bot 1 joint der Sitzung "test1" ohne Video
    When warte 5 Sekunden
    When ich den Text "Mein Logtext START" mit Timestamp logge
    When warte 5 Sekunden
    When ich den Text "Mein Logtext ENDE" mit Timestamp logge


  @Lasttest-4
  Scenario: Vier Bots joint
    Given Bot 1 joint der Sitzung "test1" ohne Video
    Given Bot 2 joint der Sitzung "test1" ohne Video
    Given Bot 3 joint der Sitzung "test1" ohne Video
    Given Bot 4 joint der Sitzung "test1" ohne Video
    When warte 60 Sekunden