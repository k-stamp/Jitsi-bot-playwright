Feature: Fokussierung Stereo

  @kb_stereo
  Scenario: Acht Bots kognitive Belastung Stereo Audio
    When ich pausiere mit Text "Bot-Browser bereit"
    Given Bot 1201 navigiert zur Sitzung "kb102"
    Given Bot 1202 navigiert zur Sitzung "kb102"
    Given Bot 1203 navigiert zur Sitzung "kb102"
    Given Bot 1204 navigiert zur Sitzung "kb102"
    Given Bot 1205 navigiert zur Sitzung "kb102"
    Given Bot 1206 navigiert zur Sitzung "kb102"
    Given Bot 1207 navigiert zur Sitzung "kb102"
    Given Bot 1208 navigiert zur Sitzung "kb102"

    When ich pausiere mit Text "Sitzungen geladen, bereit für Beitritt"

    Given Bot 1201 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 1202 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 1203 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 1204 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 1205 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 1206 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 1207 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 1208 klickt auf den Join-Button

    Given warte 5 Sekunden

    Given Bot 1201 Taste M betätigt
    Given Bot 1202 Taste M betätigt
    Given Bot 1203 Taste M betätigt
    Given Bot 1204 Taste M betätigt
    Given Bot 1205 Taste M betätigt
    Given Bot 1206 Taste M betätigt
    Given Bot 1207 Taste M betätigt
    Given Bot 1208 Taste M betätigt

    ######################################

    When ich pausiere mit Text "Trial 5 - Ziel: VW"
    When Bot 1201 Taste M betätigt
    When Bot 1203 Taste M betätigt
    When warte 40 Sekunden
    When Bot 1201 Taste M betätigt
    When Bot 1203 Taste M betätigt

    When warte 10 Sekunden

    When ich pausiere mit Text "Trial 6 - Ziel: Ford"
    When Bot 1203 Taste M betätigt
    When Bot 1205 Taste M betätigt
    When warte 40 Sekunden
    When Bot 1203 Taste M betätigt
    When Bot 1205 Taste M betätigt

    When warte 10 Sekunden

    When ich pausiere mit Text "Trial 7 - Ziel: Opel"
    When Bot 1202 Taste M betätigt
    When Bot 1208 Taste M betätigt
    When warte 40 Sekunden
    When Bot 1202 Taste M betätigt
    When Bot 1208 Taste M betätigt

    When warte 10 Sekunden

    When ich pausiere mit Text "Trial 8 - Ziel: Tesla"
    When Bot 1204 Taste M betätigt
    When Bot 1206 Taste M betätigt
    When warte 40 Sekunden
    When Bot 1204 Taste M betätigt
    When Bot 1206 Taste M betätigt