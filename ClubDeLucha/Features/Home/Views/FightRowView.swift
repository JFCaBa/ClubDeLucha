//
//  FightRowView.swift
//  ClubDeLucha
//
//  Created by Jose on 28/10/2024.
//  Copyright © 2024 Jose Catala. All rights reserved.
//

import SwiftUI

struct FightRowView: View {
    let fight: Fight
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(fight.title)
                .font(.headline)
            
            HStack {
                Image(systemName: "calendar")
                Text(fight.date.formatted())
                
                Spacer()
                
                Image(systemName: "mappin.circle.fill")
                Text(fight.location)
            }
            .font(.subheadline)
            .foregroundColor(.gray)
        }
        .padding(.vertical, 8)
    }
}


#Preview {
    FightRowView(fight: MockData.fight)
        .padding()
}
