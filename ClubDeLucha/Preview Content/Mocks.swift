//
//  Mocks.swift
//  ClubDeLucha
//
//  Created by Jose on 29/10/2024.
//  Copyright © 2024 Jose Catala. All rights reserved.
//

import Foundation
import SwiftUI
import CoreData
import Combine

// MARK: - Mocks
struct MockData {
    static let training = Training(
        id: "1",
        title: "Gi Training",
        trainer: "John Doe",
        location: "Main Gym",
        startTime: Date(),
        endTime: Date().addingTimeInterval(3600),
        type: .gi
    )
    
    static let fight = Fight(
        id: "1",
        title: "Championship Fight",
        date: Date(),
        location: "Arena"
    )
    
    static let qrCode = QRCode(
        id: "1",
        url: "https://example.com",
        expiresAt: Date().addingTimeInterval(300)
    )
    
    static let notification = Notification(
        id: "1",
        title: "Test Notification",
        message: "Test Message",
        date: Date(),
        type: .training,
        isRead: false
    )
}

// MARK: - Mock Services
class PreviewQRCodeService: QRCodeServiceProtocol {
    func fetchQRCode() async throws -> QRCode {
        return MockData.qrCode
    }
}

class PreviewAuthService: AuthServiceProtocol {
    func login(phoneNumber: String) -> AnyPublisher<Void, Error> {
        Just(())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

// MARK: - Environment Setup
extension View {
    func withTestDependencies() -> some View {
        let coordinator = AppCoordinator()
        let context = PersistenceController.preview.container.viewContext
        
        return self
            .environmentObject(coordinator)
            .environment(\.managedObjectContext, context)
            .previewLayout(.sizeThatFits)
            .previewDisplayName("Default Preview")
    }
    
    func previewWithNavigation() -> some View {
        NavigationStack {
            self
        }
        .previewLayout(.sizeThatFits)
        .previewDisplayName("Navigation Preview")
    }
    
    func previewWithTab() -> some View {
        TabView {
            self
                .tabItem {
                    Label("Preview", systemImage: "star")
                }
        }
        .previewLayout(.sizeThatFits)
        .previewDisplayName("Tab Preview")
    }
}

// Add these preview providers to each view:

// HomeView.swift
#Preview("Home") {
    HomeView()
        .withTestDependencies()
}

// NotificationsView.swift
#Preview("Notifications") {
    NotificationsView()
        .withTestDependencies()
        .previewWithNavigation()
}

// ScheduleView.swift
#Preview("Schedule") {
    ScheduleView()
        .withTestDependencies()
        .previewWithNavigation()
}

// ProfileView.swift
#Preview("Profile") {
    ProfileView()
        .withTestDependencies()
        .previewWithNavigation()
}
