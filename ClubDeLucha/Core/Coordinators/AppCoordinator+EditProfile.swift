//
//  AppCoordinator+EditProfile.swift
//  ClubDeLucha
//
//  Created by Jose on 29/10/2024.
//  Copyright © 2024 Jose Catala. All rights reserved.
//

import SwiftUI

@MainActor
extension AppCoordinator {
    func handleEditProfile() -> EditProfileView {
        EditProfileView(viewModel: EditProfileViewModel(profileService: ProfileService()))
    }
}
