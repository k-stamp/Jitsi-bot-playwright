Feature: Fokussierung HRTF

  @kb_hrtf
  Scenario: Acht Bots kognitive Belastung HRTF Audio
    When ich pausiere mit Text "Bot-Browser bereit"
    Given Bot 1401 navigiert zur Sitzung "kb104"
    Given Bot 1402 navigiert zur Sitzung "kb104"
    Given Bot 1403 navigiert zur Sitzung "kb104"
    Given Bot 1404 navigiert zur Sitzung "kb104"
    Given Bot 1405 navigiert zur Sitzung "kb104"
    Given Bot 1406 navigiert zur Sitzung "kb104"
    Given Bot 1407 navigiert zur Sitzung "kb104"
    Given Bot 1408 navigiert zur Sitzung "kb104"

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

    Given warte 5 Sekunden

    Given Bot 1401 Taste M betätigt
    Given Bot 1402 Taste M betätigt
    Given Bot 1403 Taste M betätigt
    Given Bot 1404 Taste M betätigt
    Given Bot 1405 Taste M betätigt
    Given Bot 1406 Taste M betätigt
    Given Bot 1407 Taste M betätigt
    Given Bot 1408 Taste M betätigt

    ######################################

    When ich pausiere mit Text "Trial 13 - Ziel: VW"
    When Bot 1401 Taste M betätigt
    When Bot 1403 Taste M betätigt
    When warte 40 Sekunden
    When Bot 1401 Taste M betätigt
    When Bot 1403 Taste M betätigt

    When warte 10 Sekunden

    When ich pausiere mit Text "Trial 14 - Ziel: Ford"
    When Bot 1403 Taste M betätigt
    When Bot 1405 Taste M betätigt
    When warte 40 Sekunden
    When Bot 1403 Taste M betätigt
    When Bot 1405 Taste M betätigt

    When warte 10 Sekunden

    When ich pausiere mit Text "Trial 15 - Ziel: Opel"
    When Bot 1402 Taste M betätigt
    When Bot 1408 Taste M betätigt
    When warte 40 Sekunden
    When Bot 1402 Taste M betätigt
    When Bot 1408 Taste M betätigt

    When warte 10 Sekunden

    When ich pausiere mit Text "Trial 16 - Ziel: Tesla"
    When Bot 1404 Taste M betätigt
    When Bot 1406 Taste M betätigt
    When warte 40 Sekunden
    When Bot 1404 Taste M betätigt
    When Bot 1406 Taste M betätigt