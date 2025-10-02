//
//  SkillType+Extension.swift
//  Bifocal
//
//  Created by Henry Lightfoot on 29/09/2025.
//

import Foundation

extension SkillType {
    
    public var unwrappedColor: String {
        return color ?? "accent"
    }
    public var unwrappedTitle: String {
        return title ?? "error"
    }
}
