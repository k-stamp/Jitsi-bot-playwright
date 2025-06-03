# language: de
Funktionalität: Jitsi Konferenz Bot Automatisierung
  Als Tester
  Möchte ich mehrere Bots in eine Jitsi-Konferenz einladen
  Um das Verhalten der Konferenz mit mehreren Teilnehmern zu testen

  @debug
  Szenario: Alle Bots zur Konferenz hinzufügen und dann Audio/Video gleichzeitig starten
    Gegeben sei eine Jitsi-Konferenz-URL "https://kvnstp-jitsi.online/testconf"
    Und ich habe 7 konfigurierte Bots
    Wenn ich alle Bots zur Konferenz hinzufüge
    Dann sollten alle Bots erfolgreich der Konferenz beigetreten sein
    Und das System pausiert für Debugging
    Wenn ich die Ausführung fortsetze
    Dann starten alle Bots gleichzeitig Audio und Video
    Und alle Medien werden synchron abgespielt

  Szenario: Einzelne Bots schrittweise hinzufügen
    Gegeben sei eine Jitsi-Konferenz-URL "https://kvnstp-jitsi.online/testconf"
    Und ich habe 3 konfigurierte Bots
    Wenn ich Bot 1 zur Konferenz hinzufüge
    Und ich warte 5 Sekunden
    Wenn ich Bot 2 zur Konferenz hinzufüge
    Und ich warte 5 Sekunden
    Wenn ich Bot 3 zur Konferenz hinzufüge
    Dann sollten alle 3 Bots in der Konferenz sein

  Szenario: Bots mit verschiedenen Medien-Inhalten
    Gegeben sei eine Jitsi-Konferenz-URL "https://kvnstp-jitsi.online/testconf"
    Und ich habe Bots mit verschiedenen Video-Inhalten:
      | Bot | Video-Datei      | Audio-Datei      |
      | 1   | bot1.y4m        | bot1.wav        |
      | 2   | Tagesschau1.y4m | Tagesschau1.wav |
      | 3   | Tagesschau2.y4m | Tagesschau2.wav |
    Wenn ich alle Bots zur Konferenz hinzufüge
    Dann sollte jeder Bot seinen eigenen Medien-Inhalt abspielen 