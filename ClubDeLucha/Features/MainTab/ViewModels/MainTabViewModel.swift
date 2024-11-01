//
//  MainTabViewModel.swift
//  ClubDeLucha
//
//  Created by Jose on 28/10/2024.
//  Copyright © 2024 Jose Catala. All rights reserved.
//

import Foundation
import Combine

@MainActor
final class MainTabViewModel: ObservableObject {
    @Published var showNotifications = false
}
