# Cucumber-Integration für Jitsi-Bots

Diese Anleitung beschreibt, wie Sie Feature Files verwenden können, um Ihre Jitsi-Bot-Tests strukturiert und verständlich zu gestalten.

## Überblick

Mit der Cucumber-Integration können Sie Testszenarien in natürlicher deutscher Sprache schreiben und dabei komplexe Bot-Interaktionen in Jitsi-Meetings steuern.

## Installation und Setup

Die notwendigen Abhängigkeiten sind bereits installiert. Stellen Sie sicher, dass Ihre `config.json` korrekt konfiguriert ist.

## Verwendung

### 1. Tests ausführen

```bash
# Alle Feature-Tests ausführen
npm test

# Tests mit detaillierter Ausgabe
npm run test:debug
```

### 2. Feature Files schreiben

Feature Files befinden sich im `features/`-Verzeichnis. Hier ist die Grundstruktur:

```gherkin
# language: de
Funktionalität: Bots joinen Jitsi

  Hintergrund:
    Angenommen der Jitsi-Server ist verfügbar

  Szenario: Ihr Testszenario
    Angenommen Bot 1 joint der Sitzung "testRaum" ohne Video
    Wenn Bot 1 Audio abspielt
    Dann sollte Bot 1 Audio in der Sitzung hörbar sein
```

### 3. Verfügbare Steps

#### Bot-Beitritt (Given Steps)
- `Bot {int} joint der Sitzung {string} ohne Video`
- `Bot {int} joint der Sitzung {string} mit Video`
- `Bot {int} ist bereits der Sitzung {string} beigetreten`

#### Audio-Aktionen (When Steps)
- `Bot {int} Audio abspielt`
- `Bots {string} Audio abspielen` (z.B. "2,3,4")
- `nach {int} Sekunden spielen Bots {string} Audio ab`
- `warte {int} Sekunden`
- `Bot {int} das Audio stoppt`

#### Überprüfungen (Then Steps)
- `sollte Bot {int} Audio in der Sitzung hörbar sein`
- `sollten alle Bots {string} simultan Audio in der Sitzung abspielen`
- `sollten alle Bots Audio in der Sitzung abspielen`
- `sollte Bot {int} zuerst Audio abspielen`
- `dann sollten Bots {string} simultan Audio abspielen`
- `sollten {int} Bots in der Sitzung {string} sein`

#### Debug Steps
- `zeige aktive Bots an`

## Beispiel-Szenarien

### Einfacher Bot-Test
```gherkin
Szenario: Ein Bot spielt Audio ab
  Angenommen Bot 1 joint der Sitzung "testRaum1" ohne Video
  Wenn Bot 1 Audio abspielt
  Dann sollte Bot 1 Audio in der Sitzung hörbar sein
```

### Mehrere Bots simultan
```gherkin
Szenario: Mehrere Bots spielen simultan Audio ab
  Angenommen Bot 1 joint der Sitzung "testRaum2" ohne Video
  Und Bot 2 joint der Sitzung "testRaum2" ohne Video
  Und Bot 3 joint der Sitzung "testRaum2" mit Video
  Wenn Bots "1,2,3" Audio abspielen
  Dann sollten alle Bots "1,2,3" simultan Audio in der Sitzung abspielen
```

### Sequenzielle und parallele Wiedergabe
```gherkin
Szenario: Erst ein Bot, dann mehrere
  Angenommen Bot 1 joint der Sitzung "testRaum3" ohne Video
  Und Bot 2 joint der Sitzung "testRaum3" ohne Video
  Und Bot 3 joint der Sitzung "testRaum3" mit Video
  Wenn Bot 1 Audio abspielt
  Und nach 3 Sekunden spielen Bots "2,3" Audio ab
  Dann sollte Bot 1 zuerst Audio abspielen
  Und dann sollten Bots "2,3" simultan Audio abspielen
```

## Projektstruktur

```
├── features/
│   ├── jitsi-bots.feature          # Hauptfeature-Datei
│   ├── step_definitions/
│   │   └── jitsi-bot-steps.js      # Step-Implementierungen
│   └── support/
│       └── world.js                # Test-Umgebung
├── bot-manager.js                  # Bot-Verwaltung
├── cucumber.js                     # Cucumber-Konfiguration
└── reports/                        # Test-Berichte
```

## Konfiguration

### Bot-Konfiguration (config.json)
Stellen Sie sicher, dass Ihre Bots in der `config.json` korrekt konfiguriert sind:

```json
{
  "url": "https://ihr-jitsi-server.de/default-raum",
  "bots": [
    {
      "id": 1,
      "name": "Bot1",
      "enableAudio": true
    }
  ]
}
```

**Wichtig:** Die Feature-Tests verwenden die Bot-IDs aus der Konfiguration.

## Troubleshooting

### Häufige Probleme

1. **Bot nicht gefunden**: Prüfen Sie, ob die Bot-ID in der `config.json` existiert
2. **Mediendateien fehlen**: Stellen Sie sicher, dass die Video/Audio-Dateien im `media/`-Verzeichnis vorhanden sind
3. **Jitsi-Server nicht erreichbar**: Überprüfen Sie die URL in der `config.json`

### Logs und Debugging
- Alle Tests protokollieren detailliert ihre Aktionen
- Bei Fehlern werden automatisch Debug-Informationen ausgegeben
- Nutzen Sie `npm run test:debug` für ausführlichere Ausgaben

## Tipps

1. **Raumnamen**: Verwenden Sie eindeutige Raumnamen für verschiedene Szenarien
2. **Bot-IDs**: Nutzen Sie die Bot-IDs aus Ihrer Konfiguration
3. **Timing**: Verwenden Sie `warte {int} Sekunden` für zeitkritische Tests
4. **Audio-Listen**: Bei mehreren Bots verwenden Sie das Format "2,3,4" (ohne Leerzeichen nach Kommas)

Jetzt können Sie strukturierte, verständliche Tests für Ihre Jitsi-Bot-Implementierung schreiben! 