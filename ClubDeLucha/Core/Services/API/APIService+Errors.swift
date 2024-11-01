//
//  APIService+Errors.swift
//  ClubDeLucha
//
//  Created by Jose on 29/10/2024.
//  Copyright © 2024 Jose Catala. All rights reserved.
//

import Foundation

extension APIService {
    enum APIError: LocalizedError {
        case invalidURL
        case invalidResponse
        case httpError(Int)
        case decodingError
        case unauthorized
        case networkError(Error)
        case serverError(String)
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .invalidURL:
                return "Invalid URL"
            case .invalidResponse:
                return "Invalid response"
            case .httpError(let code):
                return "HTTP error: \(code)"
            case .decodingError:
                return "Failed to decode response"
            case .unauthorized:
                return "Unauthorized"
            case .networkError(let error):
                return "Network error: \(error.localizedDescription)"
            case .serverError(let message):
                return "Server error: \(message)"
            case .unknown:
                return "Unknown error occurred"
            }
        }
    }
}
