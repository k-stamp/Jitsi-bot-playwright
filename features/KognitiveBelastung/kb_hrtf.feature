Feature: Fokussierung HRTF

  @kb_hrtf
  Scenario: Acht Bots kognitive Belastung HRTF Audio
    Given Bot 1401 navigiert zur Sitzung "kevin15"
    Given Bot 1402 navigiert zur Sitzung "kevin15"
    Given Bot 1403 navigiert zur Sitzung "kevin15"
    Given Bot 1404 navigiert zur Sitzung "kevin15"
    Given Bot 1405 navigiert zur Sitzung "kevin15"
    Given Bot 1406 navigiert zur Sitzung "kevin15"
    Given Bot 1407 navigiert zur Sitzung "kevin15"
    Given Bot 1408 navigiert zur Sitzung "kevin15"

    When ich pausiere mit Text "Sitzungen geladen, bereit für Beitritt"

    Given Bot 1401 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 1402 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 1403 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 1404 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 1405 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 1406 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 1407 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 1408 klickt auf den Join-Button

    Given warte 1 Sekunden

    Given Bot 1401 toggles video
    Given Bot 1402 toggles video
    Given Bot 1403 toggles video
    Given Bot 1404 toggles video
    Given Bot 1405 toggles video
    Given Bot 1406 toggles video
    Given Bot 1407 toggles video
    Given Bot 1408 toggles video

    Given Bot 1401 toggles audio
    Given Bot 1402 toggles audio
    Given Bot 1403 toggles audio
    Given Bot 1404 toggles audio
    Given Bot 1405 toggles audio
    Given Bot 1406 toggles audio
    Given Bot 1407 toggles audio
    Given Bot 1408 toggles audio

    ######################################

    When ich pausiere mit Text "Trial 13 - Ziel: VW"
    When Bot 1401 toggles audio
    When Bot 1403 toggles audio
    When warte 25 Sekunden
    When Bot 1401 toggles audio
    When Bot 1403 toggles audio

    When ich pausiere mit Text "Trial 14 - Ziel: Ford"
    When Bot 1403 toggles audio
    When Bot 1405 toggles audio
    When warte 25 Sekunden
    When Bot 1403 toggles audio
    When Bot 1405 toggles audio

    When ich pausiere mit Text "Trial 15 - Ziel: Opel"
    When Bot 1402 toggles audio
    When Bot 1408 toggles audio
    When warte 25 Sekunden
    When Bot 1402 toggles audio
    When Bot 1408 toggles audio

    When ich pausiere mit Text "Trial 16 - Ziel: Tesla"
    When Bot 1404 toggles audio
    When Bot 1406 toggles audio
    When warte 25 Sekunden
    When Bot 1404 toggles audio
    When Bot 1406 toggles audio