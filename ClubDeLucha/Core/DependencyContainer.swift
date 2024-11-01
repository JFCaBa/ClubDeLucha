//
//  DependencyContainer.swift
//  ClubDeLucha
//
//  Created by Jose on 01/11/2024.
//  Copyright © 2024 Jose Catala. All rights reserved.
//

import Foundation

final class DependencyContainer {
    static let shared = DependencyContainer()
    
    private let apiClient: APIClient
    
    private init() {
        self.apiClient = APIClient()
    }
    
    func makeAuthService() -> AuthServiceProtocol {
        RealAuthService(apiClient: apiClient)
    }
    
    func makeQRCodeService() -> QRCodeServiceProtocol {
        RealQRCodeService(apiClient: apiClient)
    }
}
