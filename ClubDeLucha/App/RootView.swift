//
//  RootView.swift
//  ClubDeLucha
//
//  Created by Jose on 28/10/2024.
//  Copyright © 2024 Jose Catala. All rights reserved.
//

import SwiftUI

struct RootView: View {
    @StateObject private var coordinator = AppCoordinator()
    
    var body: some View {
        Group {
            switch coordinator.authenticationState {
            case .notAuthenticated:
                PhoneLoginView(viewModel: PhoneLoginViewModel(authService: DependencyContainer.shared.makeAuthService()))
            case .authenticated:
                MainTabView(viewModel: MainTabViewModel())
            }
        }
        .environmentObject(coordinator)
    }
}

#Preview {
    RootView()
}
