//
//  EndpointProtocol.swift
//  ClubDeLucha
//
//  Created by Jose on 01/11/2024.
//  Copyright © 2024 Jose Catala. All rights reserved.
//

import Foundation

protocol Endpoint {
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var body: Encodable? { get }
}
