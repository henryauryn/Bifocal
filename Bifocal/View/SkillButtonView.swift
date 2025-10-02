//
//  SkillButtonView.swift
//  BifocalPrototype3
//
//  Created by Henry Lightfoot on 17/09/2025.
//

import SwiftUI

struct SkillButtonView: View {
    
    let theSkill: SkillEntity
    let screenWidth: CGFloat
    let skillTheme: Color
    let paddingNeeded: Bool
    
    init(theSkill: SkillEntity, screenWidth: CGFloat, paddingNeeded: Bool) {
        self.theSkill = theSkill
        self.screenWidth = screenWidth
        self.skillTheme = ThemeColor.from(rawValue: theSkill.type?.unwrappedColor ?? "accent").color
        self.paddingNeeded = paddingNeeded
    }
    
    var body: some View {
        NavigationLink(destination: SkillPage(theSkill: theSkill, skillTheme: skillTheme)) {
            VStack {
                ZStack {
                    Circle()
                        .frame(width: screenWidth*0.225)
                        .foregroundStyle(skillTheme)
                    if symbolExists(named: theSkill.unwrappedSymbol) {
                        Image(systemName: theSkill.unwrappedSymbol)
                            .font(.system(size: screenWidth * 0.13))
                            .foregroundStyle(.white)
                    }
                    
                    
                    
                }
                Text(theSkill.unwrappedTitle)
                    .font(.caption)
                    .foregroundStyle(.brandTextSecondary)
                    .lineLimit(1)
            }
            .frame(maxWidth: screenWidth*0.225)
        }
    }
}

func symbolExists(named symbolName: String) -> Bool {
    // THIS IS THE FIX:
    // First, ensure the string itself is not empty. This is a cheap and error-free check.
    guard !symbolName.isEmpty else { return false }
    
    // Only if the string is valid do we ask the system if the symbol exists.
    return UIImage(systemName: symbolName) != nil
}
