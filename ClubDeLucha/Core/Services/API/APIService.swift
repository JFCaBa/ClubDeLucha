//
//  APIService.swift
//  ClubDeLucha
//
//  Created by Jose on 29/10/2024.
//  Copyright © 2024 Jose Catala. All rights reserved.
//

import Foundation
import Combine

final class APIService: APIServiceProtocol {
    private let configuration: APIConfiguration
    private let session: URLSession
    private let tokenManager: TokenManaging
    private let decoder: JSONDecoder
    private let encoder: JSONEncoder
    
    init(
        configuration: APIConfiguration = .development,
        session: URLSession = .shared,
        tokenManager: TokenManaging,
        decoder: JSONDecoder = .init(),
        encoder: JSONEncoder = .init()
    ) {
        self.configuration = configuration
        self.session = session
        self.tokenManager = tokenManager
        self.decoder = decoder
        self.encoder = encoder
        
        setupFormatters()
    }
    
    private func setupFormatters() {
        decoder.dateDecodingStrategy = .iso8601
        encoder.dateEncodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        encoder.keyEncodingStrategy = .convertToSnakeCase
    }
    
    func request<T: Decodable>(_ endpoint: APIEndpoint) async throws -> T {
        try await performRequest(endpoint)
    }
    
    func request<T: Encodable, U: Decodable>(_ endpoint: APIEndpoint, body: T) async throws -> U {
        try await performRequest(endpoint, body: body)
    }
    
    func requestWithEmptyResponse(_ endpoint: APIEndpoint) async throws {
        let _: Empty = try await performRequest(endpoint)
    }
    
    private func performRequest<T: Decodable>(_ endpoint: APIEndpoint, body: Encodable? = nil) async throws -> T {
        let request = try createRequest(for: endpoint, body: body)
        
        do {
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.invalidResponse
            }
            
            switch httpResponse.statusCode {
            case 200...299:
                return try decoder.decode(T.self, from: data)
            case 401:
                if await handleUnauthorized() {
                    return try await performRequest(endpoint, body: body)
                }
                throw APIError.unauthorized
            case 400...499:
                throw APIError.httpError(httpResponse.statusCode)
            case 500...599:
                throw APIError.serverError(String(data: data, encoding: .utf8) ?? "Unknown server error")
            default:
                throw APIError.unknown
            }
            
        } catch let error as APIError {
            throw error
        } catch let error as DecodingError {
            print("Decoding error: \(error)")
            throw APIError.decodingError
        } catch {
            throw APIError.networkError(error)
        }
    }
    
    private func createRequest(for endpoint: APIEndpoint, body: Encodable? = nil) throws -> URLRequest {
        var components = URLComponents(url: configuration.baseURL.appendingPathComponent(endpoint.path), resolvingAgainstBaseURL: true)
        components?.queryItems = endpoint.queryItems
        
        guard let url = components?.url else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        
        // Add default headers
        configuration.defaultHeaders.forEach { request.setValue($1, forHTTPHeaderField: $0) }
        
        // Add auth header if we have a token
        if let token = tokenManager.accessToken {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        // Add body if we have one
        if let body = body {
            request.httpBody = try encoder.encode(body)
        }
        
        return request
    }
    
    private func handleUnauthorized() async -> Bool {
        guard let refreshToken = tokenManager.refreshToken else {
            return false
        }
        
        do {
            let tokens: TokenResponse = try await request(.refreshToken)
            tokenManager.update(accessToken: tokens.accessToken, refreshToken: tokens.refreshToken)
            return true
        } catch {
            tokenManager.clearTokens()
            return false
        }
    }
}



