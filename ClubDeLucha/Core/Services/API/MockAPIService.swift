//
//  MockAPIService.swift
//  ClubDeLucha
//
//  Created by Jose on 29/10/2024.
//  Copyright © 2024 Jose Catala. All rights reserved.
//

import Foundation

final class MockAPIService: APIServiceProtocol {
    var shouldFail = false
    var error: APIService.APIError = .networkError(NSError(domain: "test", code: -1))
    
    func requestWithEmptyResponse(_ endpoint: APIEndpoint) async throws { }
    func request<T: Decodable>(_ endpoint: APIEndpoint) async throws -> T {
        if shouldFail { throw error }
        
        switch endpoint {
        case .trainings:
            return mockTrainings() as! T
        case .fights:
            return mockFights() as! T
        case .profile:
            return mockProfile() as! T
        case .notifications:
            return mockNotifications() as! T
        case .qrCode:
            return mockQRCode() as! T
        default:
            fatalError("Mock not implemented for endpoint: \(endpoint)")
        }
    }
    
    func request<T: Encodable, U: Decodable>(_ endpoint: APIEndpoint, body: T) async throws -> U {
        if shouldFail { throw error }
        
        switch endpoint {
        case .login:
            return TokenResponse(accessToken: "mock_access", refreshToken: "mock_refresh") as! U
        case .verifyOTP:
            return TokenResponse(accessToken: "mock_access", refreshToken: "mock_refresh") as! U
        case .createTraining:
            return mockTraining() as! U
        case .updateTraining:
            return mockTraining() as! U
        case .createFight:
            return mockFight() as! U
        case .updateFight:
            return mockFight() as! U
        case .updateProfile:
            return mockProfile() as! U
        default:
            fatalError("Mock not implemented for endpoint: \(endpoint)")
        }
    }
    
    func request(_ endpoint: APIEndpoint) async throws {
        if shouldFail { throw error }
        // Simulates void responses
    }
    
    // MARK: - Mock Data Generators
    private func mockTrainings() -> [Training] {
        [
            Training(
                id: "1",
                title: "Gi Training",
                trainer: "John Doe",
                location: "Main Gym",
                startTime: Date(),
                endTime: Date().addingTimeInterval(3600),
                type: .gi
            ),
            Training(
                id: "2",
                title: "No-Gi Training",
                trainer: "Jane Smith",
                location: "Main Gym",
                startTime: Date().addingTimeInterval(3600),
                endTime: Date().addingTimeInterval(7200),
                type: .noGi
            ),
            Training(
                id: "3",
                title: "Women's Class",
                trainer: "Sarah Johnson",
                location: "Mat Room",
                startTime: Date().addingTimeInterval(7200),
                endTime: Date().addingTimeInterval(10800),
                type: .women
            )
        ]
    }
    
    private func mockTraining() -> Training {
        Training(
            id: UUID().uuidString,
            title: "Mock Training",
            trainer: "Mock Trainer",
            location: "Mock Location",
            startTime: Date(),
            endTime: Date().addingTimeInterval(3600),
            type: .gi
        )
    }
    
    private func mockFights() -> [Fight] {
        [
            Fight(
                id: "1",
                title: "Championship Fight",
                date: Date(),
                location: "Main Arena"
            ),
            Fight(
                id: "2",
                title: "Qualifier Match",
                date: Date().addingTimeInterval(86400),
                location: "Competition Center"
            ),
            Fight(
                id: "3",
                title: "Tournament Final",
                date: Date().addingTimeInterval(172800),
                location: "Sports Complex"
            )
        ]
    }
    
    private func mockFight() -> Fight {
        Fight(
            id: UUID().uuidString,
            title: "Mock Fight",
            date: Date(),
            location: "Mock Arena"
        )
    }
    
    private func mockProfile() -> Profile {
        Profile(
            id: "1",
            name: "John Doe",
            location: "Madrid, Spain",
            weight: 80,
            imageURL: URL(string: "https://example.com/profile.jpg")
        )
    }
    
    private func mockNotifications() -> [Notification] {
        [
            Notification(
                id: "1",
                title: "New Training Session",
                message: "GB1 training tomorrow at 9:30",
                date: Date(),
                type: .training,
                isRead: false
            ),
            Notification(
                id: "2",
                title: "Fight Update",
                message: "Your next fight has been scheduled",
                date: Date().addingTimeInterval(-86400),
                type: .fight,
                isRead: true
            ),
            Notification(
                id: "3",
                title: "System Maintenance",
                message: "Scheduled maintenance tonight",
                date: Date().addingTimeInterval(-172800),
                type: .system,
                isRead: true
            )
        ]
    }
    
    private func mockQRCode() -> QRCode {
        QRCode(
            id: UUID().uuidString,
            url: "https://clubdelucha.com/qr/mock",
            expiresAt: Date().addingTimeInterval(300)
        )
    }
}

// MARK: - Mock Response Generator
extension MockAPIService {
    func mockResponse<T: Encodable>(for data: T) -> Data {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        encoder.keyEncodingStrategy = .convertToSnakeCase
        
        do {
            return try encoder.encode(data)
        } catch {
            fatalError("Failed to encode mock data: \(error)")
        }
    }
}

// MARK: - Test Helpers
extension MockAPIService {
    func simulateNetworkFailure() {
        shouldFail = true
        error = .networkError(NSError(domain: "test.network", code: -1))
    }
    
    func simulateServerError() {
        shouldFail = true
        error = .serverError("Internal Server Error")
    }
    
    func simulateUnauthorized() {
        shouldFail = true
        error = .unauthorized
    }
    
    func resetSimulation() {
        shouldFail = false
        error = .networkError(NSError(domain: "test", code: -1))
    }
}
