//
//  SettingsView.swift
//  ClubDeLucha
//
//  Created by Jose on 29/10/2024.
//  Copyright © 2024 Jose Catala. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    
    var body: some View {
        Form {
            Section {
                Toggle("Notifications".localised, isOn: $viewModel.notificationsEnabled)
                    .onChange(of: viewModel.notificationsEnabled) { _, _ in
                        viewModel.toggleNotifications()
                    }
            }
            
            Section("Legal".localised) {
                NavigationLink("Terms & Conditions".localised) {
                    Text("Terms Content")
                }
                
                NavigationLink("Privacy Policy".localised) {
                    Text("Privacy Content")
                }
            }
            
            Section("Payments".localised) {
                NavigationLink("Payment History".localised) {
                    Text("Payment History")
                }
            }
            
            Section {
                HStack {
                    Spacer()
                    Text(viewModel.versionText)
                        .font(.footnote)
                        .foregroundColor(.secondary)
                    Spacer()
                }
            }
        }
        .navigationTitle("Settings".localised)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    SettingsView()
        .withTestDependencies()
}
