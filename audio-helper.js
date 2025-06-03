// audio-helper.js
// Diese Datei im selben Verzeichnis wie index.js speichern

function createFakeAudioStream() {
    return `
    // Funktion zum Erstellen eines virtuellen Audio-Streams
    (() => {
      // Original getUserMedia speichern
      const originalGetUserMedia = navigator.mediaDevices.getUserMedia;
      
      // getUserMedia überschreiben
      navigator.mediaDevices.getUserMedia = async function(constraints) {
        // Wenn keine Audio angefordert wird, original Funktion aufrufen
        if (!constraints || !constraints.audio) {
          return originalGetUserMedia.call(navigator.mediaDevices, constraints);
        }
        
        try {
          // Erstelle einen Oszillator zur Tonerzeugung
          const ctx = new AudioContext();
          const oscillator = ctx.createOscillator();
          oscillator.type = 'sine';
          oscillator.frequency.setValueAtTime(440, ctx.currentTime); // A4 note
          
          const dest = ctx.createMediaStreamDestination();
          oscillator.connect(dest);
          oscillator.start();
          
          // Kombiniere mit Video, falls angefordert
          if (constraints.video) {
            const videoStream = await originalGetUserMedia.call(
              navigator.mediaDevices, 
              {video: constraints.video}
            );
            
            // Kombiniere Audio- und Video-Tracks
            const combinedStream = new MediaStream();
            dest.stream.getAudioTracks().forEach(track => combinedStream.addTrack(track));
            videoStream.getVideoTracks().forEach(track => combinedStream.addTrack(track));
            
            return combinedStream;
          }
          
          return dest.stream;
        } catch (e) {
          console.error('Fehler bei der Erstellung des virtuellen Audio-Streams:', e);
          // Im Fehlerfall die Original-Implementierung aufrufen
          return originalGetUserMedia.call(navigator.mediaDevices, constraints);
        }
      };
      
      console.log('Virtuelle Audioeinspeisung aktiviert');
    })();
    `;
  }
  
  module.exports = { createFakeAudioStream };