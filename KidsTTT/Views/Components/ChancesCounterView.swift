//
//  ChancesCounterView.swift
//  KidsTTT
//
//  Created by Harpreet Singh on 2/27/25
//

import SwiftUI

struct ChancesCounterView: View {
    let remainingChances: Int
    let theme: GameTheme
    let colorScheme: ColorScheme
    
    var body: some View {
        Text("\(StringConstants.chancesRemaining)\(remainingChances)")
            .font(.custom(StringConstants.defaultFont, size: 24))
            .foregroundStyle(
                LinearGradient(
                    colors: [theme.colors.player1[0], theme.colors.player2[0]],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .padding(.horizontal, 15)
            .padding(.vertical, 8)
            .background(
                Capsule()
                    .fill(colorScheme == .dark ? Color.black.opacity(0.3) : Color.white.opacity(0.7))
                    .shadow(radius: 3)
            )
            .overlay(
                Capsule()
                    .stroke(
                        LinearGradient(
                            colors: [theme.colors.player1[0], theme.colors.player2[0]],
                            startPoint: .leading,
                            endPoint: .trailing
                        ),
                        lineWidth: 2
                    )
            )
            .scaleEffect(remainingChances <= 3 ? 1.1 : 1.0)
            .animation(.spring(response: 0.3), value: remainingChances)
    }
} 