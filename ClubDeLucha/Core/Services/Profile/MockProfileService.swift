//
//  MockProfileService.swift
//  ClubDeLucha
//
//  Created by Jose on 29/10/2024.
//  Copyright © 2024 Jose Catala. All rights reserved.
//

import Foundation

final class MockProfileService: ProfileServiceProtocol {
    var shouldSucceed = true
    
    func updateProfile(_ profile: Profile) async throws {
        if shouldSucceed {
            try await Task.sleep(nanoseconds: 1_000_000_000)
        } else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to update profile"])
        }
    }
}
