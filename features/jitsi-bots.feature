# language: de
Funktionalität: Bots joinen Jitsi

  Hintergrund:
    Angenommen der Jitsi-Server ist verfügbar

  Szenario: Grundlegendes Bot-Verhalten bei Jitsi-Beitritt
    Angenommen Bot 1 joint der Sitzung "testRaum1" ohne Video
    Und Bot 2 joint der Sitzung "testRaum1" ohne Video
    Und Bot 3 joint der Sitzung "testRaum1" mit Video
    Wenn Bot 2 Audio abspielt
    Dann sollte Bot 2 Audio in der Sitzung hörbar sein

  Szenario: Mehrere Bots spielen simultan Audio ab
    Angenommen Bot 1 joint der Sitzung "testRaum2" ohne Video
    Und Bot 2 joint der Sitzung "testRaum2" ohne Video
    Und Bot 3 joint der Sitzung "testRaum2" mit Video
    Und Bot 4 joint der Sitzung "testRaum2" ohne Video
    Wenn Bots "2,3,4" Audio abspielen
    Dann sollten alle Bots "2,3,4" simultan Audio in der Sitzung abspielen

  Szenario: Bots mit unterschiedlichen Konfigurationen
    Angenommen Bot 5 joint der Sitzung "testRaum3" mit Video
    Und Bot 6 joint der Sitzung "testRaum3" ohne Video
    Und Bot 7 joint der Sitzung "testRaum3" mit Video
    Wenn Bot 5 Audio abspielt
    Und nach 5 Sekunden spielen Bots "6,7" Audio ab
    Dann sollten alle Bots Audio in der Sitzung abspielen

  Szenario: Sequenzielle und parallele Audio-Wiedergabe
    Angenommen Bot 8 joint der Sitzung "testRaum4" ohne Video
    Und Bot 9 joint der Sitzung "testRaum4" mit Video
    Und Bot 10 joint der Sitzung "testRaum4" ohne Video
    Wenn Bot 8 Audio abspielt
    Und warte 3 Sekunden
    Und Bots "9,10" Audio abspielen
    Dann sollte Bot 8 zuerst Audio abspielen
    Und dann sollten Bots "9,10" simultan Audio abspielen 