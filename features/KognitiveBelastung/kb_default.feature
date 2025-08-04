Feature: Fokussierung Default

  @kb_default
  Scenario: Acht Bots kognitive Belastung Default Audio
    When ich pausiere mit Text "Bot-Browser bereit"
    Given Bot 1101 navigiert zur Sitzung "kevin7"
    Given Bot 1102 navigiert zur Sitzung "kevin7"
    Given Bot 1103 navigiert zur Sitzung "kevin7"
    Given Bot 1104 navigiert zur Sitzung "kevin7"
    Given Bot 1105 navigiert zur Sitzung "kevin7"
    Given Bot 1106 navigiert zur Sitzung "kevin7"
    Given Bot 1107 navigiert zur Sitzung "kevin7"
    Given Bot 1108 navigiert zur Sitzung "kevin7"

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

    Given warte 1 Sekunden

    Given Bot 1101 toggles video
    Given Bot 1102 toggles video
    Given Bot 1103 toggles video
    Given Bot 1104 toggles video
    Given Bot 1105 toggles video
    Given Bot 1106 toggles video
    Given Bot 1107 toggles video
    Given Bot 1108 toggles video

    Given Bot 1101 toggles audio
    Given Bot 1102 toggles audio
    Given Bot 1103 toggles audio
    Given Bot 1104 toggles audio
    Given Bot 1105 toggles audio
    Given Bot 1106 toggles audio
    Given Bot 1107 toggles audio
    Given Bot 1108 toggles audio

    ######################################

    When ich pausiere mit Text "Trial 1 - Ziel: Audi"
    When Bot 1101 toggles audio
    When Bot 1103 toggles audio
    When warte 30 Sekunden
    When Bot 1101 toggles audio
    When Bot 1103 toggles audio

    When warte 10 Sekunden

    When ich pausiere mit Text "Trial 2 - Ziel: Mercedes"
    When Bot 1103 toggles audio
    When Bot 1105 toggles audio
    When warte 30 Sekunden
    When Bot 1103 toggles audio
    When Bot 1105 toggles audio

    When warte 10 Sekunden

    When ich pausiere mit Text "Trial 3 - Ziel: BMW"
    When Bot 1102 toggles audio
    When Bot 1108 toggles audio
    When warte 30 Sekunden
    When Bot 1102 toggles audio
    When Bot 1108 toggles audio

    When warte 10 Sekunden

    When ich pausiere mit Text "Trial 4 - Ziel: Porsche"
    When Bot 1104 toggles audio
    When Bot 1106 toggles audio
    When warte 30 Sekunden
    When Bot 1104 toggles audio
    When Bot 1106 toggles audio