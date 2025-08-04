Feature: Lokalisierung Equalpower

  @l_equalpower_4
  Scenario: Vier Bots joint
    When I pause
    Given Bot 1 navigiert zur Sitzung "kevin3"
    Given Bot 2 navigiert zur Sitzung "kevin3"
    Given Bot 3 navigiert zur Sitzung "kevin3"
    Given Bot 4 navigiert zur Sitzung "kevin3"

    Given ich pausiere mit Text "Bots bereit zum Zutritt"

    Given Bot 1 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 2 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 3 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 4 klickt auf den Join-Button
    
    Given warte 1 Sekunden

    Given Bot 1 toggles audio
    Given Bot 2 toggles audio
    Given Bot 3 toggles audio
    Given Bot 4 toggles audio

    Given Bot 1 toggles video
    Given Bot 2 toggles video
    Given Bot 3 toggles video
    Given Bot 4 toggles video

    Given ich pausiere mit Text "Ton 1"
    ######################################
    # Reihenfolge B, D, A, C → 2, 4, 1, 3

    Given ich pausiere mit Text "Ton 1"

    When Bot 2 toggles audio
    When warte 3 Sekunden
    When Bot 2 toggles audio

    Given ich pausiere mit Text "Ton 2"

    When Bot 4 toggles audio
    When warte 3 Sekunden
    When Bot 4 toggles audio

    Given ich pausiere mit Text "Ton 3"

    When Bot 1 toggles audio
    When warte 3 Sekunden
    When Bot 1 toggles audio

    Given ich pausiere mit Text "Ton 4"

    When Bot 3 toggles audio
    When warte 3 Sekunden
    When Bot 3 toggles audio



  @l_equalpower_8
  Scenario: Acht Bots joint
    When I pause
    Given Bot 1 navigiert zur Sitzung "kevin4"
    Given Bot 2 navigiert zur Sitzung "kevin4"
    Given Bot 3 navigiert zur Sitzung "kevin4"
    Given Bot 4 navigiert zur Sitzung "kevin4"
    Given Bot 5 navigiert zur Sitzung "kevin4"
    Given Bot 6 navigiert zur Sitzung "kevin4"
    Given Bot 7 navigiert zur Sitzung "kevin4"
    Given Bot 8 navigiert zur Sitzung "kevin4"

    Given ich pausiere mit Text "Bots bereit zum Zutritt"

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

    Given Bot 1 toggles audio
    Given Bot 2 toggles audio
    Given Bot 3 toggles audio
    Given Bot 4 toggles audio
    Given Bot 5 toggles audio
    Given Bot 6 toggles audio
    Given Bot 7 toggles audio
    Given Bot 8 toggles audio

    Given Bot 1 toggles video
    Given Bot 2 toggles video
    Given Bot 3 toggles video
    Given Bot 4 toggles video
    Given Bot 5 toggles video
    Given Bot 6 toggles video
    Given Bot 7 toggles video
    Given Bot 8 toggles video

    ######################################
    # Reihenfolge G, D, F, A → 7, 4, 6, 1

    Given ich pausiere mit Text "Ton 1"

    When Bot 7 toggles audio
    When warte 3 Sekunden
    When Bot 7 toggles audio

    Given ich pausiere mit Text "Ton 2"

    When Bot 4 toggles audio
    When warte 3 Sekunden
    When Bot 4 toggles audio

    Given ich pausiere mit Text "Ton 3"

    When Bot 6 toggles audio
    When warte 3 Sekunden
    When Bot 6 toggles audio

    Given ich pausiere mit Text "Ton 4"

    When Bot 1 toggles audio
    When warte 3 Sekunden
    When Bot 1 toggles audio

