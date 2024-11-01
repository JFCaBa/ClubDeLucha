//
//  RealQRCodeService.swift
//  ClubDeLucha
//
//  Created by Jose on 01/11/2024.
//  Copyright © 2024 Jose Catala. All rights reserved.
//

import Foundation

final class RealQRCodeService: QRCodeServiceProtocol {
    private let apiClient: APIClient
    
    init(apiClient: APIClient = APIClient()) {
        self.apiClient = apiClient
    }
    
    func fetchQRCode() async throws -> QRCode {
        try await apiClient.request(.fetchQRCode)
    }
}
