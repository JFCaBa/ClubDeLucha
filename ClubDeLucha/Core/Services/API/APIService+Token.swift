//
//  APIService+Token.swift
//  ClubDeLucha
//
//  Created by Jose on 29/10/2024.
//  Copyright © 2024 Jose Catala. All rights reserved.
//

import Foundation

struct TokenResponse: Codable {
    let accessToken: String
    let refreshToken: String
}

protocol TokenManaging {
    var accessToken: String? { get }
    var refreshToken: String? { get }
    func update(accessToken: String, refreshToken: String)
    func clearTokens()
}

final class TokenManager: TokenManaging {
    private let keychain: KeychainProtocol
    
    init(keychain: KeychainProtocol) {
        self.keychain = keychain
    }
    
    var accessToken: String? {
        try? keychain.string(for: "access_token")
    }
    
    var refreshToken: String? {
        try? keychain.string(for: "refresh_token")
    }
    
    func update(accessToken: String, refreshToken: String) {
        try? keychain.save(accessToken, for: "access_token")
        try? keychain.save(refreshToken, for: "refresh_token")
    }
    
    func clearTokens() {
        try? keychain.delete("access_token")
        try? keychain.delete("refresh_token")
    }
}
