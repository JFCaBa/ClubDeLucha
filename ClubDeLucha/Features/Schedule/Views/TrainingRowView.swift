//
//  TrainingRowView.swift
//  ClubDeLucha
//
//  Created by Jose on 28/10/2024.
//  Copyright © 2024 Jose Catala. All rights reserved.
//

import SwiftUI

struct TrainingRowView: View {
    let training: Training
    
    private let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    var body: some View {
        HStack(spacing: 16) {
            Rectangle()
                .fill(training.type.color)
                .frame(width: 4)
                .frame(maxHeight: .infinity)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("\(timeFormatter.string(from: training.startTime)) - \(timeFormatter.string(from: training.endTime))")
                    .font(.headline)
                
                Text(training.type.title)
                    .foregroundColor(training.type.color)
                    .fontWeight(.semibold)
                
                if let trainer = training.trainer {
                    Text(trainer)
                        .font(.subheadline)
                }
                
                Text(training.location)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(12)
    }
}

#Preview {
    TrainingRowView(training: MockData.training)
        .padding()
}
