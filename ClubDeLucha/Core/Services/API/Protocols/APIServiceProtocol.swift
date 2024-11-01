//
//  APIServiceProtocol.swift
//  ClubDeLucha
//
//  Created by Jose on 29/10/2024.
//  Copyright © 2024 Jose Catala. All rights reserved.
//

import Foundation

protocol APIServiceProtocol {
    func request<T: Decodable>(_ endpoint: APIEndpoint) async throws -> T
    func request<T: Encodable, U: Decodable>(_ endpoint: APIEndpoint, body: T) async throws -> U
    func requestWithEmptyResponse(_ endpoint: APIEndpoint) async throws
}
