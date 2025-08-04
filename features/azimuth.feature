Feature: Azimuth  Test

@azi
Scenario: Vier Bots joint
  When I pause
  Given Bot 1 navigiert zur Sitzung "x5000"
  Given Bot 2 navigiert zur Sitzung "x5000"
  Given Bot 3 navigiert zur Sitzung "x5000"
  Given Bot 4 navigiert zur Sitzung "x5000"
  Given Bot 5 navigiert zur Sitzung "x5000"
  Given Bot 6 navigiert zur Sitzung "x5000"
  Given Bot 7 navigiert zur Sitzung "x5000"
  Given Bot 8 navigiert zur Sitzung "x5000"

  When I pause

  Given Bot 1 klickt auf den Join-Button
  Given warte 1 Sekunden
  Given Bot 2 klickt auf den Join-Button
  Given warte 1 Sekunden
  Given Bot 3 klickt auf den Join-Button
  Given warte 1 Sekunden
  Given Bot 4 klickt auf den Join-Button
  Given warte 1 Sekunden
  Given Bot 5 klickt auf den Join-Button
  Given warte 1 Sekunden
  Given Bot 6 klickt auf den Join-Button
  Given warte 1 Sekunden
  Given Bot 7 klickt auf den Join-Button
  Given warte 1 Sekunden
  Given Bot 8 klickt auf den Join-Button
  
  Given warte 5 Sekunden

  Given Bot 1 Taste M betätigt
  Given warte 1 Sekunden
  Given Bot 2 Taste M betätigt
  Given warte 1 Sekunden
  Given Bot 3 Taste M betätigt
  Given warte 1 Sekunden
  Given Bot 4 Taste M betätigt
  Given warte 1 Sekunden
  Given Bot 5 Taste M betätigt
  Given warte 1 Sekunden
  Given Bot 6 Taste M betätigt
  Given warte 1 Sekunden
  Given Bot 7 Taste M betätigt
  Given warte 1 Sekunden
  Given Bot 8 Taste M betätigt

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
  When warte 1 Sekunden

  When Bot 5 Taste M betätigt
  When warte 3 Sekunden
  When Bot 5 Taste M betätigt

  When warte 1 Sekunden

  When Bot 6 Taste M betätigt
  When warte 3 Sekunden
  When Bot 6 Taste M betätigt

  When warte 1 Sekunden

  When Bot 7 Taste M betätigt   
  When warte 3 Sekunden
  When Bot 7 Taste M betätigt

  When warte 1 Sekunden

  When Bot 8 Taste M betätigt
  When warte 3 Sekunden
  When Bot 8 Taste M betätigt

  When warte 10 Sekunden
