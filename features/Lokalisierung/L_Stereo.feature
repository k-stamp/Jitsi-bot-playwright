Feature: Lokalisierung Stereo

@l_stereo_4
  Scenario: Vier Bots joint
    Given Bot 1 joint der Sitzung "raum1"
    Given warte 3 Sekunden
    Given Bot 1 Taste M betätigt

    Given Bot 2 joint der Sitzung "raum1"
    Given warte 3 Sekunden
    Given Bot 2 Taste M betätigt

    Given Bot 3 joint der Sitzung "raum1"
    Given warte 3 Sekunden
    Given Bot 3 Taste M betätigt

    Given Bot 4 joint der Sitzung "raum1"
    Given warte 3 Sekunden
    Given Bot 4 Taste M betätigt

    ######################################
    # Reihenfolge C, A, D, B → 3, 1, 4, 2

    When Bot 3 Taste M betätigt
    When warte 5 Sekunden
    When Bot 3 Taste M betätigt

    When Bot 1 Taste M betätigt
    When warte 5 Sekunden
    When Bot 1 Taste M betätigt

    When Bot 4 Taste M betätigt
    When warte 5 Sekunden
    When Bot 4 Taste M betätigt

    When Bot 2 Taste M betätigt
    When warte 5 Sekunden
    When Bot 2 Taste M betätigt

    When warte 10 Sekunden





@l_stereo_8
  Scenario: Acht Bots joint
    Given Bot 1 joint der Sitzung "raum2"
    Given warte 3 Sekunden
    Given Bot 1 Taste M betätigt

    Given Bot 2 joint der Sitzung "raum2"
    Given warte 3 Sekunden
    Given Bot 2 Taste M betätigt

    Given Bot 3 joint der Sitzung "raum2"
    Given warte 3 Sekunden
    Given Bot 3 Taste M betätigt

    Given Bot 4 joint der Sitzung "raum2"
    Given warte 3 Sekunden
    Given Bot 4 Taste M betätigt

    Given Bot 5 joint der Sitzung "raum2"
    Given warte 3 Sekunden
    Given Bot 5 Taste M betätigt

    Given Bot 6 joint der Sitzung "raum2"
    Given warte 3 Sekunden
    Given Bot 6 Taste M betätigt

    Given Bot 7 joint der Sitzung "raum2"
    Given warte 3 Sekunden
    Given Bot 7 Taste M betätigt

    Given Bot 8 joint der Sitzung "raum2"
    Given warte 3 Sekunden
    Given Bot 8 Taste M betätigt

    ######################################
    # Reihenfolge E, B, H, C → 5, 2, 8, 3

    When Bot 5 Taste M betätigt
    When warte 5 Sekunden
    When Bot 5 Taste M betätigt

    When Bot 2 Taste M betätigt
    When warte 5 Sekunden
    When Bot 2 Taste M betätigt

    When Bot 8 Taste M betätigt
    When warte 5 Sekunden
    When Bot 8 Taste M betätigt

    When Bot 3 Taste M betätigt
    When warte 5 Sekunden
    When Bot 3 Taste M betätigt





@l_stereo_12
    Scenario: Zwölf Bots joint
    Given Bot 1 joint der Sitzung "raum3"
    Given warte 3 Sekunden
    Given Bot 1 Taste M betätigt

    Given Bot 2 joint der Sitzung "raum3"
    Given warte 3 Sekunden
    Given Bot 2 Taste M betätigt

    Given Bot 3 joint der Sitzung "raum3"
    Given warte 3 Sekunden
    Given Bot 3 Taste M betätigt

    Given Bot 4 joint der Sitzung "raum3"
    Given warte 3 Sekunden
    Given Bot 4 Taste M betätigt

    Given Bot 5 joint der Sitzung "raum3"
    Given warte 3 Sekunden
    Given Bot 5 Taste M betätigt

    Given Bot 6 joint der Sitzung "raum3"
    Given warte 3 Sekunden
    Given Bot 6 Taste M betätigt

    Given Bot 7 joint der Sitzung "raum3"
    Given warte 3 Sekunden
    Given Bot 7 Taste M betätigt

    Given Bot 8 joint der Sitzung "raum3"
    Given warte 3 Sekunden
    Given Bot 8 Taste M betätigt

    Given Bot 9 joint der Sitzung "raum3"
    Given warte 3 Sekunden
    Given Bot 9 Taste M betätigt

    Given Bot 10 joint der Sitzung "raum3"
    Given warte 3 Sekunden
    Given Bot 10 Taste M betätigt

    Given Bot 11 joint der Sitzung "raum3"
    Given warte 3 Sekunden
    Given Bot 11 Taste M betätigt

    Given Bot 12 joint der Sitzung "raum3"
    Given warte 3 Sekunden
    Given Bot 12 Taste M betätigt

    ######################################
    # Reihenfolge G, C, J, A → 7, 3, 10, 1

    When Bot 7 Taste M betätigt
    When warte 5 Sekunden
    When Bot 7 Taste M betätigt

    When Bot 3 Taste M betätigt
    When warte 5 Sekunden
    When Bot 3 Taste M betätigt

    When Bot 10 Taste M betätigt
    When warte 5 Sekunden
    When Bot 10 Taste M betätigt

    When Bot 1 Taste M betätigt
    When warte 5 Sekunden
    When Bot 1 Taste M betätigt

