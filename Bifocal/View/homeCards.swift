//
//  homeCards.swift
//  Bifocal
//
//  Created by Henry Lightfoot on 27/09/2025.
//

import SwiftUI

struct daySkillsCard: View {
    let size: CGSize
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)],
                  predicate: NSPredicate(format: "(date => %@) AND (date <= %@)", Calendar.current.startOfDay(for: Date.now) as NSDate, (Calendar.current.date(byAdding: .day, value: 1, to: Calendar.current.startOfDay(for: Date.now)) ?? Date.now) as NSDate)) private var filteredLogs: FetchedResults<SkillLogged>

    var body: some View {
            VStack {
                Text("Today's progress:")
                    .cardTitle2Style()
                
                if filteredLogs.isEmpty {
                    VStack {
                        HStack {
                            Spacer()
                            Image(systemName: "brain")
                                .resizable()
                                .scaledToFit()
                                .frame(width: size.width * 0.15)
                            Spacer()
                        }
                        HStack {
                            Spacer()
                            Text("Log some skills today for them to show up here!")
                                .multilineTextAlignment(.center)
                                .frame(width: size.width * 0.6)
                            Spacer()
                        }
                    }
                    .foregroundStyle(.brandAccent)
                    
                } else {
                    ScrollView {
                        LazyVStack {
                            ForEach(filteredLogs) {log in
                                    HStack {
                                        Image(systemName: "checkmark.circle.fill")
                                        Text((log.unwrappedDate).formatted(.dateTime.hour().minute()))
                                            .bold()
                                        Spacer()
                                        Text(log.skilll?.unwrappedTitle ?? "error")
                                            .bold()
                                    }
                                    .foregroundStyle(.brandAccent)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding()
                                    .background(.white)
                                    .cornerRadius(10)
                                    .contextMenu {
                                        Button(role: .destructive) {
                                            CoreDataStack.shared.persistentContainer.viewContext.delete(log)
                                            CoreDataStack.shared.save()
                                        } label: {
                                                Label("Delete", systemImage: "trash")
                                        }
                                    }
                            }
                        }
                    }
                    .frame(maxHeight: size.height * 0.3)
                }
            }
            .cardStyleTwo()
        
    }
}

struct randomSkillsCard: View {
    let size: CGSize
    
    let randomSkills: [FetchedResults<SkillEntity>.Element]

    var body: some View {
            VStack {
                Text("At your fingertips:")
                    .cardTitle2Style()
                if randomSkills.isEmpty {
                    
                } else {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(randomSkills) {skill in
                                SkillButtonView(theSkill: skill, screenWidth: size.width, paddingNeeded: false)
                                    .buttonStyle(.plain)
                            }
                        }
                    }
                    
                }
            }
            .cardStyleTwo()
        
    }
}

struct dailyMessageCard: View {
    let size: CGSize
    let thePrompt: String
    var body: some View {
            VStack {
                Text(thePrompt)
                    .foregroundStyle(.white)
                    .cardTitle3Style()
            }
            .padding()
            .frame(maxWidth: size.width * 0.8, alignment: .center)
            .background(.brandAccent)
            .cornerRadius(20)
        
    }
}

struct weekSummaryCard: View {
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .forward)],
                  predicate: NSPredicate(format: "(date => %@) AND (date <= %@)", Date.now.startOfWeek as NSDate, Date.now.endOfWeek as NSDate)) private var filteredLogs: FetchedResults<SkillLogged>
    let size: CGSize
    var body: some View {
            VStack {
                Text("Your week so far:")
                    .cardTitle2Style()
                if filteredLogs.isEmpty {
                    VStack {
                        HStack {
                            Spacer()
                            Image(systemName: "sunrise")
                                .resizable()
                                .scaledToFit()
                                .frame(width: size.width * 0.15)
                            Spacer()
                        }
                        HStack {
                            Spacer()
                            Text("Log some skills this week for them to show up here!")
                                .multilineTextAlignment(.center)
                                .frame(width: size.width * 0.6)
                            Spacer()
                        }
                    }
                    .foregroundStyle(.brandAccent)
                    
                } else {
                    let mappedLogs = Dictionary(grouping: filteredLogs) {log in
                        Calendar.current.startOfDay(for: log.unwrappedDate)
                    }
                    var sortedKeys: [Date] {
                        mappedLogs.keys.sorted(by: <)
                    }
                    ForEach(sortedKeys, id: \.self) {key in
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                            Text(key.formatted(.dateTime.weekday(.wide)))
                                .bold()
                            Spacer()
                            Text("^[\(mappedLogs[key]?.count ?? 0) log](inflect: true)")
                                .bold()
                        }
                        .foregroundStyle(.brandAccent)
                    }
                }
            }
            .cardStyleTwo()
    }
}
