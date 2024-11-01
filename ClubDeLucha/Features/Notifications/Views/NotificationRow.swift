//
//  NotificationRow.swift
//  ClubDeLucha
//
//  Created by Jose on 28/10/2024.
//  Copyright © 2024 Jose Catala. All rights reserved.
//

import SwiftUI

struct NotificationRow: View {
    let notification: Notification
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(notification.title)
                    .font(.headline)
                
                Spacer()
                
                if !notification.isRead {
                    Circle()
                        .fill(.blue)
                        .frame(width: 8, height: 8)
                }
            }
            
            Text(notification.message)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Text(notification.date, format: .dateTime)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    NotificationRow(notification: MockData.notification)
        .padding()
}
