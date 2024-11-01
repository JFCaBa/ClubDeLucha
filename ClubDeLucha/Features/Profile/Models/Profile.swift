//
//  Profile.swift
//  ClubDeLucha
//
//  Created by Jose on 29/10/2024.
//  Copyright © 2024 Jose Catala. All rights reserved.
//

import Foundation

struct Profile: Codable {
    let id: String
    let name: String
    let location: String
    let weight: Double
    let imageURL: URL?
}
