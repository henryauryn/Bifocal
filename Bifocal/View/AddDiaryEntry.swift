//
//  AddDiaryEntry.swift
//  Bifocal
//
//  Created by Henry Lightfoot on 01/10/2025.
//

import SwiftUI

struct AddDiaryEntry: View {
    var theLog: SkillLogged?
    var theCopeAhead: CopeAhead?
    @State private var diaryEntry = ""
    
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            ScrollView {
                TextField("Start typing:", text: $diaryEntry, axis: .vertical)
                    .lineLimit(5...10)
                    .cardStyleOne()
                    .padding()
            }
            .navigationTitle("Add diary entry")
            .toolbar {
                Button ("cancel", systemImage: "xmark"){
                    dismiss()
                }
                Button ("save", systemImage: "checkmark"){
                    if diaryEntry != "" {
                        if let unwrappedLog = theLog {
                            let theDiaryEntry = DiaryEntry(context: CoreDataStack.shared.persistentContainer.viewContext)
                            theDiaryEntry.id = UUID()
                            theDiaryEntry.theText = diaryEntry
                            theDiaryEntry.aboutASkill = unwrappedLog
                        } else if let unwrappedCopeAhead = theCopeAhead {
                            let theDiaryEntry = DiaryEntry(context: CoreDataStack.shared.persistentContainer.viewContext)
                            theDiaryEntry.id = UUID()
                            theDiaryEntry.theText = diaryEntry
                            theDiaryEntry.date = Date.now
                            theDiaryEntry.aboutACopeAhead = unwrappedCopeAhead
                        }
                        
                        CoreDataStack.shared.save()
                        dismiss()
                    }
                }
            }
        }
        
    }
}
