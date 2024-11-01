//
//  EditProfileViewModel.swift
//  ClubDeLucha
//
//  Created by Jose on 29/10/2024.
//  Copyright © 2024 Jose Catala. All rights reserved.
//

import Foundation

@MainActor
final class EditProfileViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var location: String = ""
    @Published var weight: String = ""
    @Published private(set) var isLoading = false
    @Published var error: String?
    
    private let profileService: ProfileServiceProtocol
    
    init(profileService: ProfileServiceProtocol) {
        self.profileService = profileService
        fetchProfile()
    }
    
    private func fetchProfile() {
        name = "John Doe"
        location = "Madrid, Spain"
        weight = "80"
    }
    
    func saveProfile() async {
        isLoading = true
        error = nil
        
        do {
            let profile = Profile(
                id: "1",
                name: name,
                location: location,
                weight: Double(weight) ?? 0,
                imageURL: nil
            )
            try await profileService.updateProfile(profile)
        } catch {
            self.error = error.localizedDescription
        }
        
        isLoading = false
    }
}
