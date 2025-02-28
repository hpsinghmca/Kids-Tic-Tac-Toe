import SwiftUI

struct GameView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    @StateObject private var gameState: GameState
    let theme: GameTheme
    
    init(player1: Player, player2: Player, theme: GameTheme) {
        self.theme = theme
        _gameState = StateObject(wrappedValue: GameState(player1: player1, player2: player2))
    }
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                colors: colorScheme == .dark 
                ? theme.colors.background.map { $0.opacity(0.2) }
                : theme.colors.background,
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ).ignoresSafeArea()
            
            GeometryReader { geometry in
                let screenWidth = UIScreen.main.bounds.width
                let screenHeight = UIScreen.main.bounds.height
                let isLandscape = screenWidth > screenHeight
                let safeArea = geometry.safeAreaInsets
                let availableHeight = geometry.size.height - safeArea.top - safeArea.bottom
                let availableWidth = geometry.size.width - safeArea.leading - safeArea.trailing
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        HStack {
                            BackButtonView(
                                theme: theme,
                                colorScheme: colorScheme,
                                action: { dismiss() }
                            )
                            Spacer()
                        }
                        .padding(.horizontal)
                        .padding(.top, safeArea.top + 8)
                        
                        if isLandscape {
                            // Landscape layout
                            HStack(alignment: .center, spacing: 20) {
                                // Left side - Player info and controls
                                VStack(spacing: 20) {
                                    PlayerTurnIndicatorView(
                                        player1: gameState.player1,
                                        player2: gameState.player2,
                                        player1Score: gameState.player1Score,
                                        player2Score: gameState.player2Score,
                                        currentPlayer: gameState.currentPlayer,
                                        theme: theme,
                                        colorScheme: colorScheme,
                                        remainingChances: gameState.remainingChances,
                                        isLandscape: isLandscape
                                    )
                                    .frame(maxWidth: availableWidth * 0.3)
                                    .frame(height: availableHeight * 0.6)
                                    
                                    PlayAgainButtonView(
                                        theme: theme,
                                        action: gameState.resetGame
                                    )
                                    .frame(maxWidth: availableWidth * 0.3)
                                }
                                .padding(.vertical)
                                
                                Spacer()
                                
                                // Right side - Game board
                                GameBoardView(
                                    board: gameState.board,
                                    currentPlayer: gameState.currentPlayer,
                                    makeMove: gameState.makeMove
                                )
                                .frame(
                                    width: min(availableHeight * 0.8, availableWidth * 0.5),
                                    height: min(availableHeight * 0.8, availableWidth * 0.5)
                                )
                                .padding(.trailing)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal)
                        } else {
                            // Updated Portrait layout
                            VStack(spacing: 20) {
                                PlayerTurnIndicatorView(
                                    player1: gameState.player1,
                                    player2: gameState.player2,
                                    player1Score: gameState.player1Score,
                                    player2Score: gameState.player2Score,
                                    currentPlayer: gameState.currentPlayer,
                                    theme: theme,
                                    colorScheme: colorScheme,
                                    remainingChances: gameState.remainingChances,
                                    isLandscape: isLandscape
                                )
                                .frame(height: min(availableHeight * 0.3, 180))
                                .padding(.top, 20)
                                
                                GameBoardView(
                                    board: gameState.board,
                                    currentPlayer: gameState.currentPlayer,
                                    makeMove: gameState.makeMove
                                )
                                .frame(
                                    width: min(availableWidth * 0.9, availableHeight * 0.45),
                                    height: min(availableWidth * 0.9, availableHeight * 0.45)
                                )
                                .padding(.vertical, 10)
                                
                                PlayAgainButtonView(
                                    theme: theme,
                                    action: gameState.resetGame
                                )
                                .frame(maxWidth: availableWidth * 0.8)
                                .padding(.bottom, 20)
                            }
                            .frame(minHeight: availableHeight)
                            .padding(.horizontal)
                        }
                    }
                }
            }
        }
        .alert(StringConstants.gameOver, isPresented: $gameState.showWinner) {
            Button(StringConstants.playAgain, action: gameState.resetGame)
        } message: {
            Text(gameState.winner != nil ? 
                 "\(gameState.winner?.name ?? "") \(StringConstants.wins)" : 
                 StringConstants.draw
            )
            .font(.custom(StringConstants.defaultFont, size: 20))
        }
        .alert(StringConstants.champion, isPresented: $gameState.showChampionAlert) {
            Button(StringConstants.newGame, action: gameState.resetGame)
                .font(.custom(StringConstants.defaultFont, size: 20))
        } message: {
            VStack(spacing: 10) {
                Text("\(StringConstants.congratulations) \(gameState.champion?.name ?? "")🎊")
                    .font(.custom(StringConstants.defaultFont, size: 24))
                Text("\(gameState.champion?.name ?? "") \(StringConstants.isChampion)")
                    .font(.custom(StringConstants.defaultFont, size: 20))
                Text("\(StringConstants.withWins) \(gameState.winningStreak) \(StringConstants.winsCount)")
                    .font(.custom(StringConstants.defaultFont, size: 18))
            }
        }
        .animation(.spring(response: 0.3), value: gameState.showChampionAlert)
        .navigationBarHidden(true)
    }
}

#Preview {
    GameView(
        player1: Player(name: "Player 1", symbol: .heart),
        player2: Player(name: "Player 2", symbol: .star),
        theme: .classic
    )
} 
