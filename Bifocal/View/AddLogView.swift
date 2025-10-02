//
//  AddLogView.swift
//  BifocalPrototype3
//
//  Created by Henry Lightfoot on 17/09/2025.
//

import SwiftUI

struct AddLogView: View {
    @Environment(\.dismiss) var dismiss
    let skillTheme: Color
    
    @State private var date = Date.now
    @State private var diaryEntry = ""
    let theSkill: SkillEntity
    
    var body: some View {
        

        NavigationStack {
            VStack {
                VStack {
                    DatePicker(
                        "Date and time:",
                        selection: $date,
                        in:...Date(),
                        displayedComponents: [.date, .hourAndMinute]
                    )
                    .cardStyleOne()
                    Text("Diary entry:")
                    TextField("Start typing:", text: $diaryEntry, axis: .vertical)
                        .lineLimit(5...10)
                        .cardStyleOne()
                }
                Spacer()
            }
            .padding()
            .navigationTitle("Log a skill")
            .toolbar {
                Button ("cancel", systemImage: "xmark"){
                    dismiss()
                }
                Button ("save", systemImage: "checkmark"){
                    let theLog = SkillLogged(context: CoreDataStack.shared.persistentContainer.viewContext)
                    theLog.id = UUID()
                    theLog.date = date
                    theLog.skilll = theSkill
                    
                    if !diaryEntry.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        let theDiaryEntry = DiaryEntry(context: CoreDataStack.shared.persistentContainer.viewContext)
                        theDiaryEntry.id = UUID()
                        theDiaryEntry.theText = diaryEntry
                        theDiaryEntry.aboutASkill = theLog
                    }
                    CoreDataStack.shared.save()
                    dismiss()
                }
            }
            .tint(skillTheme)
        }
        
        
    }
}


