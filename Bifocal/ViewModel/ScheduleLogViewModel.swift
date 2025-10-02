//
//  WeekSkillView.swift
//  BifocalPrototype3
//
//  Created by Henry Lightfoot on 17/09/2025.
//

import SwiftUI

struct ScheduleLogViewModel: View {
    let theSkill: SkillEntity
    let skillTheme: Color

    @State private var currentWeek: Date
    
    @State private var selectedDate: Date

    let dateRange: [Date]

    init(theSkill: SkillEntity, skillTheme: Color) {
        self.theSkill = theSkill
        self.skillTheme = skillTheme
        
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        self._selectedDate = State(initialValue: today)
        self._currentWeek = State(initialValue: today.startOfWeek)
        
        var dates: [Date] = []
        for i in -20...20 {
            if let date = calendar.date(byAdding: .weekOfYear, value: i, to: today.startOfWeek) {
                dates.append(date)
            }
        }
        self.dateRange = dates
    }

    var body: some View {
        VStack {
            ScheduleViewModel(mySkill: theSkill, selectedDate: selectedDate, skillTheme: skillTheme)
            Text(currentWeek.formatted(.dateTime.month(.wide).year()))
                .cardTitle2Style()
            TabView(selection: $currentWeek) {
                ForEach(dateRange, id: \.self) { weekStartDate in
                    WeekView(
                        week: weekStartDate.generateWeek(),
                        selectedDate: selectedDate,
                        onDateTapped: { date in
                            selectedDate = date
                        },
                        skillTheme: skillTheme
                    )
                    .tag(weekStartDate)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: 100)
            
            dayLogsList(mySkill: theSkill, selectedDate: selectedDate, skillTheme: skillTheme )
        }
        .onChange(of: currentWeek) { newValue in
            selectedDate = newValue
        }
    }
}
