//
//  QRCodeService.swift
//  ClubDeLucha
//
//  Created by Jose on 28/10/2024.
//  Copyright © 2024 Jose Catala. All rights reserved.
//

import Foundation


final class MockQRCodeService: QRCodeServiceProtocol {
    func fetchQRCode() async throws -> QRCode {
        // Simulate network delay
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        
        return QRCode(
            id: UUID().uuidString,
            url: "https://clubdelucha.com/qr/123456",
            expiresAt: Date().addingTimeInterval(300) // 5 minutes expiration
        )
    }
}
