//
//  QRCodeServiceProtocol.swift
//  ClubDeLucha
//
//  Created by Jose on 28/10/2024.
//  Copyright © 2024 Jose Catala. All rights reserved.
//

import Foundation

protocol QRCodeServiceProtocol {
    func fetchQRCode() async throws -> QRCode
}
