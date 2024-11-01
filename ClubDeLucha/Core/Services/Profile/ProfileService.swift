//
//  ProfileService.swift
//  ClubDeLucha
//
//  Created by Jose on 29/10/2024.
//  Copyright © 2024 Jose Catala. All rights reserved.
//

import Foundation

final class ProfileService: ProfileServiceProtocol {
    func updateProfile(_ profile: Profile) async throws {
        // Simulate network delay
        try await Task.sleep(nanoseconds: 1_000_000_000)
    }
}
