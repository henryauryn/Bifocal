//
//  SkillLogged+Extension.swift
//  Bifocal
//
//  Created by Henry Lightfoot on 29/09/2025.
//

import Foundation

extension SkillLogged {
    public var unwrappedDate: Date {
        return date ?? Date.now
    }
}
