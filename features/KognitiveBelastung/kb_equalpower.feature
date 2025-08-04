Feature: Fokussierung Equalpower

  @kb_equalpower
  Scenario: Acht Bots kognitive Belastung Equalpower Audio
    When ich pausiere mit Text "Bot-Browser bereit"
    Given Bot 1301 navigiert zur Sitzung "kb103"
    Given Bot 1302 navigiert zur Sitzung "kb103"
    Given Bot 1303 navigiert zur Sitzung "kb103"
    Given Bot 1304 navigiert zur Sitzung "kb103"
    Given Bot 1305 navigiert zur Sitzung "kb103"
    Given Bot 1306 navigiert zur Sitzung "kb103"
    Given Bot 1307 navigiert zur Sitzung "kb103"
    Given Bot 1308 navigiert zur Sitzung "kb103"

    When ich pausiere mit Text "Sitzungen geladen, bereit für Beitritt"

    Given Bot 1301 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 1302 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 1303 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 1304 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 1305 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 1306 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 1307 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 1308 klickt auf den Join-Button

    Given warte 5 Sekunden

    Given Bot 1301 Taste M betätigt
    Given Bot 1302 Taste M betätigt
    Given Bot 1303 Taste M betätigt
    Given Bot 1304 Taste M betätigt
    Given Bot 1305 Taste M betätigt
    Given Bot 1306 Taste M betätigt
    Given Bot 1307 Taste M betätigt
    Given Bot 1308 Taste M betätigt

    ######################################

    When ich pausiere mit Text "Trial 9 - Ziel: Audi"
    When Bot 1301 Taste M betätigt
    When Bot 1303 Taste M betätigt
    When warte 40 Sekunden
    When Bot 1301 Taste M betätigt
    When Bot 1303 Taste M betätigt

    When warte 10 Sekunden

    When ich pausiere mit Text "Trial 10 - Ziel: Mercedes"
    When Bot 1303 Taste M betätigt
    When Bot 1305 Taste M betätigt
    When warte 40 Sekunden
    When Bot 1303 Taste M betätigt
    When Bot 1305 Taste M betätigt

    When warte 10 Sekunden

    When ich pausiere mit Text "Trial 11 - Ziel: BMW"
    When Bot 1302 Taste M betätigt
    When Bot 1308 Taste M betätigt
    When warte 40 Sekunden
    When Bot 1302 Taste M betätigt
    When Bot 1308 Taste M betätigt

    When warte 10 Sekunden

    When ich pausiere mit Text "Trial 12 - Ziel: Porsche"
    When Bot 1304 Taste M betätigt
    When Bot 1306 Taste M betätigt
    When warte 40 Sekunden
    When Bot 1304 Taste M betätigt
    When Bot 1306 Taste M betätigt