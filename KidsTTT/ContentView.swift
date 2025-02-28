//
//  ContentView.swift
//  KidsTTT
//
//  Created by Harpreet Singh on 2/27/25.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowingLaunchScreen = true
    
    var body: some View {
        ZStack {
            if isShowingLaunchScreen {
                LaunchScreenView()
                    .transition(.opacity)
            } else {
                PlayerSetupView()
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.5), value: isShowingLaunchScreen)
        .onAppear {
            // Show launch screen for 2 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                isShowingLaunchScreen = false
            }
        }
    }
}

#Preview {
    ContentView()
}
