import SwiftUI

struct LaunchScreenView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var isAnimating = false
    let theme: GameTheme = .classic // or pass theme as parameter
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.blue.opacity(0.3), .purple.opacity(0.3)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 20) {
                GameTitleView(theme: theme, colorScheme: colorScheme)
                    .scaleEffect(isAnimating ? 1 : 0.5)
                    .opacity(isAnimating ? 1 : 0)
                
                // Game Logo
                ZStack {
                    // Background shapes
                    ForEach(0..<3) { row in
                        ForEach(0..<3) { column in
                            let index = row * 3 + column
                            let symbols: [String] = ["heart.fill", "star.fill", "circle.fill"]
                            let colors: [Color] = [.red, .yellow, .blue]
                            let offset = CGFloat(30)
                            
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.white.opacity(0.2))
                                .frame(width: 60, height: 60)
                                .overlay(
                                    Image(systemName: symbols[index % 3])
                                        .font(.system(size: 30))
                                        .foregroundColor(colors[index % 3])
                                )
                                .offset(
                                    x: CGFloat(column) * offset - offset,
                                    y: CGFloat(row) * offset - offset
                                )
                                .rotationEffect(.degrees(isAnimating ? 360 : 0))
                                .animation(
                                    .spring(response: 0.5, dampingFraction: 0.5)
                                    .delay(Double(index) * 0.1)
                                    .repeatForever(autoreverses: true),
                                    value: isAnimating
                                )
                        }
                    }
                }
                .frame(width: 200, height: 200)
                
                // Loading indicator
                HStack(spacing: 15) {
                    ForEach(0..<3) { index in
                        Circle()
                            .fill(
                                LinearGradient(
                                    colors: [.blue, .purple],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 15, height: 15)
                            .scaleEffect(isAnimating ? 1.2 : 0.8)
                            .animation(
                                .spring(response: 0.5, dampingFraction: 0.5)
                                .repeatForever(autoreverses: true)
                                .delay(Double(index) * 0.2),
                                value: isAnimating
                            )
                    }
                }
            }
        }
        .onAppear {
            isAnimating = true
        }
    }
}

#Preview {
    LaunchScreenView()
} 