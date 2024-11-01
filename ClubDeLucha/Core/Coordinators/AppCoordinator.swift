//
//  AppCoordinator.swift
//  ClubDeLucha
//
//  Created by Jose on 28/10/2024.
//  Copyright © 2024 Jose Catala. All rights reserved.
//

import SwiftUI

final class AppCoordinator: ObservableObject {
    @Published var path = NavigationPath()
    @Published var authenticationState: AuthenticationState = .notAuthenticated
    
    enum AuthenticationState {
        case notAuthenticated
        case authenticated
    }
    
    enum Route: Hashable {
        case login
        case tabBar
        case fightDetails(String)
        case clubDetails(String)
        case editProfile
        case settings
        case myFights
        case myClubs
    }
}


