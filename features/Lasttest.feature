Feature: Lasttest

  @Lasttest1
  Scenario: Ein Bot joint
    When warte 10 Sekunden
    Given Bot 1 joint der Sitzung "Last-1"
    When warte 10 Sekunden
    Then ich den Text "Mein Logtext START" mit Timestamp logge
    When warte 60 Sekunden
    Then ich den Text "Mein Logtext ENDE" mit Timestamp logge

  @Lasttest2
  Scenario: Zwei Bots joint
    When warte 10 Sekunden
    Given Bot 1 joint der Sitzung "Last-2"
    Given Bot 2 joint der Sitzung "Last-2"
    When warte 10 Sekunden
    Then ich den Text "Mein Logtext START" mit Timestamp logge
    When warte 60 Sekunden
    Then ich den Text "Mein Logtext ENDE" mit Timestamp logge

  @Lasttest3
  Scenario: Drei Bots joint
    When warte 10 Sekunden
    Given Bot 1 joint der Sitzung "Last-3"
    Given Bot 2 joint der Sitzung "Last-3"
    Given Bot 3 joint der Sitzung "Last-3"
    When warte 10 Sekunden
    Then ich den Text "Mein Logtext START" mit Timestamp logge
    When warte 60 Sekunden
    Then ich den Text "Mein Logtext ENDE" mit Timestamp logge

  @Lasttest4
  Scenario: Vier Bots joint
    When warte 10 Sekunden
    Given Bot 1 joint der Sitzung "Last-4x"
    Given Bot 2 joint der Sitzung "Last-4x"
    Given Bot 3 joint der Sitzung "Last-4x"
    Given Bot 4 joint der Sitzung "Last-4x"
    When warte 10 Sekunden
    Then ich den Text "Lasttest-4 START" mit Timestamp logge
    When warte 60 Sekunden
    Then ich den Text "Lasttest-4 ENDE" mit Timestamp logge

  @Lasttest8
  Scenario: Acht Bots joint
    When warte 10 Sekunden
    Given Bot 1 joint der Sitzung "Last-8y"
    Given Bot 2 joint der Sitzung "Last-8y"
    Given Bot 3 joint der Sitzung "Last-8y"
    Given Bot 4 joint der Sitzung "Last-8y"
    Given Bot 5 joint der Sitzung "Last-8y"
    Given Bot 6 joint der Sitzung "Last-8y"
    Given Bot 7 joint der Sitzung "Last-8y"
    Given Bot 8 joint der Sitzung "Last-8y"
    When warte 10 Sekunden
    Then ich den Text "Lasttest-4 START" mit Timestamp logge
    When warte 60 Sekunden
    Then ich den Text "Lasttest-4 ENDE" mit Timestamp logge

  @Lasttest12
  Scenario: Zwölf Bots joint
    When warte 10 Sekunden
    Given Bot 1 joint der Sitzung "Last-12"
    Given Bot 2 joint der Sitzung "Last-12"
    Given Bot 3 joint der Sitzung "Last-12"
    Given Bot 4 joint der Sitzung "Last-12"
    Given Bot 5 joint der Sitzung "Last-12"
    Given Bot 6 joint der Sitzung "Last-12"
    Given Bot 7 joint der Sitzung "Last-12"
    Given Bot 8 joint der Sitzung "Last-12"
    Given Bot 9 joint der Sitzung "Last-12"
    Given Bot 10 joint der Sitzung "Last-12"
    Given Bot 11 joint der Sitzung "Last-12"
    Given Bot 12 joint der Sitzung "Last-12"
    When warte 10 Sekunden
    Then ich den Text "Lasttest-4 START" mit Timestamp logge
    When warte 60 Sekunden
    Then ich den Text "Lasttest-4 ENDE" mit Timestamp logge
