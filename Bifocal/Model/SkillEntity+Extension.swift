//
//  SkillEntity+Extension.swift
//  Bifocal
//
//  Created by Henry Lightfoot on 29/09/2025.
//

import Foundation

extension SkillEntity {
    
    public var unwrappedTitle: String {
        return title ?? "error"
    }
    
    public var unwrappedSymbol: String {
        return symbol ?? "questionmark.circle.dashed"
    }
    
    public var unwrappedFullTitle: String {
        return fullTitle ?? title ?? "error"
    }
    
    public var unwrappedDesc: String {
        return desc ?? "error"
    }
}
