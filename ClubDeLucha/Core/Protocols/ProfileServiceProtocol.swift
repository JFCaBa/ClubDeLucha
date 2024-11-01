//
//  ProfileServiceProtocol.swift
//  ClubDeLucha
//
//  Created by Jose on 29/10/2024.
//  Copyright © 2024 Jose Catala. All rights reserved.
//

import Foundation

protocol ProfileServiceProtocol {
    func updateProfile(_ profile: Profile) async throws
}
