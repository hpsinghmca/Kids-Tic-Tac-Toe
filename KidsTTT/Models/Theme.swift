import SwiftUI

enum GameTheme: String, CaseIterable {
    case classic = "Classic"
    case princess = "Princess"
    case superhero = "Superhero"
    case space = "Space"
    
    var colors: (background: [Color], player1: [Color], player2: [Color]) {
        switch self {
        case .classic:
            return (
                background: [.blue.opacity(0.3), .purple.opacity(0.3)],
                player1: [.blue, .cyan],
                player2: [.purple, .pink]
            )
        case .princess:
            return (
                background: [.pink.opacity(0.3), .purple.opacity(0.3)],
                player1: [.pink, .purple],
                player2: [.purple, .orange]
            )
        case .superhero:
            return (
                background: [.red.opacity(0.3), .blue.opacity(0.3)],
                player1: [.red, .orange],
                player2: [.blue, .cyan]
            )
        case .space:
            return (
                background: [.indigo.opacity(0.3), .purple.opacity(0.3)],
                player1: [.indigo, .cyan],
                player2: [.purple, .mint]
            )
        }
    }
    
    var icon: String {
        switch self {
        case .classic: return "sparkles"
        case .princess: return "crown.fill"
        case .superhero: return "bolt.fill"
        case .space: return "star.fill"
        }
    }
}
