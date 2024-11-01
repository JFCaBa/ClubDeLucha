//
//  AuthService.swift
//  ClubDeLucha
//
//  Created by Jose on 28/10/2024.
//

import Foundation
import Combine



final class AuthService: AuthServiceProtocol {
    func login(phoneNumber: String) -> AnyPublisher<Void, Error> {
        Future { promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                // TODO: Validate phone number
                if phoneNumber.count >= 0 {
                    promise(.success(()))
                } else {
                    promise(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid phone number"])))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
