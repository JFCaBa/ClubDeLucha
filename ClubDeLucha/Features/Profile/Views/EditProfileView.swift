//
//  EditProfileView.swift
//  ClubDeLucha
//
//  Created by Jose on 29/10/2024.
//  Copyright © 2024 Jose Catala. All rights reserved.
//

import SwiftUI

struct EditProfileView: View {
    @StateObject private var viewModel: EditProfileViewModel
    @Environment(\.dismiss) private var dismiss
    
    init(viewModel: EditProfileViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
            Form {
                Section {
                    TextField("Name", text: $viewModel.name)
                    TextField("Location", text: $viewModel.location)
                    TextField("Weight", text: $viewModel.weight)
                        .keyboardType(.decimalPad)
                }
                
                Section {
                    Button("Save Changes".localised) {
                        Task {
                            await viewModel.saveProfile()
                        }
                    }
                    .disabled(viewModel.isLoading)
                }
            }
            .navigationTitle("Edit Profile".localised)
            .navigationBarTitleDisplayMode(.inline)
            .disabled(viewModel.isLoading)
            .alert("Error", isPresented: Binding(
                get: { viewModel.error != nil },
                set: { _ in viewModel.error = nil }
            )) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(viewModel.error ?? "")
            }
    }
}

