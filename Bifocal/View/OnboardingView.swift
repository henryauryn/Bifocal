//
//  OnboardingView.swift
//  BifocalPrototype3
//
//  Created by Henry Lightfoot on 22/09/2025.
//

import SwiftUI

struct OnboardingStep: Identifiable {
    let id = UUID()
    let systemImageName: String
    let title: String
    let description: String
}

struct OnboardingView: View {
    @AppStorage("hasCompletedOnboarding") var hasCompletedOnboarding: Bool = false

    let steps: [OnboardingStep]

    @State private var currentStep = 0

    var body: some View {
        VStack {
            TabView(selection: $currentStep) {
                ForEach(steps.indices, id: \.self) { index in
                    OnboardingCardView(step: steps[index])
                        .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))

            HStack {
                if currentStep == steps.count - 1 {
                    Button("I agree") {
                        hasCompletedOnboarding = true
                    }
                    .buttonStyle(OnboardingButtonStyle())
                } else {
                    Button("Next") {
                        currentStep += 1
                    }
                    .buttonStyle(OnboardingButtonStyle())
                }
            }
            .padding(30)
        }
        .animation(.easeInOut, value: currentStep)
    }
}

struct OnboardingCardView: View {
    let step: OnboardingStep
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: step.systemImageName)
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .foregroundStyle(.brandAccent)
            
            Text(step.title)
                .font(.largeTitle.bold())
                .multilineTextAlignment(.center)
            
            Text(step.description)
                .font(.title3)
                .foregroundStyle(.brandTextPrimary)
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal, 40)
    }
}
