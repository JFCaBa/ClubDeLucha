//
//  Fight.swift
//  ClubDeLucha
//
//  Created by Jose on 28/10/2024.
//  Copyright © 2024 Jose Catala. All rights reserved.
//

import Foundation

struct Fight: Codable, Identifiable {
    let id: String
    let title: String
    let date: Date
    let location: String
}
