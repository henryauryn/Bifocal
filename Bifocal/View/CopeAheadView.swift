//
//  CopeAheadView.swift
//  BifocalPrototype3
//
//  Created by Henry Lightfoot on 21/09/2025.
//

import SwiftUI

struct CopeAheadView: View {
    @FetchRequest(sortDescriptors: [SortDescriptor(\.title)]) private var copeAheads: FetchedResults<CopeAhead>
    
    @State private var showingNewCopeAhead = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if copeAheads.isEmpty {
                    Text("Cope-Aheads can help future-you navigate really painful situations.\n\nClick the 'add' button to get started.")
                        .font(.title3)
                        .foregroundStyle(.brandTextPrimary)
                        .padding()
                }
                ForEach(copeAheads) {copeAhead in
                    NavigationLink(destination: ViewCopeAhead(theCopeAhead: copeAhead)) {
                        CopeCardView(theCopeAhead: copeAhead)
                            .padding()
                            .contextMenu {
                                Button(role: .destructive) {
                                    CoreDataStack.shared.persistentContainer.viewContext.delete(copeAhead)
                                    CoreDataStack.shared.save()
                                            } label: {
                                                Label("Delete", systemImage: "trash")
                                            }
                            }
                    }
                    .buttonStyle(.plain)
                }
            }
            .navigationTitle("Cope-Aheads")
            .toolbar {
                Button ("New Cope-Ahead", systemImage: "plus"){
                    showingNewCopeAhead.toggle()
                }
                .sheet(isPresented: $showingNewCopeAhead) {
                    AddCopeAhead()
                        .interactiveDismissDisabled(true)
                }
            }
        }
    }
}

struct CopeCardView : View {
    let theCopeAhead: CopeAhead

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(theCopeAhead.unwrappedTitle)
                .font(.title3.bold())
                .foregroundStyle(.white)
            Text("When: \((theCopeAhead.date ?? Date.now).formatted(date: .abbreviated, time: .omitted))")
                .foregroundStyle(.white)
                .bold()
            Text(theCopeAhead.unwrappedDesc)
                .font(.subheadline)
                .foregroundStyle(.white)
            Divider()
                .padding(.vertical, 4)
            
            if let theSkills = theCopeAhead.skills as? Set<SkillEntity> {
                let skillsArray = theSkills.sorted {$0.unwrappedTitle < $1.unwrappedTitle}
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(skillsArray, id: \.self) {skill in
                            staticPill(text: skill.unwrappedTitle, style: 0)
                        }
                    }
                }
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.brandAccent.opacity(0.8))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(.brandAccent.opacity(0.3), lineWidth: 1)
        )
    }
}
