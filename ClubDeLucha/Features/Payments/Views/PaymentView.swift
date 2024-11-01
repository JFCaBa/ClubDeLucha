//
//  PaymentView.swift
//  ClubDeLucha
//
//  Created by Jose on 29/10/2024.
//  Copyright © 2024 Jose Catala. All rights reserved.
//

import SwiftUI

struct PaymentsView: View {
    @StateObject private var viewModel = PaymentsViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                if viewModel.isLoading {
                    ProgressView()
                } else if let subscription = viewModel.subscription {
                    subscriptionCard(subscription)
                    paymentButton
                }
            }
            .padding()
        }
        .navigationTitle("Payments".localised)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.fetchSubscription()
        }
    }
    
    private func subscriptionCard(_ subscription: Subscription) -> some View {
        VStack(spacing: 16) {
            HStack {
                Text("Monthly Subscription")
                    .font(.headline)
                Spacer()
                statusBadge(subscription.status)
            }
            
            Divider()
            
            VStack(spacing: 12) {
                infoRow("Current Period", value: subscription.currentPeriod.formatted(date: .abbreviated, time: .omitted))
                infoRow("Next Payment", value: subscription.nextPayment.formatted(date: .abbreviated, time: .omitted))
                infoRow("Amount", value: subscription.amount.formatted(.currency(code: "EUR")))
            }
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(12)
    }
    
    private func statusBadge(_ status: PaymentStatus) -> some View {
        Text(String(describing: status).capitalized)
            .font(.caption)
            .foregroundColor(.white)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(status.color)
            .cornerRadius(8)
    }
    
    private func infoRow(_ title: String, value: String) -> some View {
        HStack {
            Text(title.localised)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
                .bold()
        }
    }
    
    private var paymentButton: some View {
        Button {
            Task {
                await viewModel.handlePayment()
            }
        } label: {
            if viewModel.isLoading {
                ProgressView()
                    .tint(.white)
            } else {
                Text("Pay Now".localised)
                    .font(.headline)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 50)
        .background(viewModel.isLoading ? Color.blue.opacity(0.5) : Color.blue)
        .foregroundColor(.white)
        .cornerRadius(25)
        .disabled(viewModel.isLoading)
    }
}

#Preview {
    PaymentsView()
        .withTestDependencies()
}
