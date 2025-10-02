//
//  AddCopeAhead.swift
//  BifocalPrototype3
//
//  Created by Henry Lightfoot on 26/09/2025.
//

import SwiftUI

enum Field: Hashable {
        case name, description
    }

struct AddCopeAhead: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var nameInput = ""
    @State private var descInput = ""
    @State private var userSelection = 0
    @State private var dateInput = Date.now
    
    @FocusState private var focusedField: Field?
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.title)]) var allSkills: FetchedResults<SkillEntity>
    @FetchRequest(sortDescriptors: [SortDescriptor(\.title)]) private var types: FetchedResults<SkillType>
    
    let columns = Array(repeating: GridItem(.flexible()), count: 2)
    
    @State private var selectedSkills: [SkillEntity] = []
    @State private var unSelectedSkills: [SkillEntity] = []
    
    private var currentTitle: String {
            switch userSelection {
            case 0:
                return "New Cope-Ahead"
            case 1:
                return "Plan your skills"
            case 2:
                return "Summary"
            default:
                return ""
            }
        }

    var body: some View {
        NavigationStack {
            TabView(selection: $userSelection) {
                VStack {
                    Text("Name the facts of the situation.")
                        .font(.subheadline)
                        .padding()
                    TextField("Name:", text: $nameInput)
                        .focused($focusedField, equals: .name)
                        .cardStyleOne()
                    DatePicker(
                        "Date of event:",
                        selection: $dateInput,
                        in:Date()...,
                        displayedComponents: [.date]
                    )
                    .cardStyleOne()
                    TextField("Description:", text: $descInput, axis: .vertical)
                        .lineLimit(5...10)
                        .focused($focusedField, equals: .description)
                        .cardStyleOne()
                    Spacer()
                }
                .tag(0)
                .toolbar {
                    if focusedField != nil {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button("Done") {
                                focusedField = nil
                            }
                            .foregroundStyle(.brandAccent)
                            .buttonStyle(.plain)
                        }
                    }
                }
                ScrollView {
                    VStack {
                        ForEach(selectedSkills) {skill in
                            if let typeOfSkill = skill.type {
                                clickablePill(text: skill.unwrappedTitle, isSelected: true, skillColor: ThemeColor.from(rawValue: typeOfSkill.unwrappedColor).color, onClick: {
                                    if let skillIsHere = selectedSkills.firstIndex(of: skill) {
                                        selectedSkills.remove(at: skillIsHere)
                                        unSelectedSkills.append(skill)
                                    }
                                })
                            }
                        }
                        LazyVGrid(columns: columns) {
                            ForEach(unSelectedSkills) {skill in
                                if let typeOfSkill = skill.type {
                                    clickablePill(text: skill.unwrappedTitle, isSelected: false, skillColor: ThemeColor.from(rawValue: typeOfSkill.unwrappedColor).color, onClick: {
                                        selectedSkills.append(skill)
                                        if let skillIsHere = unSelectedSkills.firstIndex(of: skill) {
                                            unSelectedSkills.remove(at: skillIsHere)
                                        }
                                    })
                                    .buttonStyle(.plain)
                                }
                            }
                        }
                        
                    }
                }
                .tag(1)
                VStack {
                    if !nameInput.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty, !descInput.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty, !selectedSkills.isEmpty {
                        HStack {
                            Text("Name:")
                            Spacer()
                            Text("\(nameInput)")
                                .foregroundStyle(.brandAccent)
                        }
                        .cardStyleOne()
                        HStack {
                            Text("Description:")
                            Spacer()
                            Text("\(descInput.trimmingCharacters(in: .whitespacesAndNewlines))")
                                .foregroundStyle(.brandAccent)
                        }
                        .cardStyleOne()
                        VStack {
                            HStack {
                                Text("Chosen skills:")
                                Spacer()
                            }
                            ForEach(selectedSkills) {skill in
                                staticPill(text: skill.unwrappedTitle, style: 1)
                            }
                        }
                        .cardStyleOne()
                    } else {
                        Text("Please review the previous pages: data for your Cope-Ahead is missing.")
                    }
                }
                .tag(2)
            }
            .onAppear {
                let unsortedSkills = Array(allSkills)
                unSelectedSkills = unsortedSkills.sorted {
                    let type1 = $0.type?.unwrappedTitle ?? ""
                    let type2 = $1.type?.unwrappedTitle ?? ""
                    return type1 < type2
                }
            }
            .onChange(of: userSelection,) { newValue in
                focusedField = nil
            }
            .onChange(of: unSelectedSkills) { newValue in
                unSelectedSkills = newValue.sorted {
                    let type1 = $0.type?.unwrappedTitle ?? ""
                    let type2 = $1.type?.unwrappedTitle ?? ""
                    return type1 < type2
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .padding()
            .navigationTitle(currentTitle)
            .toolbar {
                Button ("cancel", systemImage: "xmark"){
                    dismiss()
                }
                if userSelection > 0 {
                    Button ("back", systemImage: "arrow.backward"){
                        userSelection -= 1
                    }
                }
                Button ("next", systemImage: "\(userSelection == 2 ? "checkmark" : "arrow.forward")"){
                    if userSelection == 2 {
                        if nameInput != "", descInput != "", !selectedSkills.isEmpty {
                            let newCopeAhead = CopeAhead(context: CoreDataStack.shared.persistentContainer.viewContext)
                            newCopeAhead.id = UUID()
                            newCopeAhead.title = nameInput
                            newCopeAhead.desc = descInput
                            newCopeAhead.date = dateInput
                            newCopeAhead.skills = NSSet(array: selectedSkills)
                            CoreDataStack.shared.save()
                            dismiss()
                        } else {
                            dismiss()
                        }
                            
                    } else {
                        userSelection += 1
                    }
                }
            }
        }
    }
}

