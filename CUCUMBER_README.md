# Cucumber Integration für Jitsi Bot Tests

## Überblick

Dieses Projekt wurde um Cucumber (Behavior-Driven Development) erweitert, um strukturierte Testszenarien für die Jitsi-Bot-Automatisierung zu ermöglichen.

## Installation

Installieren Sie die neuen Dependencies:

```bash
npm install
```

## Verfügbare Kommandos

### Alle Tests ausführen
```bash
npm test
```

### Nur Debug-Szenarien ausführen (mit Pause-Funktionalität)
```bash
npm run test:debug
```

### Spezifisches Feature ausführen
```bash
npm run test:scenario
```

## Features

### 1. Debug-Szenario mit Pause-Funktionalität

Das Hauptszenario (`@debug`) implementiert genau Ihre Anforderung:

1. **Alle Bots werden zur Konferenz hinzugefügt**
2. **System pausiert für Debugging** - Sie können:
   - Browser-Fenster überprüfen
   - Konferenz manuell testen
   - Screenshots machen
3. **Drücken Sie ENTER zum Fortfahren**
4. **Audio/Video wird für alle Bots gleichzeitig aktiviert**

### 2. Schrittweise Bot-Hinzufügung

Für Tests mit einzelnen Bots und Wartezeiten zwischen den Bots.

### 3. Verschiedene Medien-Inhalte

Test mit spezifischen Video- und Audio-Dateien für jeden Bot.

## Verwendung

### Debug-Szenario starten

```bash
npm run test:debug
```

**Ablauf:**
1. Alle 7 Bots werden zur Jitsi-Konferenz hinzugefügt
2. Browser-Fenster öffnen sich (nicht headless für Debugging)
3. System pausiert mit der Meldung: "Drücken Sie ENTER, um fortzufahren..."
4. Sie können die Konferenz inspizieren
5. ENTER drücken → Audio/Video startet für alle Bots gleichzeitig

### Eigene Szenarien erstellen

Erstellen Sie neue `.feature` Dateien in `features/` mit der Gherkin-Syntax:

```gherkin
# language: de
Funktionalität: Mein neuer Test
  
  Szenario: Mein Testszenario
    Gegeben sei eine Jitsi-Konferenz-URL "https://ihre-url.com/test"
    Und ich habe 3 konfigurierte Bots
    Wenn ich alle Bots zur Konferenz hinzufüge
    Dann sollten alle Bots erfolgreich der Konferenz beigetreten sein
```

## Verfügbare Step-Definitionen

### Given (Gegeben)
- `Gegeben sei eine Jitsi-Konferenz-URL "URL"`
- `Und ich habe {int} konfigurierte Bots`
- `Und ich habe Bots mit verschiedenen Video-Inhalten:`

### When (Wenn)
- `Wenn ich alle Bots zur Konferenz hinzufüge`
- `Wenn ich Bot {int} zur Konferenz hinzufüge`
- `Wenn ich warte {int} Sekunden`
- `Wenn ich die Ausführung fortsetze`

### Then (Dann)
- `Dann sollten alle Bots erfolgreich der Konferenz beigetreten sein`
- `Und das System pausiert für Debugging`
- `Dann starten alle Bots gleichzeitig Audio und Video`
- `Und alle Medien werden synchron abgespielt`
- `Dann sollten alle {int} Bots in der Konferenz sein`
- `Dann sollte jeder Bot seinen eigenen Medien-Inhalt abspielen`

## Debugging-Features

### Pause-Funktionalität
Das `@debug` Tag aktiviert eine interaktive Pause, bei der:
- Alle Browser-Fenster sichtbar bleiben
- Das System auf ENTER wartet
- Sie die Konferenz manuell überprüfen können

### Browser-Sichtbarkeit
Im Debug-Modus sind alle Browser-Fenster sichtbar (`headless: false`).

### Erweiterte Timeouts
Debug-Szenarien haben längere Timeouts (5 Minuten) für ausführliche Tests.

## Berichte

Cucumber generiert automatisch Berichte:
- `reports/cucumber_report.json` - JSON-Format
- `reports/cucumber_report.html` - HTML-Format

## Konfiguration

Die Cucumber-Konfiguration befindet sich in `cucumber.js`:
- Standard-Konfiguration für normale Tests
- Debug-Konfiguration für interaktive Tests

## Erweiterte Nutzung

### Tags verwenden
```bash
# Nur Debug-Tests
npx cucumber-js --tags @debug

# Alle außer Skip-Tests
npx cucumber-js --tags "not @skip"

# Mehrere Tags
npx cucumber-js --tags "@debug and @smoke"
```

### Parallele Ausführung
```bash
npx cucumber-js --parallel 2
```

### Spezifische Features
```bash
npx cucumber-js features/jitsi-conference.feature
```

## Troubleshooting

### Browser schließen nicht automatisch
Die Browser werden nach jedem Szenario automatisch geschlossen. Bei Fehlern können Sie sie manuell schließen.

### Medien-Dateien nicht gefunden
Stellen Sie sicher, dass alle Video- und Audio-Dateien in den entsprechenden `media/bot*/` Ordnern vorhanden sind.

### Timeout-Fehler
Erhöhen Sie die Timeouts in `cucumber.js` oder verwenden Sie das Debug-Profil.

## Beispiel-Ausgabe

```
🔍 DEBUGGING-PAUSE AKTIVIERT
=====================================
Alle Bots sind jetzt in der Konferenz.
Sie können jetzt:
- Die Browser-Fenster überprüfen
- Die Konferenz manuell testen
- Screenshots machen

Drücken Sie ENTER, um fortzufahren...
=====================================
``` 