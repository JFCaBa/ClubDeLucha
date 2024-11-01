//
//  KeychainProtocol.swift
//  ClubDeLucha
//
//  Created by Jose on 29/10/2024.
//  Copyright © 2024 Jose Catala. All rights reserved.
//

import Foundation

protocol KeychainProtocol {
    func save(_ string: String, for key: String) throws
    func string(for key: String) throws -> String
    func delete(_ key: String) throws
}

