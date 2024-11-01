//
//  Notifications.swift
//  ClubDeLucha
//
//  Created by Jose on 28/10/2024.
//  Copyright © 2024 Jose Catala. All rights reserved.
//

import Foundation

struct Notification: Identifiable {
    let id: String
    let title: String
    let message: String
    let date: Date
    let type: NotificationType
    var isRead: Bool
    
    enum NotificationType {
        case training
        case fight
        case system
    }
}
