//
//  CalendarViews.swift
//  BifocalPrototype3
//
//  Created by Henry Lightfoot on 27/09/2025.
//

import SwiftUI

struct DayView: View {
    let date: Date
    let isSelected: Bool
    let skillTheme: Color

    var body: some View {
        VStack(spacing: 8) {
            Text(date.formatted(.dateTime.weekday(.narrow)))
                .font(.subheadline)
                .foregroundColor(.secondary)
            ZStack {
                if isSelected {
                    Circle()
                        .fill(.white)
                        .overlay(Circle().stroke(skillTheme, lineWidth: 3.5))
                } else {
                    Circle().fill(skillTheme)
                }
                Text(date.formatted(.dateTime.day()))
                    .foregroundStyle(isSelected ? .darkDate : .white)
                    .font(.title3)
                    .fontWeight(.bold)
            }
            .aspectRatio(1, contentMode: .fit)
        }
    }
}

struct WeekView: View {
    let week: [Date]
    let selectedDate: Date
    let onDateTapped: (Date) -> Void
    let skillTheme: Color
    
    var body: some View {
        Grid(horizontalSpacing:1, verticalSpacing: 1) {
            GridRow {
                    ForEach(week, id: \.self) { day in
                        Button(action: {
                            onDateTapped(day)
                        }) {
                            DayView(date: day, isSelected: Calendar.current.isDate(day, inSameDayAs: selectedDate), skillTheme: skillTheme)
                        }
                        .buttonStyle(.plain)
                    }
            }
        }
    }
}
