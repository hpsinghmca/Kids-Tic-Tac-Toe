import SwiftUI

struct GameBoardView: View {
    @Environment(\.colorScheme) var colorScheme
    let board: [String]
    let currentPlayer: Player
    let makeMove: (Int) -> Void
    
    var body: some View {
        VStack(spacing: 8) {
            ForEach(0..<3) { row in
                HStack(spacing: 8) {
                    ForEach(0..<3) { column in
                        let index = row * 3 + column
                        CellView(
                            symbol: board[index],
                            action: { makeMove(index) },
                            currentPlayer: currentPlayer
                        )
                    }
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(colorScheme == .dark ? Color.black.opacity(0.3) : Color.white.opacity(0.7))
                .shadow(radius: 10)
        )
        .aspectRatio(1, contentMode: .fit)
    }
}
