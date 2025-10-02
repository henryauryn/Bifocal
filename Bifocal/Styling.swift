//
//  Styling.swift
//  BifocalPrototype3
//
//  Created by Henry Lightfoot on 27/09/2025.
//

import SwiftUI

enum ThemeColor: String, CaseIterable, Identifiable {
    case themeBrown
    case themeBlue
    case themeGreen
    case themeCoral
    case accent
    
    var id: String { self.rawValue }
    
    var color: Color {
        switch self {
        case .themeBrown:
            return Color.themeBrown
        case .themeBlue:
            return Color.themeBlue
        case .themeGreen:
            return Color.themeGreen
        case .themeCoral:
            return Color.themeCoral
        case .accent:
            return Color.accentColor
        }
    }
    static func from(rawValue: String, default defaultColor: ThemeColor = .accent) -> ThemeColor {
            return ThemeColor(rawValue: rawValue) ?? defaultColor
        }
}

struct CardTitleStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.bold())
            .frame(maxWidth: .infinity, alignment: .center)
    }
}

struct CardTitle2Style: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title.bold())
            .frame(maxWidth: .infinity, alignment: .center)
    }
}
struct CardTitle2LeadingStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title.bold())
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct CardTitle3Style: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title2.bold())
            .frame(maxWidth: .infinity, alignment: .center)
    }
}

struct CardTitle4Style: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title3.bold())
            .frame(maxWidth: .infinity, alignment: .center)
    }
}

struct CardDescriptionStyle: ViewModifier {
    var backgroundColor: Color

    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundStyle(.white)
            .padding() // A single padding modifier is cleaner
            .background(backgroundColor)
            .cornerRadius(10)
    }
}

extension View {
    func cardTitleStyle() -> some View {
        self.modifier(CardTitleStyle())
    }
    
    func cardTitle2Style() -> some View {
        self.modifier(CardTitle2Style())
    }
    
    func cardTitle3Style() -> some View {
        self.modifier(CardTitle3Style())
    }
    
    func cardTitle4Style() -> some View {
        self.modifier(CardTitle4Style())
    }
    
    func cardTitle2LeadingStyle() -> some View {
        self.modifier(CardTitle2LeadingStyle())
    }

    func cardDescriptionStyle(backgroundColor: Color) -> some View {
        self.modifier(CardDescriptionStyle(backgroundColor: backgroundColor))
    }
    
    func cardStyleOne() -> some View {
            modifier(CornerCard1())
    }
    func cardStyleTwo() -> some View {
            modifier(CornerCard1())
    }
    func mantraCard() -> some View {
            modifier(MantraCard())
    }
}

struct OnboardingButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline.weight(.bold))
            .padding()
            .frame(maxWidth: .infinity)
            .foregroundStyle(.white)
            .background(.brandAccent)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
    }
}

struct CornerCard1: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(.brandBackground)
            .cornerRadius(10)
    }
}

struct CornerCard2: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(.brandBackground)
            .cornerRadius(20)
    }
}

struct MantraCard: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .font(.title3.bold())
            .foregroundStyle(.white)
            .background(.mantraAccent)
            .cornerRadius(20)
    }
}
