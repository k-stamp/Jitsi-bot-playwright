Feature: Lokalisierung Pre Test

@l_pretest
Scenario: Vier Bots joint
  When I pause
  Given Bot 1 joint der Sitzung "test"
  Given Bot 2 joint der Sitzung "test"
  Given Bot 3 joint der Sitzung "test"
  Given Bot 4 joint der Sitzung "test"
  
  Given warte 5 Sekunden

  Given Bot 1 Taste M betätigt
  Given Bot 2 Taste M betätigt
  Given Bot 3 Taste M betätigt
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