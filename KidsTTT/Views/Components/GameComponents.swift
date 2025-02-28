import SwiftUI

// Cell View Component
struct CellView: View {
    @Environment(\.colorScheme) var colorScheme
    let symbol: String
    let action: () -> Void
    let currentPlayer: Player
    
    var body: some View {
        Button(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(colorScheme == .dark ? Color.black.opacity(0.3) : Color.white)
                    .shadow(radius: 3)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(
                                LinearGradient(
                                    colors: symbol.isEmpty ? [.blue.opacity(0.3), .purple.opacity(0.3)] : [],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 2
                            )
                    )
                
                if !symbol.isEmpty {
                    Image(systemName: symbol)
                        .font(.system(size: 45))
                        .foregroundColor(GameSymbol(rawValue: symbol)?.color ?? .gray)
                        .shadow(color: GameSymbol(rawValue: symbol)?.color.opacity(0.3) ?? .clear, radius: 5)
                }
            }
        }
        .frame(height: 100)
        .disabled(!symbol.isEmpty)
    }
} 