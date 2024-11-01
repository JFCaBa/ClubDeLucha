//
//  RealAuthService.swift
//  ClubDeLucha
//
//  Created by Jose on 01/11/2024.
//  Copyright © 2024 Jose Catala. All rights reserved.
//

import Combine
import Foundation

final class RealAuthService: AuthServiceProtocol {
    private let apiClient: APIClient
    
    init(apiClient: APIClient = APIClient()) {
        self.apiClient = apiClient
    }
    
    func login(phoneNumber: String) -> AnyPublisher<Void, Error> {
        Future { promise in
            Task {
                do {
                    let _: EmptyResponse = try await self.apiClient.request(.login(phone: phoneNumber))
                    promise(.success(()))
                } catch {
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
