Feature: Lokalisierung Equalpower

  @l_equalpower_4
  Scenario: Vier Bots joint
    When I pause
    When I pause
    Given Bot 1 navigiert zur Sitzung "raum211"
    Given Bot 2 navigiert zur Sitzung "raum211"
    Given Bot 3 navigiert zur Sitzung "raum211"
    Given Bot 4 navigiert zur Sitzung "raum211"

    When I pause

    Given Bot 1 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 2 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 3 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 4 klickt auf den Join-Button
    
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



  @l_equalpower_8
  Scenario: Acht Bots joint
    When I pause
    Given Bot 1 navigiert zur Sitzung "raum212"
    Given Bot 2 navigiert zur Sitzung "raum212"
    Given Bot 3 navigiert zur Sitzung "raum212"
    Given Bot 4 navigiert zur Sitzung "raum212"
    Given Bot 5 navigiert zur Sitzung "raum212"
    Given Bot 6 navigiert zur Sitzung "raum212"
    Given Bot 7 navigiert zur Sitzung "raum212"
    Given Bot 8 navigiert zur Sitzung "raum212"

    When I pause

    Given Bot 1 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 2 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 3 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 4 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 5 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 6 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 7 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 8 klickt auf den Join-Button

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



  @l_equalpower_12
  Scenario: Zwölf Bots joint
    When I pause
    Given Bot 1 navigiert zur Sitzung "raum213"
    Given Bot 2 navigiert zur Sitzung "raum213"
    Given Bot 3 navigiert zur Sitzung "raum213"
    Given Bot 4 navigiert zur Sitzung "raum213"
    Given Bot 5 navigiert zur Sitzung "raum213"
    Given Bot 6 navigiert zur Sitzung "raum213"
    Given Bot 7 navigiert zur Sitzung "raum213"
    Given Bot 8 navigiert zur Sitzung "raum213"
    Given Bot 9 navigiert zur Sitzung "raum213"
    Given Bot 10 navigiert zur Sitzung "raum213"
    Given Bot 11 navigiert zur Sitzung "raum213"
    Given Bot 12 navigiert zur Sitzung "raum213"

    When I pause

    Given Bot 1 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 2 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 3 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 4 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 5 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 6 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 7 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 8 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 9 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 10 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 11 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 12 klickt auf den Join-Button

    Given warte 5 Sekunden

    Given Bot 1 Taste M betätigt
    Given warte 1 Sekunden
    Given Bot 2 Taste M betätigt
    Given warte 1 Sekunden
    Given Bot 3 Taste M betätigt
    Given warte 1 Sekunden
    Given Bot 4 Taste M betätigt
    Given warte 1 Sekunden
    Given Bot 5 Taste M betätigt
    Given warte 1 Sekunden
    Given Bot 6 Taste M betätigt
    Given warte 1 Sekunden
    Given Bot 7 Taste M betätigt
    Given warte 1 Sekunden
    Given Bot 8 Taste M betätigt
    Given warte 1 Sekunden
    Given Bot 9 Taste M betätigt
    Given warte 1 Sekunden
    Given Bot 10 Taste M betätigt
    Given warte 1 Sekunden
    Given Bot 11 Taste M betätigt
    Given warte 1 Sekunden
    Given Bot 12 Taste M betätigt

    Given warte 1 Sekunden

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




