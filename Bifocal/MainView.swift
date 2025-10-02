//
//  MainView.swift
//  BifocalPrototype3
//
//  Created by Henry Lightfoot on 16/09/2025.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            CopeAheadView()
                .tabItem {
                    Label("Cope-Aheads", systemImage: "bolt.shield")
                }
            SkillsPage()
                .tabItem {
                    Label("Skills", systemImage: "wrench.adjustable.fill")
                }
            }
            .tint(.brandAccent)
    }
}
