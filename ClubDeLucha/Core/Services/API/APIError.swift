//
//  APIError.swift
//  ClubDeLucha
//
//  Created by Jose on 01/11/2024.
//  Copyright © 2024 Jose Catala. All rights reserved.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case noData
    case decodingError
    case serverError(String)
    case networkError(Error)
}
