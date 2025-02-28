//
//  PlayerTurnIndicatorView.swift
//  KidsTTT
//
//  Created by Harpreet Singh on 2/27/25
//

import SwiftUI

struct PlayerTurnIndicatorView: View {
    let player1: Player
    let player2: Player
    let player1Score: Int
    let player2Score: Int
    let currentPlayer: Player
    let theme: GameTheme
    let colorScheme: ColorScheme
    let remainingChances: Int
    let isLandscape: Bool
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            
            if isLandscape {
                VStack(spacing: height * 0.05) {
                    HStack(spacing: 20) {
                        Spacer()
                        PlayerScoreView(
                            player: player1,
                            score: player1Score,
                            isCurrentPlayer: currentPlayer == player1,
                            gradientColors: theme.colors.player1,
                            colorScheme: colorScheme
                        )
                        .frame(minWidth: width * 0.35, maxWidth: width * 0.65)
                        .frame(maxHeight: height * 0.7)
                        .fixedSize(horizontal: true, vertical: false)
                        
                        PlayerScoreView(
                            player: player2,
                            score: player2Score,
                            isCurrentPlayer: currentPlayer == player2,
                            gradientColors: theme.colors.player2,
                            colorScheme: colorScheme
                        )
                        .frame(minWidth: width * 0.35, maxWidth: width * 0.65)
                        .frame(maxHeight: height * 0.7)
                        .fixedSize(horizontal: true, vertical: false)
                        Spacer()
                    }
                    .padding(.top, height * 0.05)
                    
                    Spacer()
                    
                    ChancesCounterView(
                        remainingChances: remainingChances,
                        theme: theme,
                        colorScheme: colorScheme
                    )
                    .padding(.bottom, height * 0.05)
                }
            } else {
                VStack(spacing: height * 0.05) {
                    HStack {
                        Spacer()
                        HStack(spacing: 20) {
                            PlayerScoreView(
                                player: player1,
                                score: player1Score,
                                isCurrentPlayer: currentPlayer == player1,
                                gradientColors: theme.colors.player1,
                                colorScheme: colorScheme
                            )
                            .frame(width: width * 0.35)
                            .frame(maxHeight: height * 0.6)
                            
                            PlayerScoreView(
                                player: player2,
                                score: player2Score,
                                isCurrentPlayer: currentPlayer == player2,
                                gradientColors: theme.colors.player2,
                                colorScheme: colorScheme
                            )
                            .frame(width: width * 0.35)
                            .frame(maxHeight: height * 0.6)
                        }
                        Spacer()
                    }
                    
                    Spacer()
                    
                    ChancesCounterView(
                        remainingChances: remainingChances,
                        theme: theme,
                        colorScheme: colorScheme
                    )
                    .padding(.bottom, height * 0.05)
                }
            }
        }
    }
}
