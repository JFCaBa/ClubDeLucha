//
//  MockAuthService.swift
//  ClubDeLucha
//
//  Created by Jose on 28/10/2024.
//  Copyright © 2024 Jose Catala. All rights reserved.
//

import Foundation
import Combine

final class MockAuthService: AuthServiceProtocol {
    var shouldSucceed = true
    
    func login(phoneNumber: String) -> AnyPublisher<Void, Error> {
        Future { promise in
            if self.shouldSucceed {
                promise(.success(()))
            } else {
                promise(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid phone number"])))
            }
        }
        .eraseToAnyPublisher()
    }
}
