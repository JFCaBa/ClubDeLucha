//
//  ScheduleView.swift
//  ClubDeLucha
//
//  Created by Jose on 28/10/2024.
//  Copyright © 2024 Jose Catala. All rights reserved.
//

import SwiftUI

struct ScheduleView: View {
    @StateObject private var viewModel = ScheduleViewModel()
    @Environment(\.calendar) var calendar
    
    var body: some View {
            VStack(spacing: 0) {
                if viewModel.calendarState == .collapsed {
                    HStack {
                        Button(action: { viewModel.previousDay() }) {
                            Image(systemName: "chevron.left")
                        }
                        
                        Spacer()
                        
                        Button(action: { viewModel.toggleCalendar() }) {
                            Text(viewModel.formattedSelectedDate)
                                .font(.title2)
                        }
                        
                        Spacer()
                        
                        Button(action: { viewModel.nextDay() }) {
                            Image(systemName: "chevron.right")
                        }
                    }
                    .padding()
                    .transition(.opacity)
                }
                
                if viewModel.calendarState == .expanded {
                    Spacer()
                    
                    calendarView
                        .transition(.move(edge: .top).combined(with: .opacity))
                }
                
                trainingsList
            }
            .navigationTitle("Schedule")
            .animation(.spring(), value: viewModel.calendarState)
    }
    
    private var calendarView: some View {
        VStack {
            monthYearPicker
            
            Spacer()
            
            weekDaysHeader
            dateGrid
        }
    }
    
    private var monthYearPicker: some View {
        HStack {
            Button(action: { viewModel.previousMonth() }) {
                Image(systemName: "chevron.left")
            }
            
            Spacer()
            
            Text(viewModel.monthYearString)
                .font(.headline)
            
            Spacer()
            
            Button(action: { viewModel.nextMonth() }) {
                Image(systemName: "chevron.right")
            }
        }
        .padding(.horizontal)
    }
    
    private var weekDaysHeader: some View {
        HStack {
            ForEach(viewModel.weekDaySymbols, id: \.self) { symbol in
                Text(symbol)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.secondary)
                    .font(.caption)
            }
        }
        .padding(.horizontal)
    }
    
    private var dateGrid: some View {
        let days = viewModel.daysInMonth()
        return LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
            ForEach(days.indices, id: \.self) { index in
                if let date = days[index] {
                    let isSelected = calendar.isDate(date, inSameDayAs: viewModel.selectedDate)
                    Button(action: {
                        viewModel.selectedDate = date
                        viewModel.calendarState = .collapsed
                    }) {
                        Text(String(calendar.component(.day, from: date)))
                            .frame(width: 35, height: 35)
                            .background(isSelected ? Color.accentColor : Color.clear)
                            .clipShape(Circle())
                            .foregroundColor(isSelected ? .white : .primary)
                    }
                } else {
                    Color.clear
                        .frame(width: 35, height: 35)
                }
            }
        }
        .padding(.horizontal)
    }
    
    private var trainingsList: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(viewModel.trainingsForSelectedDate) { training in
                    TrainingRowView(training: training)
                }
            }
            .padding()
        }
    }
}

#Preview {
    ScheduleView()
        .withTestDependencies()
}
