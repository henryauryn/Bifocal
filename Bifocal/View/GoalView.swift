//
//  GoalSummaryView.swift
//  BifocalPrototype3
//
//  Created by Henry Lightfoot on 22/09/2025.
//

import SwiftUI

struct GoalView: View {
    let dayProgress: Double
    let weekProgress: Double
    let dayGoal: Double
    
    let skillTheme: Color
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                VStack {
                    Text("Day:")
                        .font(.title2.bold())
                    gaugeView(progress: dayProgress, goal: dayGoal, color: skillTheme)
                }
                Spacer()
                VStack {
                    Text("Week:")
                        .font(.title2.bold())
                    gaugeView(progress: weekProgress, goal: dayGoal * 7, color: skillTheme)
                }
                Spacer()
            }
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(.brandBackground)
                if dayGoal != floor(dayGoal) {
                    Text("You're aiming for \((dayGoal * 7).formatted()) uses a week, or between \(floor(dayGoal).formatted()) to \(ceil(dayGoal).formatted()) a day.")
                        .foregroundStyle(.brandTextPrimary)
                        .padding()
                } else {
                    Text("You're aiming for \(dayGoal.formatted()) uses a day, so \((dayGoal * 7).formatted()) per week.")
                        .foregroundStyle(.brandTextPrimary)
                        .padding()
                }
            }
        }
    }
}

struct gaugeView: View {
    let progress: Double
    let goal: Double
    let color: Color

    var body: some View {
        ZStack {
            Gauge(value: progress, in: 0...goal) {}
                .gaugeStyle(.accessoryCircularCapacity)
                .tint(color.gradient)
                .scaleEffect(2)
            
            VStack {
                let displayHeadline = goal > 0 ? (progress / goal).formatted(.percent.precision(.fractionLength(0))) : "--"
                Text(displayHeadline)
                    .foregroundStyle(.brandTextPrimary)
                    .font(.title.bold())
                    .lineLimit(1)
                    .minimumScaleFactor(0.1)
                
                Text("^[\(Int(progress)) use](inflect: true)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .frame(width: 100, height: 110)

    }
}
