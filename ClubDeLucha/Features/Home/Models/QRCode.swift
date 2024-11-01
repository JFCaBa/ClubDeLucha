//
//  QRCode.swift
//  ClubDeLucha
//
//  Created by Jose on 28/10/2024.
//  Copyright © 2024 Jose Catala. All rights reserved.
//

import Foundation

struct QRCode: Codable {
    let id: String
    let url: String
    let expiresAt: Date
}
