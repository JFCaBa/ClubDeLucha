//
//  Subscription.swift
//  ClubDeLucha
//
//  Created by Jose on 29/10/2024.
//  Copyright © 2024 Jose Catala. All rights reserved.
//

import SwiftUI

enum PaymentStatus {
    case active
    case overdue
    case pending
    
    var color: Color {
        switch self {
        case .active: return .green
        case .overdue: return .red
        case .pending: return .orange
        }
    }
}

struct Subscription {
    let currentPeriod: Date
    let nextPayment: Date
    let amount: Double
    let status: PaymentStatus
}
