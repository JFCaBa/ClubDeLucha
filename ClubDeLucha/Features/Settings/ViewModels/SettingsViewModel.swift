//
//  SettingsViewModel.swift
//  ClubDeLucha
//
//  Created by Jose on 29/10/2024.
//  Copyright © 2024 Jose Catala. All rights reserved.
//

import Combine
import SwiftUI

@MainActor
final class SettingsViewModel: ObservableObject {
    @Published var notificationsEnabled = true
    @AppStorage("notifications_enabled") private var storedNotificationsEnabled = true
    
    private let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
    private let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"
    
    var versionText: String {
        "Version \(appVersion) (\(buildNumber))"
    }
    
    init() {
        notificationsEnabled = storedNotificationsEnabled
    }
    
    func toggleNotifications() {
        storedNotificationsEnabled = notificationsEnabled
        // Handle notification permission
    }
}
