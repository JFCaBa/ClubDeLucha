//
//  AuthServiceProtocol.swift
//  ClubDeLucha
//
//  Created by Jose on 29/10/2024.
//  Copyright © 2024 Jose Catala. All rights reserved.
//

import Combine

protocol AuthServiceProtocol {
    func login(phoneNumber: String) -> AnyPublisher<Void, Error>
}
