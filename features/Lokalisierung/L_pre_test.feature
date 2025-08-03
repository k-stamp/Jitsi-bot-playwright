Feature: Lokalisierung Pre Test

@l_pretest
Scenario: Vier Bots joint
  When I pause
  Given Bot 1 navigiert zur Sitzung "test"
  Given Bot 2 navigiert zur Sitzung "test"
  Given Bot 3 navigiert zur Sitzung "test"
  Given Bot 4 navigiert zur Sitzung "test"

  When I pause

  Given Bot 1 klickt auf den Join-Button
  Given warte 1 Sekunden
  Given Bot 2 klickt auf den Join-Button
  Given warte 1 Sekunden
  Given Bot 3 klickt auf den Join-Button
  Given warte 1 Sekunden
  Given Bot 4 klickt auf den Join-Button
  
  Given warte 5 Sekunden

  Given Bot 1 Taste M betätigt
  Given warte 1 Sekunden
  Given Bot 2 Taste M betätigt
  Given warte 1 Sekunden
  Given Bot 3 Taste M betätigt
  Given warte 1 Sekunden
  Given Bot 4 Taste M betätigt

  When I pause
  ######################################

  When Bot 1 Taste M betätigt
  When warte 3 Sekunden
  When Bot 1 Taste M betätigt

  When warte 1 Sekunden

  When Bot 2 Taste M betätigt
  When warte 3 Sekunden
  When Bot 2 Taste M betätigt

  When warte 1 Sekunden

  When Bot 3 Taste M betätigt
  When warte 3 Sekunden
  When Bot 3 Taste M betätigt

  When warte 1 Sekunden

  When Bot 4 Taste M betätigt
  When warte 3 Sekunden
  When Bot 4 Taste M betätigt

  When warte 10 Sekunden