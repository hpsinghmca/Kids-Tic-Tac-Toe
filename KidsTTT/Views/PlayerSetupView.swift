import SwiftUI

struct PlayerSetupView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var player1 = Player(name: "", symbol: .heart)
    @State private var player2 = Player(name: "", symbol: .star)
    @State private var selectedTheme: GameTheme = .classic
    @State private var isGameStarted = false
    
    private var gradientColors: (player1: [Color], player2: [Color]) {
        return (
            player1: selectedTheme.colors.player1,
            player2: selectedTheme.colors.player2
        )
    }
    
    private var backgroundGradient: LinearGradient {
        LinearGradient(
            colors: selectedTheme.colors.background,
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    private var darkBackgroundGradient: LinearGradient {
        LinearGradient(
            colors: selectedTheme.colors.background.map { $0.opacity(0.2) },
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    var availableSymbols: [GameSymbol] {
        GameSymbol.allCases.filter { $0 != player2.symbol }
    }
    
    var availableSymbolsPlayer2: [GameSymbol] {
        GameSymbol.allCases.filter { $0 != player1.symbol }
    }
    
    var canStartGame: Bool {
        !player1.name.isEmpty && !player2.name.isEmpty
    }
    
    private func resetForm() {
        player1 = Player(name: "", symbol: .heart)
        player2 = Player(name: "", symbol: .star)
        selectedTheme = .classic
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                (colorScheme == .dark ? darkBackgroundGradient : backgroundGradient)
                    .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 30) {
                        HStack {
                            Spacer()
                            Button(action: resetForm) {
                                HStack(spacing: 8) {
                                    Image(systemName: "arrow.counterclockwise")
                                        .font(.system(size: 14, weight: .bold))
                                    Text("Reset")
                                        .font(.custom("Arial Rounded MT Bold", size: 16))
                                }
                                .foregroundStyle(
                                    LinearGradient(
                                        colors: selectedTheme.colors.player1,
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(
                                    Capsule()
                                        .fill(colorScheme == .dark ? Color.black.opacity(0.3) : Color.white)
                                        .shadow(color: selectedTheme.colors.player1[0].opacity(0.3), radius: 5)
                                )
                            }
                            .padding(.horizontal)
                        }
                        
                        Text("Tic Tac Toe")
                            .font(.custom("Arial Rounded MT Bold", size: 45))
                            .foregroundStyle(
                                LinearGradient(
                                    colors: selectedTheme.colors.background.map {
                                        colorScheme == .dark ?
                                        $0.opacity(1.0) :    // Almost solid in dark mode
                                        $0.opacity(1.0)      // Much darker in light mode
                                    },
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .shadow(
                                color: selectedTheme.colors.background[0].opacity(0.7), // Stronger shadow
                                radius: 4,
                                x: 0,
                                y: 2
                            )
                        
                        // Theme Selection
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Select Theme")
                                .font(.custom("Arial Rounded MT Bold", size: 20))
                                .foregroundStyle(
                                    LinearGradient(
                                        colors: selectedTheme.colors.player1,
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                            
                            HStack(spacing: 15) {
                                ForEach(GameTheme.allCases, id: \.self) { theme in
                                    ThemeButton(
                                        theme: theme,
                                        isSelected: selectedTheme == theme,
                                        colors: theme.colors.player1
                                    ) {
                                        withAnimation(.spring(response: 0.3)) {
                                            selectedTheme = theme
                                        }
                                    }
                                }
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(colorScheme == .dark ? Color.black.opacity(0.3) : Color.white)
                                .shadow(radius: 5)
                        )
                        
                        PlayerSetupCard(
                            playerNumber: 1,
                            player: $player1,
                            availableSymbols: availableSymbols,
                            gradientColors: selectedTheme.colors.player1
                        )
                        
                        PlayerSetupCard(
                            playerNumber: 2,
                            player: $player2,
                            availableSymbols: availableSymbolsPlayer2,
                            gradientColors: selectedTheme.colors.player2
                        )
                        
                        startGameButton
                    }
                    .padding(.horizontal)
                }
            }
            .navigationDestination(isPresented: $isGameStarted) {
                GameView(
                    player1: player1,
                    player2: player2,
                    theme: selectedTheme
                )
            }
        }
    }
    
    // Extract button view to improve readability and reduce recomputation
    private var startGameButton: some View {
        Button(action: { isGameStarted = true }) {
            Text("Start Game")
                .font(.custom("Arial Rounded MT Bold", size: 20))
                .bold()
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    LinearGradient(
                        colors: canStartGame ? [.blue, .purple] : [.gray.opacity(0.5)],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .cornerRadius(25)
                .shadow(radius: 5)
        }
        .disabled(!canStartGame)
        .padding(.horizontal)
        .padding(.bottom, 20)
    }
}

struct PlayerSetupCard: View {
    @Environment(\.colorScheme) var colorScheme
    let playerNumber: Int
    @Binding var player: Player
    let availableSymbols: [GameSymbol]
    let gradientColors: [Color]
    
    var body: some View {
        VStack(spacing: 15) {
            Text("Player \(playerNumber)")
                .font(.custom("Arial Rounded MT Bold", size: 24))
                .foregroundStyle(
                    LinearGradient(
                        colors: gradientColors,
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
            
            // Custom styled TextField
            TextField("", text: $player.name)
                .placeholder(when: player.name.isEmpty) {
                    Text("Enter Name")
                        .foregroundColor(gradientColors[0].opacity(0.5))
                }
                .font(.custom("Arial Rounded MT Bold", size: 18))
                .foregroundColor(gradientColors[0])
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.white.opacity(0.1))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(
                            LinearGradient(
                                colors: gradientColors,
                                startPoint: .leading,
                                endPoint: .trailing
                            ),
                            lineWidth: 2
                        )
                )
                .textInputAutocapitalization(.words)
            
            VStack(alignment: .leading) {
                Text("Choose your symbol:")
                    .font(.custom("Arial Rounded MT Bold", size: 20))
                    .foregroundColor(gradientColors[0])
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 15) {
                    ForEach(availableSymbols, id: \.self) { symbol in
                        SymbolButton(
                            symbol: symbol,
                            isSelected: player.symbol == symbol,
                            action: { player.symbol = symbol }
                        )
                        .scaleEffect(player.symbol == symbol ? 1.1 : 1.0)
                        .animation(.spring(response: 0.3), value: player.symbol == symbol)
                    }
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(UIColor.systemBackground))
                .shadow(radius: 5)
        )
    }
}

struct SymbolButton: View {
    let symbol: GameSymbol
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: symbol.rawValue)
                .font(.system(size: 35))
                .foregroundColor(symbol.color)
                .padding()
                .background(
                    Circle()
                        .fill(isSelected ? symbol.color.opacity(0.2) : Color.clear)
                )
                .overlay(
                    Circle()
                        .stroke(isSelected ? symbol.color : Color.clear, lineWidth: 3)
                )
                .shadow(color: isSelected ? symbol.color.opacity(0.5) : .clear, radius: 5)
        }
    }
}

struct ThemeButton: View {
    let theme: GameTheme
    let isSelected: Bool
    let colors: [Color]
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                Image(systemName: theme.icon)
                    .font(.system(size: 24))
                Text(theme.rawValue)
                    .font(.custom(StringConstants.defaultFont, size: 14))
            }
            .foregroundStyle(
                LinearGradient(
                    colors: colors,
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(isSelected ? colors[0].opacity(0.2) : Color.clear)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(isSelected ? colors[0] : Color.clear, lineWidth: 2)
            )
        }
        .scaleEffect(isSelected ? 1.1 : 1.0)
        .animation(.spring(response: 0.3), value: isSelected)
    }
}

// Add this extension to support custom placeholder
extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content
    ) -> some View {
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
