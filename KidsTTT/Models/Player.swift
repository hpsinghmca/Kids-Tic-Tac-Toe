import SwiftUI

struct Player: Equatable {
    var name: String
    var symbol: GameSymbol
    var score: Int = 0
}

enum GameSymbol: String, CaseIterable {
    case heart = "heart.fill"
    case star = "star.fill"
    case circle = "circle.fill"
    case square = "square.fill"
    case diamond = "diamond.fill"
    case cloud = "cloud.fill"
    
    var color: Color {
        switch self {
        case .heart: return .red
        case .star: return .yellow
        case .circle: return .blue
        case .square: return .green
        case .diamond: return .purple
        case .cloud: return .cyan
        }
    }
} 