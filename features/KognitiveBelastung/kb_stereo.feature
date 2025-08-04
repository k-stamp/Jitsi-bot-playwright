Feature: Fokussierung Stereo

  @kb_stereo
  Scenario: Acht Bots kognitive Belastung Stereo Audio
    When ich pausiere mit Text "Bot-Browser bereit"
    Given Bot 201 navigiert zur Sitzung "kb13"
    Given Bot 202 navigiert zur Sitzung "kb13"
    Given Bot 203 navigiert zur Sitzung "kb13"
    Given Bot 204 navigiert zur Sitzung "kb13"
    Given Bot 205 navigiert zur Sitzung "kb13"
    Given Bot 206 navigiert zur Sitzung "kb13"
    Given Bot 207 navigiert zur Sitzung "kb13"
    Given Bot 208 navigiert zur Sitzung "kb13"

    When ich pausiere mit Text "Sitzungen geladen, bereit für Beitritt"

    Given Bot 201 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 202 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 203 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 204 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 205 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 206 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 207 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 208 klickt auf den Join-Button

    Given warte 5 Sekunden

    Given Bot 201 Taste M betätigt
    Given Bot 202 Taste M betätigt
    Given Bot 203 Taste M betätigt
    Given Bot 204 Taste M betätigt
    Given Bot 205 Taste M betätigt
    Given Bot 206 Taste M betätigt
    Given Bot 207 Taste M betätigt
    Given Bot 208 Taste M betätigt

    ######################################
    ##### **Block 2: Audio-Modus Stereo -> Verwendung von Setup 2**
# - Block 2: Audio-Modus Stereo -> Verwendung von Setup 2
# - Trial 5 (A vs. C): Ziel: Bot A (M1, Mercedes A-Klasse Rot) vs. Störer: Bot C (M2, Ford Focus Blau). (Männer-Paar)
# - Trial 6 (B vs. G): Ziel: Bot B (F1, BMW X3 Grau) vs. Störer: Bot G (F2, Tesla Model 3 Grün). (Frauen-Paar)
# - Trial 7 (C vs. H): Ziel: Bot C (M2, Ford Focus Blau) vs. Störer: Bot H (M1, VW Golf Weiß). (Männer-Paar)
# - Trial 8 (D vs. E): Ziel: Bot D (F2, Porsche 911 Gelb) vs. Störer: Bot E (F1, Audi Q5 Schwarz). (Frauen-Paar)


    When ich pausiere mit Text "Trial 5 - Ziel: Mercedes A-Klasse"
    When Bot 201 Taste M betätigt
    When Bot 203 Taste M betätigt
    When warte 40 Sekunden
    When Bot 201 Taste M betätigt
    When Bot 203 Taste M betätigt

    When warte 10 Sekunden

    When ich pausiere mit Text "Trial 6 - Ziel: BMW X3"
    When Bot 202 Taste M betätigt
    When Bot 207 Taste M betätigt
    When warte 40 Sekunden
    When Bot 202 Taste M betätigt
    When Bot 207 Taste M betätigt

    When warte 10 Sekunden

    When ich pausiere mit Text "Trial 7 - Ziel: Ford Focus"
    When Bot 203 Taste M betätigt
    When Bot 208 Taste M betätigt
    When warte 40 Sekunden
    When Bot 203 Taste M betätigt
    When Bot 208 Taste M betätigt

    When warte 10 Sekunden

    When ich pausiere mit Text "Trial 8 - Ziel: Porsche 911"
    When Bot 204 Taste M betätigt
    When Bot 205 Taste M betätigt
    When warte 40 Sekunden
    When Bot 204 Taste M betätigt
    When Bot 205 Taste M betätigt