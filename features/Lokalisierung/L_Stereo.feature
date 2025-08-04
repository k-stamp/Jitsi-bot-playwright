Feature: Lokalisierung Stereo

  @l_stereo_4
  Scenario: Vier Bots joint
    When I pause
    Given Bot 1 navigiert zur Sitzung "kevin1"
    Given Bot 2 navigiert zur Sitzung "kevin1"
    Given Bot 3 navigiert zur Sitzung "kevin1"
    Given Bot 4 navigiert zur Sitzung "kevin1"

    When I pause

    Given Bot 1 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 2 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 3 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 4 klickt auf den Join-Button

    Given warte 5 Sekunden

    Given Bot 1 toggles video
    Given Bot 2 toggles video
    Given Bot 3 toggles video
    Given Bot 4 toggles video

    Given Bot 1 toggles audio
    Given Bot 2 toggles audio
    Given Bot 3 toggles audio
    Given Bot 4 toggles audio

    When I pause
    ######################################
    # Reihenfolge C, A, D, B → 3, 1, 4, 2

    When Bot 3 toggles audio
    When warte 3 Sekunden
    When Bot 3 toggles audio

    When I pause

    When Bot 1 toggles audio
    When warte 3 Sekunden
    When Bot 1 toggles audio

    When I pause

    When Bot 4 toggles audio
    When warte 3 Sekunden
    When Bot 4 toggles audio

    When I pause

    When Bot 2 toggles audio
    When warte 3 Sekunden
    When Bot 2 toggles audio

    When warte 10 Sekunden





  @l_stereo_8
  Scenario: Acht Bots joint
    When I pause
    Given Bot 1 navigiert zur Sitzung "raum112"
    Given Bot 2 navigiert zur Sitzung "raum112"
    Given Bot 3 navigiert zur Sitzung "raum112"
    Given Bot 4 navigiert zur Sitzung "raum112"
    Given Bot 5 navigiert zur Sitzung "raum112"
    Given Bot 6 navigiert zur Sitzung "raum112"
    Given Bot 7 navigiert zur Sitzung "raum112"
    Given Bot 8 navigiert zur Sitzung "raum112"

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
    # Reihenfolge E, B, H, C → 5, 2, 8, 3

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

    When I pause

    When Bot 3 Taste M betätigt
    When warte 3 Sekunden
    When Bot 3 Taste M betätigt

