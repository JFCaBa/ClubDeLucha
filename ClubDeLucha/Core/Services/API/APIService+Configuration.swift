//
//  APIService+Configuration.swift
//  ClubDeLucha
//
//  Created by Jose on 29/10/2024.
//  Copyright © 2024 Jose Catala. All rights reserved.
//

import Foundation

extension APIService {
    struct APIConfiguration {
        let baseURL: URL
        let defaultHeaders: [String: String]
        
        static var development: APIConfiguration {
            .init(
                baseURL: URL(string: "https://dev.api.clubdelucha.com")!,
                defaultHeaders: [
                    "Content-Type": "application/json",
                    "Accept": "application/json"
                ]
            )
        }
        
        static var production: APIConfiguration {
            .init(
                baseURL: URL(string: "https://api.clubdelucha.com")!,
                defaultHeaders: [
                    "Content-Type": "application/json",
                    "Accept": "application/json"
                ]
            )
        }
    }
}

