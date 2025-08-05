Feature: Lokalisierung Pre Test

@l_pretest
Scenario: Vier Bots joint
  Given Bot 1 navigiert zur Sitzung "l-pretest1"
  Given Bot 2 navigiert zur Sitzung "l-pretest1"
  Given Bot 3 navigiert zur Sitzung "l-pretest1"
  Given Bot 4 navigiert zur Sitzung "l-pretest1"

  When I pause

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

  When I pause
  ######################################

  When Bot 1 toggles audio
  When warte 3 Sekunden
  When Bot 1 toggles audio

  When Bot 2 toggles audio
  When warte 3 Sekunden
  When Bot 2 toggles audio

  When Bot 3 toggles audio
  When warte 3 Sekunden
  When Bot 3 toggles audio

  When Bot 4 toggles audio
  When warte 3 Sekunden
  When Bot 4 toggles audio

  When warte 5 Sekunden