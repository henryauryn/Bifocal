//
//  FilteredList.swift
//  BifocalPrototype3
//
//  Created by Henry Lightfoot on 20/09/2025.
//

import SwiftUI

struct dayLogsList: View {
    let theSkill: SkillEntity
    @FetchRequest private var filteredLogs: FetchedResults<SkillLogged>
    let skillTheme: Color
    @State private var selectedLogView: SkillLogged?
    @State private var selectedLogAdd: SkillLogged?
    @State private var showingAddEntry = false
    
    
    init(mySkill: SkillEntity, selectedDate: Date, skillTheme: Color) {
        
        theSkill = mySkill
        let startDate = selectedDate
        let endDate = Calendar.current.date(byAdding: .day, value: 1, to: startDate) ?? startDate
        _filteredLogs = FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)],
                                predicate: NSPredicate(format: "skilll == %@ AND (date => %@) AND (date <= %@)", mySkill, startDate as NSDate, endDate as NSDate))
        self.skillTheme = skillTheme
    }
    
    var body: some View {
        VStack (alignment: .leading){
            if filteredLogs.isEmpty {
                Text("No logs.")
            } else {
                ForEach(filteredLogs) {log in
                        Button {
                            if log.diaryEntry != nil {
                                selectedLogView = log
                            } else {
                                selectedLogAdd = log
                            }
                        } label: {
                            HStack {
                                Label(
                                    (log.unwrappedDate).formatted(date: .omitted, time: .shortened),
                                    systemImage: "checkmark.circle.fill"
                                )
                                .foregroundStyle(skillTheme)
                                Spacer()
                                Text(log.diaryEntry != nil ? "View diary entry" : "Add diary entry")
                                Image(systemName: log.diaryEntry != nil ? "chevron.right" : "plus.circle")
                                    .font(.caption.weight(.bold))
                                    .foregroundStyle(.secondary)
                            }
                            .cardStyleOne()
                        }
                        .buttonStyle(.plain)
                        .font(.headline.bold())
                        .contextMenu {
                            Button(role: .destructive) {
                                CoreDataStack.shared.persistentContainer.viewContext.delete(log)
                                CoreDataStack.shared.save()
                                        } label: {
                                            Label("Delete", systemImage: "trash")
                                        }
                        }
                        
                }
            }
        }
        .sheet(item: $selectedLogView) { log in
                DiaryEntryView(theDiaryEntry: log.diaryEntry)
        }
        .sheet(item: $selectedLogAdd) { log in
                AddDiaryEntry(theLog: log)
        }
    }
}


