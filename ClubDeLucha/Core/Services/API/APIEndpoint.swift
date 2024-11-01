//
//  APIService+Endpoints.swift
//  ClubDeLucha
//
//  Created by Jose on 29/10/2024.
//  Copyright © 2024 Jose Catala. All rights reserved.
//

import Foundation

enum APIEndpoint: Endpoint {
        
    case login(phone: String)
    case verifyOTP(phone: String, code: String)
    case refreshToken
    
    case fetchQRCode
    
    case trainings(date: Date)
    case training(id: String)
    case createTraining(Training)
    case updateTraining(Training)
    case deleteTraining(id: String)
    
    case fights
    case fight(id: String)
    case createFight(Fight)
    case updateFight(Fight)
    case deleteFight(id: String)
    
    case profile
    case updateProfile(Profile)
    case uploadProfileImage(Data)
    
    case notifications
    case markNotificationRead(id: String)
    
    case qrCode
    
    var path: String {
        switch self {
        case .login:
            return "/auth/login"
        case .verifyOTP:
            return "/auth/verify"
        case .refreshToken:
            return "/auth/refresh"
            
        case .fetchQRCode:
            return "/qr/generate"
            
        case .trainings:
            return "/trainings"
        case .training(let id):
            return "/trainings/\(id)"
        case .createTraining:
            return "/trainings"
        case .updateTraining:
            return "/trainings"
        case .deleteTraining(let id):
            return "/trainings/\(id)"
            
        case .fights:
            return "/fights"
        case .fight(let id):
            return "/fights/\(id)"
        case .createFight:
            return "/fights"
        case .updateFight:
            return "/fights"
        case .deleteFight(let id):
            return "/fights/\(id)"
            
        case .profile:
            return "/profile"
        case .updateProfile:
            return "/profile"
        case .uploadProfileImage:
            return "/profile/image"
            
        case .notifications:
            return "/notifications"
        case .markNotificationRead(let id):
            return "/notifications/\(id)/read"
            
        case .qrCode:
            return "/qr-code"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .login, .verifyOTP, .createTraining, .createFight, .uploadProfileImage:
            return .post
        case .updateTraining, .updateFight, .updateProfile:
            return .put
        case .deleteTraining, .deleteFight:
            return .delete
        case .markNotificationRead:
            return .patch
        default:
            return .get
        }
    }
    
    var headers: [String: String] {
        return ["Content-Type": "application/json"] // Default header
    }
    
    var body: Encodable? {
        switch self {
        case .login(let phone):
            return ["phone": phone]
            
        case .verifyOTP(let phone, let code):
            return ["phone": phone, "code": code]
            
        case .refreshToken:
            return nil
            
        case .fetchQRCode:
            return nil
            
        case .trainings:
            return nil
            
        case .training:
            return nil
            
        case .createTraining(let training):
            return training
            
        case .updateTraining(let training):
            return training
            
        case .deleteTraining:
            return nil
            
        case .fights:
            return nil
            
        case .fight:
            return nil
            
        case .createFight(let fight):
            return fight
            
        case .updateFight(let fight):
            return fight 
            
        case .deleteFight:
            return nil
            
        case .profile:
            return nil
            
        case .updateProfile(let profile):
            return profile // Assuming `Profile` conforms to `Encodable`
            
        case .uploadProfileImage(let imageData):
            return ["image": imageData.base64EncodedString()] // Sending image as base64-encoded string
            
        case .notifications:
            return nil
            
        case .markNotificationRead:
            return nil
            
        case .qrCode:
            return nil
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .trainings(let date):
            let formatter = ISO8601DateFormatter()
            return [URLQueryItem(name: "date", value: formatter.string(from: date))]
        default:
            return nil
        }
    }
}
