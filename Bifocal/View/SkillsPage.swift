//
//  SkillView.swift
//  BifocalPrototype3
//
//  Created by Henry Lightfoot on 16/09/2025.
//

import SwiftUI

struct SkillsPage: View {
    let columns = Array(repeating: GridItem(.flexible()), count: 3)
    @FetchRequest(sortDescriptors: [SortDescriptor(\.title)]) private var types: FetchedResults<SkillType>
    
    var body: some View {
        GeometryReader {geometry in
            NavigationStack {
                ScrollView {
                    ForEach(types) {type in
                        LazyVStack (spacing: 20) {
                            DisclosureGroup() {
                                LazyVGrid(columns: columns) {
                                    if let theSkills = type.skills?.allObjects as? [SkillEntity] {
                                        let sortedSkills = theSkills.sorted(by: { lhs, rhs in
                                            return (lhs.title ?? " ") < (rhs.title ?? " ")
                                        })
                                        ForEach(sortedSkills) {skill in
                                            SkillButtonView(theSkill: skill, screenWidth: geometry.size.width, paddingNeeded: false)
                                                .buttonStyle(.plain)
                                        }
                                    }
                                }
                            } label: {
                                Text(type.unwrappedTitle)
                                    .cardTitle3Style()
                                    .padding()
                            }
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 25).fill(Color(.brandBackground)))
                    }
                }
                .navigationTitle("Skills")
                .padding()
            }
        }
    }
}
