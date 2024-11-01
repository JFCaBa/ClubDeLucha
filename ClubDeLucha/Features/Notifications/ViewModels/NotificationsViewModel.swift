//
//  NotificationsViewModel.swift
//  ClubDeLucha
//
//  Created by Jose on 28/10/2024.
//  Copyright © 2024 Jose Catala. All rights reserved.
//

import Foundation

@MainActor
final class NotificationsViewModel: ObservableObject {
    @Published private(set) var notifications: [Notification] = []
    
    func fetchNotifications() {
        notifications = [
            Notification(id: "1",
                        title: "New Training Session",
                        message: "GB1 training tomorrow at 9:30",
                        date: Date(),
                        type: .training,
                        isRead: false),
            Notification(id: "2",
                        title: "Fight Update",
                        message: "Your next fight has been scheduled",
                        date: Date().addingTimeInterval(-86400),
                        type: .fight,
                        isRead: true)
        ]
    }
}
