# language: de
Funktionalität: Genaue Steuerung von Jitsi Bots für manuelle Tests

  Hintergrund:
    Angenommen der Jitsi-Server ist verfügbar

  @test
  Szenario: Bots treten gestaffelt bei und spielen Audio auf Kommando ab
    # SCHRITT 1: Alle Bots treten der Konferenz bei.
    # Sie sind jetzt im Raum, aber ihre Mikrofone sind von Jitsi stummgeschaltet.
    # Es wird noch KEIN Audio übertragen.
    Angenommen Bot 1 joint der Sitzung "test1" ohne Video
    Und Bot 2 joint der Sitzung "test1" ohne Video
    Und Bot 5 joint der Sitzung "test1" mit Video

    # SCHRITT 2: Wir warten eine Weile.
    # In dieser Zeit können Sie die Teilnehmerliste in Jitsi überprüfen.
    # Alle Bots sind anwesend, aber still.
    Wenn warte 15 Sekunden

    # SCHRITT 3: Bot 1 wird "aktiviert".
    # Sein Mikrofon-Button in Jitsi wird per Code geklickt.
    # Erst JETZT wird die hinterlegte Audio-Datei in die Konferenz eingespeist.
    Wenn Bot 1 Audio abspielt

    # SCHRITT 4: Erneut eine Pause zur Beobachtung.
    Wenn warte 10 Sekunden

    # SCHRITT 5: Die restlichen Bots werden simultan aktiviert.
    # Ihre Mikrofone werden ebenfalls freigeschaltet.
    Wenn Bots "2,5" Audio abspielen 