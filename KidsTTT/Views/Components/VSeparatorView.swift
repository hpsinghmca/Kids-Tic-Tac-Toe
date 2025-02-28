//
//  VSeparatorView.swift
//  KidsTTT
//
//  Created by Harpreet Singh on 2/27/25
//

import SwiftUI

struct VSeparatorView: View {
    let theme: GameTheme
    let colorScheme: ColorScheme
    
    var body: some View {
        Text(StringConstants.versus)
            .font(.custom(StringConstants.defaultFont, size: 20))
            .foregroundStyle(
                LinearGradient(
                    colors: theme.colors.player1,
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .padding(.horizontal, 10)
            .frame(minWidth: 50)
            .background(
                colorScheme == .dark ? 
                Color.black.opacity(0.3) : 
                    Color.white.opacity(0.7)
            )
            .clipShape(Capsule())
            .shadow(radius: 2)
    }
}
