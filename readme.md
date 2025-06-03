# Jitsi-Bot-Playwright

Ein automatisiertes Tool zur Erstellung mehrerer Bot-Teilnehmer in Jitsi Meet Videokonferenzen, basierend auf Playwright. Dieses Projekt ermöglicht es, realistische Bots mit Audio- und Video-Streams zu erstellen, die für Tests und Demonstrationen von Videokonferenz-Systemen verwendet werden können.

## 🚀 Funktionen

- **Mehrere automatisierte Browser-Sitzungen**: Erstellt beliebig viele Bot-Teilnehmer
- **Realistische Audio/Video-Streams**: Verwendet echte Medien-Dateien für authentische Simulation
- **Automatischer Konferenz-Beitritt**: Tritt automatisch Jitsi Meet Konferenzen bei
- **Automatisches Verlassen**: Bots können nach einer konfigurierbaren Zeit automatisch die Konferenz verlassen
- **Flexible Namensgebung**: Zufällige oder benutzerdefinierte Bot-Namen
- **Passwort-Unterstützung**: Funktioniert mit passwortgeschützten Räumen
- **Debug-Modus**: Ausführliche Protokollierung für Fehlerbehebung
- **Konfigurierbare Verzögerungen**: Steuert das Timing zwischen Bot-Starts

## 📋 Voraussetzungen

- **Node.js** (Version 14 oder höher)
- **npm** oder **yarn**
- **Chromium-Browser** (wird automatisch von Playwright installiert)

## 🛠️ Installation

1. **Repository klonen oder herunterladen**
   ```bash
   git clone <repository-url>
   cd Jitsi-bot-playwright
   ```

2. **Abhängigkeiten installieren**
   ```bash
   npm install
   ```

3. **Playwright-Browser installieren**
   ```bash
   npx playwright install chromium
   ```

## 📁 Projektstruktur

## Konfiguration

Alle Einstellungen befinden sich in der `config.json` Datei. Hier ein Beispiel:

```json
{
  "url": "https://meet.jit.si/DeinMeetingRaum",
  "numberofbots": 5,
  "headless": false,
  "delayBetweenBots": 3000,
  "userandomnames": true,
  "customname": "TestBot",
  "haspassword": false,
  "password": "meetingpasswort",
  "raisehands": true,
  "writemessage": true,
  "message": "Hallo aus dem automatisierten Test!",
  "messageInterval": 10000,
  "autoclose": false,
  "runtime": 300000,
  "autoLeaveAfter": 180000,
  "recordSessions": false,
  "debug": true,
  "enableAudio": true,
  "enableVideo": true
}
```

### Konfigurationsoptionen

| Option | Beschreibung | Standardwert |
|--------|--------------|--------------|
| url | URL der Videokonferenz | - |
| numberofbots | Anzahl der zu erstellenden Bots | 1 |
| headless | Browser im Hintergrund ausführen | false |
| delayBetweenBots | Verzögerung zwischen dem Start von Bots (ms) | 2000 |
| userandomnames | Zufällige Namen verwenden | true |
| customname | Benutzerdefinierter Name (wenn userandomnames false ist) | "TestBot" |
| haspassword | Gibt an, ob der Raum ein Passwort benötigt | false |
| password | Passwort für den Raum | - |
| raisehands | Hände nach dem Beitritt heben | false |
| writemessage | Nachrichten im Chat senden | false |
| message | Zu sendende Nachricht | "Hallo" |
| messageInterval | Intervall zwischen Nachrichten (ms) | 5000 |
| autoclose | Automatisch nach einer bestimmten Zeit beenden | false |
| runtime | Laufzeit in Millisekunden, wenn autoclose true ist | 60000 |
| autoLeaveAfter | Zeit in ms, nach der Bots automatisch die Konferenz verlassen | - (deaktiviert) |
| recordSessions | Browser-Sitzungen aufzeichnen | false |
| debug | Debug-Modus aktivieren | false |
| enableAudio | Audio für Bots aktivieren | true |
| enableVideo | Video für Bots aktivieren | true |

### Automatisches Verlassen der Konferenz

Mit der neuen `autoLeaveAfter` Option können Sie festlegen, nach welcher Zeit die Bots automatisch die Konferenz verlassen sollen:

- **Aktivieren**: Setzen Sie `autoLeaveAfter` auf die gewünschte Zeit in Millisekunden
- **Deaktivieren**: Setzen Sie `autoLeaveAfter` auf `0` oder entfernen Sie die Option
- **Beispiele**:
  - `180000` = 3 Minuten
  - `300000` = 5 Minuten
  - `600000` = 10 Minuten

**Funktionsweise:**
1. Jeder Bot startet einen Timer nach dem Beitritt zur Konferenz
2. Nach der konfigurierten Zeit klickt der Bot automatisch auf "Konferenz verlassen"
3. Der Bot bestätigt das Verlassen und schließt seine Browser-Sitzung
4. Robuste Fehlerbehandlung mit Fallback-Mechanismen für verschiedene UI-Zustände

## Verwendung

1. Konfiguriere die `config.json` Datei
2. Starte das Skript:
   ```bash
   npm start
   ```

## Hinweise

- Dieses Tool ist nur für Tests und legitime Zwecke gedacht
- Bitte überlaste keine Dienste mit zu vielen Bots
- Die Selektoren im Code sind für Jitsi Meet optimiert, können aber für andere Plattformen angepasst werden
- Das automatische Verlassen funktioniert nur mit der Standard-Jitsi-Oberfläche

## Fehlersuche

Falls die Bots nicht wie erwartet funktionieren:

1. Überprüfe, ob die Selektoren für deine Konferenzplattform korrekt sind
2. Überprüfe die Browser-Konsole auf Fehler
3. Versuche, die Verzögerungen zwischen den Aktionen (`delayBetweenBots`) zu erhöhen
4. Aktiviere den Debug-Modus (`"debug": true`) für detaillierte Logs
5. Bei Problemen mit dem automatischen Verlassen: Überprüfe die Browser-Konsole auf UI-Änderungen

### Häufige Probleme beim automatischen Verlassen

- **"Button nicht gefunden"**: Die Jitsi-Oberfläche hat sich möglicherweise geändert
- **"Button nicht klickbar"**: Das Modal braucht mehr Zeit zum Laden - erhöhe die Wartezeiten im Code
- **Bots verlassen nicht**: Überprüfe, ob `autoLeaveAfter` korrekt konfiguriert ist und größer als 0