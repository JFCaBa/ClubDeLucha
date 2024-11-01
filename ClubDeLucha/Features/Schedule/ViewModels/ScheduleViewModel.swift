//
//  ScheduleViewModel.swift
//  ClubDeLucha
//
//  Created by Jose on 28/10/2024.
//  Copyright © 2024 Jose Catala. All rights reserved.
//

import Foundation

@MainActor
final class ScheduleViewModel: ObservableObject {
    @Published var selectedDate: Date = Date()
    @Published var calendarState: CalendarState = .collapsed
    @Published private(set) var trainingsForSelectedDate: [Training] = []
    
    private let calendar = Calendar.current
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM yyyy"
        return formatter
    }()
    
    init() {
        fetchTrainings()
    }
    
    var formattedSelectedDate: String {
        dateFormatter.string(from: selectedDate)
    }
    
    var monthYearString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: selectedDate)
    }
    
    let weekDaySymbols = ["Mo".localised, "Tu".localised, "We".localised, "Th".localised, "Fr".localised, "Sa".localised, "Su".localised]
    
    func daysInMonth() -> [Date?] {
        guard let monthInterval = calendar.dateInterval(of: .month, for: selectedDate),
              let monthFirstWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.start),
              let monthLastWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.end - 1) else {
            return []
        }
        
        var result: [Date?] = []
        
        calendar.enumerateDates(
            startingAfter: monthFirstWeek.start - 1,
            matching: DateComponents(hour: 0, minute: 0, second: 0),
            matchingPolicy: .nextTime
        ) { date, _, stop in
            if let date = date {
                if date > monthLastWeek.end {
                    stop = true
                } else {
                    if calendar.isDate(date, equalTo: monthInterval.start, toGranularity: .month) {
                        result.append(date)
                    } else {
                        result.append(nil)
                    }
                }
            }
        }
        return result
    }
    
    func toggleCalendar() {
        calendarState = calendarState == .collapsed ? .expanded : .collapsed
    }
    
    func previousMonth() {
        selectedDate = calendar.date(byAdding: .month, value: -1, to: selectedDate) ?? selectedDate
    }
    
    func nextMonth() {
        selectedDate = calendar.date(byAdding: .month, value: 1, to: selectedDate) ?? selectedDate
    }
    
    private func fetchTrainings() {
        // Mock data
        let mockTrainings: [Training] = [
            Training(id: "1", title: "Gi".localised, trainer: "Stanley Barbosa", location: "C.L. Massanassa",
                    startTime: Date().addingTimeInterval(9 * 3600 + 30 * 60),
                    endTime: Date().addingTimeInterval(10 * 3600 + 30 * 60),
                    type: .gi),
            Training(id: "2", title: "No-Gi".localised, trainer: "German", location: "C.L. Massanassa",
                    startTime: Date().addingTimeInterval(16 * 3600),
                    endTime: Date().addingTimeInterval(17 * 3600),
                    type: .noGi),
            Training(id: "3", title: "Women".localised, trainer: "Paula", location: "C.L. Massanassa",
                    startTime: Date().addingTimeInterval(16 * 3600),
                    endTime: Date().addingTimeInterval(17 * 3600),
                    type: .women),
        ]
        trainingsForSelectedDate = mockTrainings
    }
}

// MARK: - backwards/forwards day

extension ScheduleViewModel {
    func nextDay() {
        selectedDate = calendar.date(byAdding: .day, value: 1, to: selectedDate) ?? selectedDate
        fetchTrainings()
    }
    
    func previousDay() {
        selectedDate = calendar.date(byAdding: .day, value: -1, to: selectedDate) ?? selectedDate
        fetchTrainings()
    }
}
