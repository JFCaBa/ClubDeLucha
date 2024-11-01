//
//  Training.swift
//  ClubDeLucha
//
//  Created by Jose on 28/10/2024.
//  Copyright © 2024 Jose Catala. All rights reserved.
//

import SwiftUI

struct Training: Codable, Identifiable {
    let id: String
    let title: String
    let trainer: String?
    let location: String
    let startTime: Date
    let endTime: Date
    let type: TrainingType
    
    enum TrainingType: Codable {
        case gi
        case noGi
        case juniors
        case women
        case allLevels
        
        var title: String {
            switch self {
            case .gi: return "Gi"
            case .noGi: return  "No-Gi"
            case .juniors: return  "Juniors"
            case .women: return  "Women"
            case .allLevels: return  "All Levels"
            }
        }
        
        var color: Color {
            switch self {
            case .gi, .allLevels: return .blue
            case .noGi: return .orange
            case .juniors: return .green
            case .women: return .indigo
            }
        }
    }
}
