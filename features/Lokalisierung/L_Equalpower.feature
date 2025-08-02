Feature: Lokalisierung Equalpower

  @l_equalpower_4
  Scenario: Vier Bots joint
    Given Bot 1 joint der Sitzung "raum4"
    Given Bot 2 joint der Sitzung "raum4"
    Given Bot 3 joint der Sitzung "raum4"
    Given Bot 4 joint der Sitzung "raum4"

    Given warte 5 Sekunden

    Given Bot 1 Taste M betätigt
    Given Bot 2 Taste M betätigt
    Given Bot 3 Taste M betätigt
    Given Bot 4 Taste M betätigt

    When I pause

    ######################################
    # Reihenfolge B, D, A, C → 2, 4, 1, 3

    When Bot 2 Taste M betätigt
    When warte 3 Sekunden
    When Bot 2 Taste M betätigt

    When I pause

    When Bot 4 Taste M betätigt
    When warte 3 Sekunden
    When Bot 4 Taste M betätigt

    When I pause

    When Bot 1 Taste M betätigt
    When warte 3 Sekunden
    When Bot 1 Taste M betätigt

    When I pause

    When Bot 3 Taste M betätigt
    When warte 3 Sekunden
    When Bot 3 Taste M betätigt

    When warte 10 Sekunden





  @l_equalpower_8
  Scenario: Acht Bots joint
    Given Bot 1 joint der Sitzung "raum5"
    Given Bot 2 joint der Sitzung "raum5"
    Given Bot 3 joint der Sitzung "raum5"
    Given Bot 4 joint der Sitzung "raum5"
    Given Bot 5 joint der Sitzung "raum5"
    Given Bot 6 joint der Sitzung "raum5"
    Given Bot 7 joint der Sitzung "raum5"
    Given Bot 8 joint der Sitzung "raum5"

    Given warte 5 Sekunden

    Given Bot 1 Taste M betätigt
    Given Bot 2 Taste M betätigt
    Given Bot 3 Taste M betätigt
    Given Bot 4 Taste M betätigt
    Given Bot 5 Taste M betätigt
    Given Bot 6 Taste M betätigt
    Given Bot 7 Taste M betätigt
    Given Bot 8 Taste M betätigt

    When I pause

    ######################################
    # Reihenfolge G, D, F, A → 7, 4, 6, 1

    When Bot 7 Taste M betätigt
    When warte 3 Sekunden
    When Bot 7 Taste M betätigt

    When I pause

    When Bot 4 Taste M betätigt
    When warte 3 Sekunden
    When Bot 4 Taste M betätigt

    When I pause

    When Bot 6 Taste M betätigt
    When warte 3 Sekunden
    When Bot 6 Taste M betätigt

    When I pause

    When Bot 1 Taste M betätigt
    When warte 3 Sekunden
    When Bot 1 Taste M betätigt

    When warte 10 Sekunden




  @l_equalpower_12
  Scenario: Zwölf Bots joint
    Given Bot 1 joint der Sitzung "raum6"
    Given Bot 2 joint der Sitzung "raum6"
    Given Bot 3 joint der Sitzung "raum6"
    Given Bot 4 joint der Sitzung "raum6"
    Given Bot 5 joint der Sitzung "raum6"
    Given Bot 6 joint der Sitzung "raum6"
    Given Bot 7 joint der Sitzung "raum6"
    Given Bot 8 joint der Sitzung "raum6"
    Given Bot 9 joint der Sitzung "raum6"
    Given Bot 10 joint der Sitzung "raum6"
    Given Bot 11 joint der Sitzung "raum6"
    Given Bot 12 joint der Sitzung "raum6"

    Given warte 5 Sekunden

    Given Bot 1 Taste M betätigt
    Given Bot 2 Taste M betätigt
    Given Bot 3 Taste M betätigt
    Given Bot 4 Taste M betätigt
    Given Bot 5 Taste M betätigt
    Given Bot 6 Taste M betätigt
    Given Bot 7 Taste M betätigt
    Given Bot 8 Taste M betätigt
    Given Bot 9 Taste M betätigt
    Given Bot 10 Taste M betätigt
    Given Bot 11 Taste M betätigt
    Given Bot 12 Taste M betätigt

    When I pause

    ######################################
    # Reihenfolge K, E, B, H → 11, 5, 2, 8

    When Bot 11 Taste M betätigt
    When warte 3 Sekunden
    When Bot 11 Taste M betätigt

    When I pause

    When Bot 5 Taste M betätigt
    When warte 3 Sekunden
    When Bot 5 Taste M betätigt

    When I pause

    When Bot 2 Taste M betätigt
    When warte 3 Sekunden
    When Bot 2 Taste M betätigt

    When I pause

    When Bot 8 Taste M betätigt
    When warte 3 Sekunden
    When Bot 8 Taste M betätigt

    When warte 10 Sekunden




