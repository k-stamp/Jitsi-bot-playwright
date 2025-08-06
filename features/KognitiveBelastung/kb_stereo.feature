Feature: Fokussierung Stereo

  @kb_stereo
  Scenario: Acht Bots kognitive Belastung Stereo Audio
    Given Bot 1201 navigiert zur Sitzung "rebecca5"
    Given Bot 1202 navigiert zur Sitzung "rebecca5"
    Given Bot 1203 navigiert zur Sitzung "rebecca5"
    Given Bot 1204 navigiert zur Sitzung "rebecca5"
    Given Bot 1205 navigiert zur Sitzung "rebecca5"
    Given Bot 1206 navigiert zur Sitzung "rebecca5"
    Given Bot 1207 navigiert zur Sitzung "rebecca5"
    Given Bot 1208 navigiert zur Sitzung "rebecca5"

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

    Given warte 1 Sekunden

    Given Bot 1201 toggles video
    Given Bot 1202 toggles video
    Given Bot 1203 toggles video
    Given Bot 1204 toggles video
    Given Bot 1205 toggles video
    Given Bot 1206 toggles video
    Given Bot 1207 toggles video
    Given Bot 1208 toggles video

    Given Bot 1201 toggles audio
    Given Bot 1202 toggles audio
    Given Bot 1203 toggles audio
    Given Bot 1204 toggles audio
    Given Bot 1205 toggles audio
    Given Bot 1206 toggles audio
    Given Bot 1207 toggles audio
    Given Bot 1208 toggles audio

    ######################################

    When ich pausiere mit Text "Trial 5 - Ziel: VW"
    When Bot 1201 toggles audio
    When Bot 1203 toggles audio
    When Bot 1207 toggles audio
    When warte 25 Sekunden
    When Bot 1201 toggles audio
    When Bot 1203 toggles audio
    When Bot 1207 toggles audio

    When ich pausiere mit Text "Trial 6 - Ziel: Ford"
    When Bot 1203 toggles audio
    When Bot 1205 toggles audio
    When Bot 1207 toggles audio
    When warte 25 Sekunden
    When Bot 1203 toggles audio
    When Bot 1205 toggles audio
    When Bot 1207 toggles audio

    When ich pausiere mit Text "Trial 7 - Ziel: Opel"
    When Bot 1202 toggles audio
    When Bot 1208 toggles audio
    When Bot 1207 toggles audio
    When warte 25 Sekunden
    When Bot 1202 toggles audio
    When Bot 1208 toggles audio
    When Bot 1207 toggles audio

    When ich pausiere mit Text "Trial 8 - Ziel: Tesla"
    When Bot 1204 toggles audio
    When Bot 1206 toggles audio
    When Bot 1207 toggles audio
    When warte 25 Sekunden
    When Bot 1204 toggles audio
    When Bot 1206 toggles audio
    When Bot 1207 toggles audio