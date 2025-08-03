Feature: Lokalisierung HRTF

  @l_hrtf_4
  Scenario: Vier Bots joint
    When I pause
    Given Bot 1 joint der Sitzung "raum700"
    Given Bot 2 joint der Sitzung "raum700"
    Given Bot 3 joint der Sitzung "raum700"
    Given Bot 4 joint der Sitzung "raum700"

    Given warte 5 Sekunden

    Given Bot 1 Taste M betätigt
    Given Bot 2 Taste M betätigt
    Given Bot 3 Taste M betätigt
    Given Bot 4 Taste M betätigt

    When I pause

    ######################################
    # Reihenfolge D, C, B, A → 4, 3, 2, 1

    When Bot 4 Taste M betätigt
    When warte 3 Sekunden
    When Bot 4 Taste M betätigt

    When I pause

    When Bot 3 Taste M betätigt
    When warte 3 Sekunden
    When Bot 3 Taste M betätigt

    When I pause

    When Bot 2 Taste M betätigt
    When warte 3 Sekunden
    When Bot 2 Taste M betätigt

    When I pause

    When Bot 1 Taste M betätigt
    When warte 3 Sekunden
    When Bot 1 Taste M betätigt



  @l_hrtf_8
  Scenario: Acht Bots joint
    When I pause
    Given Bot 1 joint der Sitzung "raum8"
    Given Bot 2 joint der Sitzung "raum8"
    Given Bot 3 joint der Sitzung "raum8"
    Given Bot 4 joint der Sitzung "raum8"
    Given Bot 5 joint der Sitzung "raum8"
    Given Bot 6 joint der Sitzung "raum8"
    Given Bot 7 joint der Sitzung "raum8"
    Given Bot 8 joint der Sitzung "raum8"

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
    # Reihenfolge H, E, A, G → 8, 5, 1, 7

    When Bot 8 Taste M betätigt
    When warte 3 Sekunden
    When Bot 8 Taste M betätigt

    When I pause

    When Bot 5 Taste M betätigt
    When warte 3 Sekunden
    When Bot 5 Taste M betätigt

    When I pause

    When Bot 1 Taste M betätigt
    When warte 3 Sekunden
    When Bot 1 Taste M betätigt

    When I pause

    When Bot 7 Taste M betätigt
    When warte 3 Sekunden
    When Bot 7 Taste M betätigt



  @l_hrtf_12
  Scenario: Zwölf Bots joint
    When I pause
    Given Bot 1 joint der Sitzung "raum9"
    Given Bot 2 joint der Sitzung "raum9"
    Given Bot 3 joint der Sitzung "raum9"
    Given Bot 4 joint der Sitzung "raum9"
    Given Bot 5 joint der Sitzung "raum9"
    Given Bot 6 joint der Sitzung "raum9"
    Given Bot 7 joint der Sitzung "raum9"
    Given Bot 8 joint der Sitzung "raum9"
    Given Bot 9 joint der Sitzung "raum9"
    Given Bot 10 joint der Sitzung "raum9"
    Given Bot 11 joint der Sitzung "raum9"
    Given Bot 12 joint der Sitzung "raum9"

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
    # Reihenfolge F, D, L, I → 6, 4, 12, 9

    When Bot 6 Taste M betätigt
    When warte 3 Sekunden
    When Bot 6 Taste M betätigt

    When I pause

    When Bot 4 Taste M betätigt
    When warte 3 Sekunden
    When Bot 4 Taste M betätigt

    When I pause

    When Bot 12 Taste M betätigt
    When warte 3 Sekunden
    When Bot 12 Taste M betätigt

    When I pause

    When Bot 9 Taste M betätigt
    When warte 3 Sekunden
    When Bot 9 Taste M betätigt
