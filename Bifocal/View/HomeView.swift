//
//  HomeView.swift
//  BifocalPrototype3
//
//  Created by Henry Lightfoot on 21/09/2025.
//

import SwiftUI

struct HomeView: View {
    @FetchRequest(sortDescriptors: [SortDescriptor(\.title)]) private var skills: FetchedResults<SkillEntity>
    //generic time-dependant NavBar HomeScreen greeting
    private var greeting: String {
            let hour = Calendar.current.component(.hour, from: Date())

            switch hour {
            case 0..<4:
                return "Enjoy your night."
            case 6..<12:
                return "Good morning."
            case 12..<17:
                return "Good afternoon."
            case 17..<22:
                return "Good evening."
            case 22..<24:
                return "Enjoy your night."
            default:
                return "Welcome."
            }
        }
    @State private var showingQuickAdd = false
    @State private var showingSettings = false
    
    var body: some View {
        //generating the dynamic content for cardViews in the parent homeView as SwiftUI architecture means views are constantly being re-drawn and discarded and having this business logic in the cards themselves mean content can erratically change for the user as a result of something as small as a gentle scroll.
        let shuffledSkills = skills.shuffled()
        let randomSkills = Array(shuffledSkills.prefix(5))
        let thePrompt = PromptStore.allPrompts.randomElement() ?? "You are valued."
        
        NavigationStack {
            GeometryReader {geo in
                ScrollView {
                    dailyMessageCard(size: geo.size, thePrompt: thePrompt)
                    daySkillsCard(size: geo.size)
                    randomSkillsCard(size: geo.size, randomSkills: randomSkills)
                        .buttonStyle(.plain)
                    weekSummaryCard(size: geo.size)
                }
                .padding()
            }
            .navigationTitle(greeting)
            .toolbar {
                //this is the only place that iOS version-specific design choices are made because of a strange variation with SF Symbols that mean the wrench & pencil symbols render their buttons as different widths and heights in iOS < 26 with the borderedProminent buttons.
                    if #available(iOS 26.0, *) {
                        Button ("Settings", systemImage: "wrench.and.screwdriver"){
                            showingSettings.toggle()
                        }
                        Button ("Quick add", systemImage: "pencil.line"){
                            showingQuickAdd.toggle()
                        }
                    } else {
                        Button(action: {
                            showingSettings.toggle()
                        }, label: {
                            Image(systemName: "gearshape")
                                .font(.title3)
                                .foregroundStyle(.white)
                        })
                        Button(action: {
                            showingQuickAdd.toggle()
                        }, label: {
                            Image(systemName: "plus.circle")
                                .font(.title3)
                                .foregroundStyle(.white)
                        })
                    }
            }
            .sheet(isPresented: $showingSettings) {
                SettingsView()
            }
            .sheet(isPresented: $showingQuickAdd) {
                QuickAdd()
            }
        }
    }
}
