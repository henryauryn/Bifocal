//
//  DiaryEntryView.swift
//  Bifocal
//
//  Created by Henry Lightfoot on 01/10/2025.
//

import SwiftUI

struct DiaryEntryView: View {
    @Environment(\.dismiss) var dismiss
    let theDiaryEntry: DiaryEntry?
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if let unwrappedDiary = theDiaryEntry {
                    Text(unwrappedDiary.theText ?? "error")
                        .cardStyleOne()
                        .padding()
                }
            }
            .navigationTitle("View your diary entry")
            .toolbar {
                Button ("delete", systemImage: "trash.fill"){
                    if let unwrappedEntry = theDiaryEntry {
                        CoreDataStack.shared.persistentContainer.viewContext.delete(unwrappedEntry)
                        CoreDataStack.shared.save()
                        dismiss()
                    }
                }
                .tint(.red)
            }
        }
    }
}

