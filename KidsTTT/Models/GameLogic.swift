import Foundation

struct GameLogic {
    static func checkWinner(board: [String], currentPlayer: Player) -> Bool {
        let winPatterns = [
            [0, 1, 2], [3, 4, 5], [6, 7, 8], // Rows
            [0, 3, 6], [1, 4, 7], [2, 5, 8], // Columns
            [0, 4, 8], [2, 4, 6]             // Diagonals
        ]
        
        return winPatterns.contains { pattern in
            pattern.map { board[$0] }.allSatisfy { $0 == currentPlayer.symbol.rawValue }
        }
    }
    
    static func checkDraw(board: [String]) -> Bool {
        return board.allSatisfy { !$0.isEmpty }
    }
    
    static func handleScore(for player: Player,
                            currentScore: Int,
                            winningStreak: Int) -> (isChampion: Bool, newScore: Int) {
        let newScore = currentScore + 1
        return (newScore == winningStreak, newScore)
    }
    
    static func createEmptyBoard() -> [String] {
        return Array(repeating: StringConstants.emptyCell, count: 9)
    }
}
