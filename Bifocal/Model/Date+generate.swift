//
//  Date+generate.swift
//  BifocalPrototype3
//
//  Created by Henry Lightfoot on 17/09/2025.
//

import Foundation


extension Date {
    var startOfWeek: Date {
        let calendar = Calendar.current
        guard let interval = calendar.dateInterval(of: .weekOfYear, for: self) else { return self }
        return interval.start
    }
    
    var endOfWeek: Date {
        let calendar = Calendar.current
        guard let interval = calendar.dateInterval(of: .weekOfYear, for: self) else { return self }
        return interval.end
    }

    func generateWeek() -> [Date] {
        var week: [Date] = []
        let calendar = Calendar.current
        for i in 0..<7 {
            if let day = calendar.date(byAdding: .day, value: i, to: self) {
                week.append(day)
            }
        }
        return week
    }
}
