//
//  QuickAdd.swift
//  BifocalPrototype3
//
//  Created by Henry Lightfoot on 16/09/2025.
//

import SwiftUI

struct QuickAdd: View {
    @State private var selection:SkillEntity?
    @State private var date = Date()
    @Environment(\.dismiss) var dismiss
    
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.title)]) private var skills: FetchedResults<SkillEntity>
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    HStack {
                        Text("Pick a skill:")
                        Spacer()
                        Picker("Pick a skill to log", selection: $selection) {
                            Text("None").tag(nil as SkillEntity?)
                            ForEach(skills) {
                                Text($0.unwrappedTitle)
                                    .tag($0 as SkillEntity?)
                            }
                        }
                        .pickerStyle(.menu)
                    }
                    DatePicker(
                        "Date practiced",
                        selection: $date,
                        in:...Date(),
                        displayedComponents: [.date, .hourAndMinute]
                    )
                }
                .cardStyleOne()
                Spacer()
            }
            .padding()
            .navigationTitle("Quick Log")
            .toolbar {
                Button ("cancel", systemImage: "xmark"){
                    dismiss()
                }
                Button ("save", systemImage: "checkmark"){
                    if let unwrappedSkill = selection {
                        let myLog = SkillLogged(context: CoreDataStack.shared.persistentContainer.viewContext)
                        myLog.date = date
                        myLog.id = UUID()
                        myLog.skilll = unwrappedSkill
                        CoreDataStack.shared.save()
                        dismiss()
                    }
                }
            }
        }
    }
}
