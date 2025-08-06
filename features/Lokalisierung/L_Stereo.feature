Feature: Lokalisierung Stereo

  @l_stereo_4
  Scenario: Vier Bots joint
    Given Bot 1 navigiert zur Sitzung ""
    Given Bot 2 navigiert zur Sitzung ""
    Given Bot 3 navigiert zur Sitzung ""
    Given Bot 4 navigiert zur Sitzung ""

    Given ich pausiere mit Text "Bots bereit zum Zutritt"

    Given Bot 1 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 2 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 3 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 4 klickt auf den Join-Button

    Given warte 1 Sekunden

    Given Bot 1 toggles video
    Given Bot 2 toggles video
    Given Bot 3 toggles video
    Given Bot 4 toggles video

    Given Bot 1 toggles audio
    Given Bot 2 toggles audio
    Given Bot 3 toggles audio
    Given Bot 4 toggles audio

    ######################################
    # Reihenfolge C, A, D, B → 3, 1, 4, 2

    Given ich pausiere mit Text "Ton 1"
    When Bot 3 toggles audio
    When warte 3 Sekunden
    When Bot 3 toggles audio

    Given ich pausiere mit Text "Ton 2"

    When Bot 1 toggles audio
    When warte 3 Sekunden
    When Bot 1 toggles audio

    Given ich pausiere mit Text "Ton 3"

    When Bot 4 toggles audio
    When warte 3 Sekunden
    When Bot 4 toggles audio

    Given ich pausiere mit Text "Ton 4"

    When Bot 2 toggles audio
    When warte 3 Sekunden
    When Bot 2 toggles audio

    When warte 10 Sekunden





  @l_stereo_8
  Scenario: Acht Bots joint
    Given Bot 1 navigiert zur Sitzung "rebecca1"
    Given Bot 2 navigiert zur Sitzung "rebecca1"
    Given Bot 3 navigiert zur Sitzung "rebecca1"
    Given Bot 4 navigiert zur Sitzung "rebecca1"
    Given Bot 5 navigiert zur Sitzung "rebecca1"
    Given Bot 6 navigiert zur Sitzung "rebecca1"
    Given Bot 7 navigiert zur Sitzung "rebecca1"
    Given Bot 8 navigiert zur Sitzung "rebecca1"

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

    Given Bot 1 toggles video
    Given Bot 2 toggles video
    Given Bot 3 toggles video
    Given Bot 4 toggles video
    Given Bot 5 toggles video
    Given Bot 6 toggles video
    Given Bot 7 toggles video
    Given Bot 8 toggles video

    Given Bot 1 toggles audio
    Given Bot 2 toggles audio
    Given Bot 3 toggles audio
    Given Bot 4 toggles audio
    Given Bot 5 toggles audio
    Given Bot 6 toggles audio
    Given Bot 7 toggles audio
    Given Bot 8 toggles audio

    ######################################
    # Reihenfolge E, B, H, C → 5, 2, 8, 3
    Given ich pausiere mit Text "Ton 1"

    When Bot 5 toggles audio
    When warte 3 Sekunden
    When Bot 5 toggles audio

    Given ich pausiere mit Text "Ton 2"

    When Bot 2 toggles audio
    When warte 3 Sekunden
    When Bot 2 toggles audio

    Given ich pausiere mit Text "Ton 3"

    When Bot 8 toggles audio
    When warte 3 Sekunden
    When Bot 8 toggles audio

    Given ich pausiere mit Text "Ton 4"

    When Bot 3 toggles audio
    When warte 3 Sekunden
    When Bot 3 toggles audio

