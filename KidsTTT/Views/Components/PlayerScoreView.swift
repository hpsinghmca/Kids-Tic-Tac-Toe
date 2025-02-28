//
//  PlayerScoreView.swift
//  KidsTTT
//
//  Created by Harpreet Singh on 2/27/25
//

import SwiftUI

struct PlayerScoreView: View {
    let player: Player
    let score: Int
    let isCurrentPlayer: Bool
    let gradientColors: [Color]
    let colorScheme: ColorScheme
    
    var body: some View {
        VStack(spacing: 8) {
            Text(player.name)
                .font(.custom(StringConstants.defaultFont, size: 20))
                .foregroundStyle(
                    LinearGradient(
                        colors: gradientColors,
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
            Image(systemName: player.symbol.rawValue)
                .font(.system(size: 30))
                .foregroundColor(player.symbol.color)
            Text("\(StringConstants.score)\(score)")
                .font(.custom(StringConstants.defaultFont, size: 18))
                .foregroundStyle(
                    LinearGradient(
                        colors: gradientColors,
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(colorScheme == .dark ? Color.black.opacity(0.3) : Color.white)
                .shadow(
                    color: isCurrentPlayer ? gradientColors[0].opacity(0.5) : .clear,
                    radius: 10,
                    x: 0,
                    y: isCurrentPlayer ? 5 : 0
                )
        )
        .scaleEffect(isCurrentPlayer ? 1.05 : 1.0)
        .animation(.spring(response: 0.3), value: isCurrentPlayer)
    }
} 