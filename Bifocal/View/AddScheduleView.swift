//
//  AddScheduleView.swift
//  BifocalPrototype3
//
//  Created by Henry Lightfoot on 17/09/2025.
//

import SwiftUI

struct AddScheduleView: View {
    let theSkill: SkillEntity
    let skillTheme: Color
    @Environment(\.dismiss) var dismiss
    @State private var freqSelection = Frequency.daily
    @State private var quantSelection = 1
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    Picker("Frequency:", selection: $freqSelection) {
                        Text("Daily").tag(Frequency.daily)
                        Text("Weekly").tag(Frequency.weekly)
                    }
                    .pickerStyle(.segmented)
                    .padding(.vertical)
                    
                    Stepper("Frequency: \(quantSelection)", value: $quantSelection, in: 1...20)
                }
                .cardStyleOne()
                Spacer()
            }
            .padding()
            .navigationTitle("Make a plan")
            .toolbar {
                Button ("cancel", systemImage: "xmark"){
                    dismiss()
                }
                
                Button ("save", systemImage: "checkmark"){
                    let theContext = CoreDataStack.shared.persistentContainer.viewContext
                    if let oldSchedule = theSkill.schedule {
                        theContext.delete(oldSchedule)
                    }
                    
                    let mySchedule = SkillSchedule(context: theContext)
                    if freqSelection.rawValue == "daily" {
                        mySchedule.quantity = Double(quantSelection)
                    } else {
                        mySchedule.quantity = Double(quantSelection) / 7
                    }
                    
                    mySchedule.id = UUID()
                    mySchedule.skill = theSkill
                    CoreDataStack.shared.save()
                    dismiss()
                }
            }
            .tint(skillTheme)
        }
    }
}
