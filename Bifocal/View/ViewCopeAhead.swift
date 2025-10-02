//
//  ViewCopeAhead.swift
//  Bifocal
//
//  Created by Henry Lightfoot on 01/10/2025.
//

import SwiftUI

struct ViewCopeAhead: View {
    var theCopeAhead: CopeAhead
    @FetchRequest private var theEntries: FetchedResults<DiaryEntry>
    @State private var showingNewEntry = false
    
    init(theCopeAhead: CopeAhead) {
        self.theCopeAhead = theCopeAhead
        _theEntries = FetchRequest(sortDescriptors: [],
                                predicate: NSPredicate(format: "aboutACopeAhead == %@", theCopeAhead))
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Text("You can use this space to note down your thoughts in the period leading up to the event.")
                    .font(.title3)
                    .padding(.vertical, 3)
                    ForEach(theEntries, id: \.self) {entry in
                        Text("Entry on \((entry.date ?? Date.now).formatted(date: .long, time: .omitted)):")
                            .cardTitle3Style()
                        Text(entry.theText ?? "")
                            .cardStyleOne()
                            .contextMenu {
                                Button(role: .destructive) {
                                    CoreDataStack.shared.persistentContainer.viewContext.delete(entry)
                                    CoreDataStack.shared.save()
                                            } label: {
                                                Label("Delete", systemImage: "trash")
                                            }
                            }
                    }

            }
            .padding()
            .sheet(isPresented: $showingNewEntry) {
                AddDiaryEntry(theCopeAhead: theCopeAhead)
            }
            .navigationTitle("Diary entries")
            .toolbar {
                Button ("done", systemImage: "plus"){
                    showingNewEntry.toggle()
                }
            }
        }
        
    }
}
