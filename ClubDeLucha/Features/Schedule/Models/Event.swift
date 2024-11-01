//
//  Event.swift
//  ClubDeLucha
//
//  Created by Jose on 28/10/2024.
//  Copyright © 2024 Jose Catala. All rights reserved.
//

import Foundation

struct Event: Identifiable {
    let id: String
    let title: String
    let date: Date
    let location: String
    let participantsCount: Int
    let type: EventType
    
    enum EventType: String {
        case fight = "Fight"
        case training = "Training"
    }
}
