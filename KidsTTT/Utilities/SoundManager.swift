import AVFoundation

class SoundManager {
    static let shared = SoundManager()
    private var audioPlayer: AVAudioPlayer?
    
    private init() {
        setupAudio()
    }
    
    private func setupAudio() {
        // Debug: Print all resources in bundle
        if let resourcePath = Bundle.main.resourcePath {
            let files = try? FileManager.default.contentsOfDirectory(atPath: resourcePath)
            print("Bundle contents: \(files ?? [])")
        }
        
        // Try loading the sound file from the bundle
        if let soundURL = Bundle.main.url(forResource: "win", withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.prepareToPlay()
                // Test play to verify sound works
                audioPlayer?.play()
                audioPlayer?.stop()
                print("Sound file loaded successfully")
            } catch {
                print("Failed to create audio player: \(error.localizedDescription)")
            }
        } else {
            print("Could not find win.mp3 in bundle")
        }
    }
    
    func playWinSound() {
        guard let player = audioPlayer else {
            print("Audio player not initialized")
            return
        }
        
        if player.isPlaying {
            player.stop()
        }
        player.currentTime = 0
        player.play()
    }
}

