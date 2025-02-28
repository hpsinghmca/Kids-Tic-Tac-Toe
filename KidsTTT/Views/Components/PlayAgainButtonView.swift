//
//  PlayAgainButtonView.swift
//  KidsTTT
//
//  Created by Harpreet Singh on 2/27/25
//

import SwiftUI

struct PlayAgainButtonView: View {
    let theme: GameTheme
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(StringConstants.resetGame)
                .font(.custom(StringConstants.defaultFont, size: 20))
                .bold()
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    LinearGradient(
                        colors: theme.colors.player1,
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .cornerRadius(25)
                .shadow(radius: 5)
        }
    }
} 