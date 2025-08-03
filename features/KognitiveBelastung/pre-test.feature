Feature: Lokalisierung HRTF

  @kb
  Scenario: Vier Bots joint
    When I pause
    Given Bot 13 navigiert zur Sitzung "kb1"
    Given Bot 14 navigiert zur Sitzung "kb1"
    Given Bot 15 navigiert zur Sitzung "kb1"
    Given Bot 16 navigiert zur Sitzung "kb1"

    When I pause

    Given Bot 13 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 14 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 15 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 16 klickt auf den Join-Button
    
    Given warte 5 Sekunden

    Given Bot 13 Taste M betätigt
    Given Bot 14 Taste M betätigt
    Given Bot 15 Taste M betätigt
    Given Bot 16 Taste M betätigt

    When I pause
    ######################################

    When Bot 13 Taste M betätigt
    When Bot 16 Taste M betätigt