//
//  CopeAhead+Extension.swift
//  Bifocal
//
//  Created by Henry Lightfoot on 29/09/2025.
//

import Foundation

extension CopeAhead {
    public var unwrappedTitle: String {
        return title ?? "error"
    }
    
    public var unwrappedDesc: String {
        return desc ?? "error"
    }
}
