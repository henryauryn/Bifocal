//
//  BifocalPrototype3App.swift
//  BifocalPrototype3
//
//  Created by Henry Lightfoot on 14/09/2025.
//

import SwiftUI

@main
struct BifocalPrototype3App: App {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    
    @StateObject private var coreDataStack = CoreDataStack.shared
    
    init() {
        let titleAsUIColor = UIColor(Color("brandTextPrimary"))

        UINavigationBar.appearance().titleTextAttributes = [
            .foregroundColor: titleAsUIColor
        ]
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: titleAsUIColor
        ]
    }
    
    private let onboardingSteps = [
        OnboardingStep(
            systemImageName: "brain.filled.head.profile",
            title: "Hi there, I'm thrilled to meet you.",
            description: "Bifocal is here to keep you company on your DBT journey."
        ),
        OnboardingStep(
            systemImageName: "arrow.up.heart",
            title: "I'm here to help you.\nNot discipline you.",
            description: "Bifocal never wants to be a voice of criticism - you don't deserve that. "
        ),
        OnboardingStep(
            systemImageName: "calendar",
            title: "Plan your skills.\nMindfully.",
            description: "Please remember that you are always trying your best, no matter the outcome.\n\nIf things don't go quite to plan, there's always tomorrow."
        ),
        OnboardingStep(
            systemImageName: "bolt.shield",
            title: "Cope Ahead with Cope-Aheads.",
            description: "Bifocal gives you a space to think and plan for distressing situations ahead of time."
        ),
        OnboardingStep(
            systemImageName: "play.circle",
            title: "Refresh your memory.",
            description: "Look for this icon to get an on-demand walkthrough of skills you may be hazy on."
        ),
        OnboardingStep(
            systemImageName: "exclamationmark.triangle",
            title: "Bifocal is not a licensed DBT clinician.",
            description: "If you're ever in crisis please use your agreed plan.\n\nBifocal is designed to help DBT patients track their progress.\n\nBifocal is not a substitute for a full-length DBT intervention."
        )
    ]
    
    var body: some Scene {
        WindowGroup {
            if hasCompletedOnboarding {
                MainView()
                    .buttonStyle(.borderedProminent)
                    .environment(\.managedObjectContext, CoreDataStack.shared.persistentContainer.viewContext)
                    .foregroundStyle(.brandTextPrimary)
            } else {
                OnboardingView(steps: onboardingSteps)
                    .foregroundStyle(.brandTextPrimary)
            }
        }
    }
}
