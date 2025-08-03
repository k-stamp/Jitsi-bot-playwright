Feature: Lokalisierung HRTF

  @l_hrtf_4
  Scenario: Vier Bots joint
    When I pause
    Given Bot 1 navigiert zur Sitzung "raum311"
    Given Bot 2 navigiert zur Sitzung "raum311"
    Given Bot 3 navigiert zur Sitzung "raum311"
    Given Bot 4 navigiert zur Sitzung "raum311"

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
    Given Bot 1 navigiert zur Sitzung "raum312"
    Given Bot 2 navigiert zur Sitzung "raum312"
    Given Bot 3 navigiert zur Sitzung "raum312"
    Given Bot 4 navigiert zur Sitzung "raum312"
    Given Bot 5 navigiert zur Sitzung "raum312"
    Given Bot 6 navigiert zur Sitzung "raum312"
    Given Bot 7 navigiert zur Sitzung "raum312"
    Given Bot 8 navigiert zur Sitzung "raum312"

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

