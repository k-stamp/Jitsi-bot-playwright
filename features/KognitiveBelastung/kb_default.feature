Feature: Fokussierung Default

  @kb_default
  Scenario: Acht Bots kognitive Belastung Default Audio
    When ich pausiere mit Text "Bot-Browser bereit"
    Given Bot 1101 navigiert zur Sitzung "kb101"
    Given Bot 1102 navigiert zur Sitzung "kb101"
    Given Bot 1103 navigiert zur Sitzung "kb101"
    Given Bot 1104 navigiert zur Sitzung "kb101"
    Given Bot 1105 navigiert zur Sitzung "kb101"
    Given Bot 1106 navigiert zur Sitzung "kb101"
    Given Bot 1107 navigiert zur Sitzung "kb101"
    Given Bot 1108 navigiert zur Sitzung "kb101"

    When ich pausiere mit Text "Sitzungen geladen, bereit für Beitritt"

    Given Bot 1101 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 1102 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 1103 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 1104 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 1105 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 1106 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 1107 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 1108 klickt auf den Join-Button

    Given warte 5 Sekunden

    Given Bot 1101 Taste M betätigt
    Given Bot 1102 Taste M betätigt
    Given Bot 1103 Taste M betätigt
    Given Bot 1104 Taste M betätigt
    Given Bot 1105 Taste M betätigt
    Given Bot 1106 Taste M betätigt
    Given Bot 1107 Taste M betätigt
    Given Bot 1108 Taste M betätigt

    ######################################

    When ich pausiere mit Text "Trial 1 - Ziel: Audi"
    When Bot 1101 Taste M betätigt
    When Bot 1103 Taste M betätigt
    When warte 40 Sekunden
    When Bot 1101 Taste M betätigt
    When Bot 1103 Taste M betätigt

    When warte 10 Sekunden

    When ich pausiere mit Text "Trial 2 - Ziel: Mercedes"
    When Bot 1103 Taste M betätigt
    When Bot 1105 Taste M betätigt
    When warte 40 Sekunden
    When Bot 1103 Taste M betätigt
    When Bot 1105 Taste M betätigt

    When warte 10 Sekunden

    When ich pausiere mit Text "Trial 3 - Ziel: BMW"
    When Bot 1102 Taste M betätigt
    When Bot 1108 Taste M betätigt
    When warte 40 Sekunden
    When Bot 1102 Taste M betätigt
    When Bot 1108 Taste M betätigt

    When warte 10 Sekunden

    When ich pausiere mit Text "Trial 4 - Ziel: Porsche"
    When Bot 1104 Taste M betätigt
    When Bot 1106 Taste M betätigt
    When warte 40 Sekunden
    When Bot 1104 Taste M betätigt
    When Bot 1106 Taste M betätigt