Feature: Lokalisierung HRTF

  @kb_default
  Scenario: Acht Bots kognitive Belastung
    When I pause
    Given Bot 101 navigiert zur Sitzung "kb10"
    Given Bot 102 navigiert zur Sitzung "kb10"
    Given Bot 103 navigiert zur Sitzung "kb10"
    Given Bot 104 navigiert zur Sitzung "kb10"
    Given Bot 105 navigiert zur Sitzung "kb10"
    Given Bot 106 navigiert zur Sitzung "kb10"
    Given Bot 107 navigiert zur Sitzung "kb10"
    Given Bot 108 navigiert zur Sitzung "kb10"

    When I pause

    Given Bot 101 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 102 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 103 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 104 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 105 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 106 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 107 klickt auf den Join-Button
    Given warte 1 Sekunden
    Given Bot 108 klickt auf den Join-Button

    Given warte 5 Sekunden

    Given Bot 101 Taste M betätigt
    Given Bot 102 Taste M betätigt
    Given Bot 103 Taste M betätigt
    Given Bot 104 Taste M betätigt
    Given Bot 105 Taste M betätigt
    Given Bot 106 Taste M betätigt
    Given Bot 107 Taste M betätigt
    Given Bot 108 Taste M betätigt

    When I pause
    ######################################
    ##### **Block 1: Audio-Modus Mono -> Verwendung von Setup 1**
# - Block 1: Audio-Modus Mono -> Verwendung von Setup 1
# - Trial 1 (A vs. C): Proband hört M1 (Audi) vs. M2 (VW). (Männer-Paar)
# - Trial 2 (B vs. G): Proband hört F1 (Mercedes) vs. F2 (Opel). (Frauen-Paar)
# - Trial 3 (C vs. H): Proband hört M2 (VW) vs. M1 (Tesla). (Männer-Paar)
# - Trial 4 (D vs. E): Proband hört F2 (BMW) vs. F1 (Porsche). (Frauen-Paar)

    # Proband hört M1 (Audi)
    When Bot 101 Taste M betätigt
    When Bot 103 Taste M betätigt
    When warte 40 Sekunden
    When Bot 101 Taste M betätigt
    When Bot 103 Taste M betätigt

    When I pause

    # Proband hört F1 (Mercedes)
    When Bot 102 Taste M betätigt
    When Bot 107 Taste M betätigt
    When warte 40 Sekunden
    When Bot 102 Taste M betätigt
    When Bot 107 Taste M betätigt

    When I pause

    # Proband hört M2 (VW)
    When Bot 103 Taste M betätigt
    When Bot 108 Taste M betätigt
    When warte 40 Sekunden
    When Bot 103 Taste M betätigt
    When Bot 108 Taste M betätigt

    When I pause

    # Proband hört F2 (BMW)
    When Bot 104 Taste M betätigt
    When Bot 105 Taste M betätigt
    When warte 40 Sekunden
    When Bot 104 Taste M betätigt
    When Bot 105 Taste M betätigt

    Given warte 60 Sekunden