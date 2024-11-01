//
//  MenuItem.swift
//  ClubDeLucha
//
//  Created by Jose on 29/10/2024.
//  Copyright © 2024 Jose Catala. All rights reserved.
//

import Foundation

struct MenuItem: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
    let action: AppCoordinator.Route
}
