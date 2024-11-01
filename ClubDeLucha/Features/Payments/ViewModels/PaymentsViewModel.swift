//
//  PaymentsViewModel.swift
//  ClubDeLucha
//
//  Created by Jose on 29/10/2024.
//  Copyright © 2024 Jose Catala. All rights reserved.
//

import Combine
import Foundation

@MainActor
final class PaymentsViewModel: ObservableObject {
    @Published private(set) var subscription: Subscription?
    @Published private(set) var isLoading = false
    @Published var error: String?
    
    func fetchSubscription() async {
        isLoading = true
        defer { isLoading = false }
        
        // Mock data
        subscription = Subscription(
            currentPeriod: Date(),
            nextPayment: Date().addingTimeInterval(30 * 24 * 3600),
            amount: 49.99,
            status: .active
        )
    }
    
    func handlePayment() async {
        isLoading = true
        defer { isLoading = false }
        
        // Simulate payment process
        try? await Task.sleep(nanoseconds: 2 * 1_000_000_000)
    }
}
