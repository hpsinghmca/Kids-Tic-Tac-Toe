//
//  BackButtonView.swift
//  KidsTTT
//
//  Created by Harpreet Singh on 2/27/25
//

import SwiftUI

struct BackButtonView: View {
    let theme: GameTheme
    let colorScheme: ColorScheme
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 20, weight: .bold))
                Text(StringConstants.backButton)
                    .font(.custom(StringConstants.defaultFont, size: 18))
            }
            .foregroundStyle(
                LinearGradient(
                    colors: theme.colors.player1,
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(
                Capsule()
                    .fill(colorScheme == .dark ? Color.black.opacity(0.3) : Color.white)
                    .shadow(color: .blue.opacity(0.3), radius: 5)
            )
        }
    }
} 