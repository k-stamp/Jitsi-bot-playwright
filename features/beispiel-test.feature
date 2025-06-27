# language: de
Funktionalität: Einfacher Jitsi-Bot Test

  Hintergrund:
    Angenommen der Jitsi-Server ist verfügbar

  @einzelbot @schnell
  Szenario: Ein einzelner Bot tritt bei und spielt Audio ab
    Angenommen Bot 1 joint der Sitzung "einfacherTest3" ohne Video
    Wenn Bot 1 Audio abspielt
    Dann sollte Bot 1 Audio in der Sitzung hörbar sein
    Und sollten 1 Bots in der Sitzung "einfacherTest3" sein

  @mehrbots @audio-simultan
  Szenario: Zwei Bots spielen simultan Audio ab
    Angenommen Bot 1 joint der Sitzung "zweiBotsTest" ohne Video
    Und Bot 5 joint der Sitzung "zweiBotsTest" ohne Video
    Wenn Bots "1,5" Audio abspielen
    Dann sollten alle Bots "1,5" simultan Audio in der Sitzung abspielen
    Und sollten 2 Bots in der Sitzung "zweiBotsTest" sein 