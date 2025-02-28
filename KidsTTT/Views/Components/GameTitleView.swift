//
//  GameTitleView.swift
//  KidsTTT
//
//  Created by Harpreet Singh on 2/27/25
//

import SwiftUI

struct GameTitleView: View {
    let theme: GameTheme
    let colorScheme: ColorScheme
    
    var body: some View {
        Text(StringConstants.gameTitle)
            .font(.custom(StringConstants.defaultFont, size: 40))
            .foregroundStyle(
                LinearGradient(
                    colors: theme.colors.player1.map { 
                        colorScheme == .dark ? 
                        $0.opacity(0.9) : // Darker in dark mode
                        $0.opacity(0.7)    // Darker in light mode
                    },
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .shadow(
                color: theme.colors.player1[0].opacity(0.5),
                radius: 5,
                x: 0,
                y: 2
            )
            .padding(.vertical)
    }
} 
