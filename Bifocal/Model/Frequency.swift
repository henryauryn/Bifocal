//
//  Frequency.swift
//  BifocalPrototype3
//
//  Created by Henry Lightfoot on 16/09/2025.
//

import Foundation
enum Frequency: String, CaseIterable, Identifiable {
    case daily, weekly
    var id: String {self.rawValue}
}
