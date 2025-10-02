//
//  ScheduleViewModel.swift
//  BifocalPrototype3
//
//  Created by Henry Lightfoot on 27/09/2025.
//

import SwiftUI

struct ScheduleViewModel: View {
    let theSkill: SkillEntity
    @FetchRequest private var dayLogs: FetchedResults<SkillLogged>
    @FetchRequest private var weekLogs: FetchedResults<SkillLogged>
    @FetchRequest private var theSchedule: FetchedResults<SkillSchedule>
    let skillTheme: Color
    
    
    init(mySkill: SkillEntity, selectedDate: Date, skillTheme: Color) {
        theSkill = mySkill
        let startDate = selectedDate
        let dayEnd = Calendar.current.date(byAdding: .day, value: 1, to: startDate) ?? startDate
        let weekInterval = Calendar.current.dateInterval(of: .weekOfYear, for: startDate)
        let weekStart = weekInterval?.start ?? Date.now
        let weekEnd = weekInterval?.end ?? Date.now
        
        _dayLogs = FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)],
                                predicate: NSPredicate(format: "skilll == %@ AND (date >= %@) AND (date <= %@)", mySkill, startDate as NSDate, dayEnd as NSDate))
        _weekLogs = FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)],
                                predicate: NSPredicate(format: "skilll == %@ AND (date >= %@) AND (date <= %@)", mySkill, weekStart as NSDate, weekEnd as NSDate))
        _theSchedule = FetchRequest(sortDescriptors: [],
                                predicate: NSPredicate(format: "skill == %@", mySkill))
        self.skillTheme = skillTheme
    }
    
    var body: some View {
        if !theSchedule.isEmpty {
            GoalView(dayProgress: Double(dayLogs.count), weekProgress: Double(weekLogs.count), dayGoal: Double(theSchedule[0].quantity), skillTheme: skillTheme)
        }
    }
}
