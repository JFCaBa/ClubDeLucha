//
//  StatItem.swift
//  ClubDeLucha
//
//  Created by Jose on 29/10/2024.
//  Copyright © 2024 Jose Catala. All rights reserved.
//

import SwiftUI

struct StatItem: View {
    let value: String
    let title: String
    
    var body: some View {
        VStack {
            Text(value)
                .font(.title2)
                .bold()
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
        }
    }
}

#Preview {
    StatItem(value: "42", title: "Test")
}
