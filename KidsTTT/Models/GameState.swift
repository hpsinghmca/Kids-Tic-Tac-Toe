import Foundation

class GameState: ObservableObject {
    @Published var board: [String]
    @Published var currentPlayer: Player
    @Published var winner: Player?
    @Published var isDraw: Bool
    @Published var player1Score: Int
    @Published var player2Score: Int
    @Published var showWinner: Bool
    @Published var showChampionAlert: Bool
    @Published var champion: Player?
    
    let player1: Player
    let player2: Player
    let winningStreak: Int
    
    init(player1: Player, player2: Player, winningStreak: Int = 10) {
        self.player1 = player1
        self.player2 = player2
        self.winningStreak = winningStreak
        self.board = GameLogic.createEmptyBoard()
        self.currentPlayer = player1
        self.winner = nil
        self.isDraw = false
        self.player1Score = 0
        self.player2Score = 0
        self.showWinner = false
        self.showChampionAlert = false
        self.champion = nil
    }
    
    var remainingChances: Int {
        winningStreak - max(player1Score, player2Score)
    }
    
    func makeMove(at index: Int) {
        guard board[index].isEmpty else { return }
        
        board[index] = currentPlayer.symbol.rawValue
        
        if GameLogic.checkWinner(board: board, currentPlayer: currentPlayer) {
            handleWinner()
        } else if GameLogic.checkDraw(board: board) {
            handleDraw()
        } else {
            switchPlayer()
        }
    }
    
    private func handleWinner() {
        winner = currentPlayer
        let (isChampion, newScore) = GameLogic.handleScore(
            for: currentPlayer,
            currentScore: currentPlayer == player1 ? player1Score : player2Score,
            winningStreak: winningStreak
        )
        
        if currentPlayer == player1 {
            player1Score = newScore
        } else {
            player2Score = newScore
        }
        
        if isChampion {
            handleChampion()
        } else {
            showWinner = true
        }
        
        SoundManager.shared.playWinSound()
    }
    
    private func handleChampion() {
        showWinner = false
        champion = currentPlayer
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.showChampionAlert = true
        }
    }
    
    private func handleDraw() {
        isDraw = true
        showWinner = true
    }
    
    private func switchPlayer() {
        currentPlayer = currentPlayer == player1 ? player2 : player1
    }
    
    func resetGame() {
        board = GameLogic.createEmptyBoard()
        currentPlayer = winner ?? currentPlayer
        winner = nil
        isDraw = false
        
        if showChampionAlert {
            player1Score = 0
            player2Score = 0
            champion = nil
            showChampionAlert = false
        }
    }
} 