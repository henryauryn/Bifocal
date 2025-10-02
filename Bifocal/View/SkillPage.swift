//
//  SkillPage.swift
//  BifocalPrototype3
//
//  Created by Henry Lightfoot on 17/09/2025.
//

import SwiftUI

struct SkillPage: View {
    @State private var showingLogSheet = false
    @State private var showingScheduleSheet = false
    @State private var showNoLearnAlert = false
    @State private var showingLearnSheet = false

    let theSkill: SkillEntity
    let skillTheme: Color
    let instructionPages: NSOrderedSet?
    
    init(theSkill: SkillEntity, skillTheme: Color) {
        self.theSkill = theSkill
        self.skillTheme = skillTheme
        let localSkill = theSkill
        instructionPages = localSkill.instructions
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                    Text(theSkill.unwrappedFullTitle)
                        .cardTitleStyle()
                    Text(theSkill.unwrappedDesc)
                        .cardDescriptionStyle(backgroundColor: skillTheme)
                    ScheduleLogViewModel(theSkill: theSkill, skillTheme: skillTheme)
            }
            .padding()
            .toolbar {
                    Button ("play", systemImage: "play"){
                        if let unwrapped = instructionPages, unwrapped.count > 0 {
                            showingLearnSheet.toggle()
                        } else {
                            showNoLearnAlert.toggle()
                        }
                    }
                    .alert("Coming soon", isPresented: $showNoLearnAlert) {
                                Button("OK", role: .cancel) { }
                            } message: {
                                Text("No content found for this skill.")
                            }
                    .sheet(isPresented: $showingLearnSheet) {
                        LearnView(theInstructions: instructionPages, skillTheme: skillTheme)
                    }
                    Button ("schedule", systemImage: "calendar"){
                        showingScheduleSheet.toggle()
                    }
                    .sheet(isPresented: $showingScheduleSheet) {
                        AddScheduleView(theSkill: theSkill, skillTheme: skillTheme)
                    }
                    Button ("Quick log", systemImage: "pencil.line"){
                        showingLogSheet.toggle()
                    }
                    .sheet(isPresented: $showingLogSheet) {
                        AddLogView(skillTheme: skillTheme, theSkill: theSkill)
                    }
            }
            .tint(skillTheme)
        }
    }
}
