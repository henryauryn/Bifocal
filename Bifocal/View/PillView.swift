//
//  PillView.swift
//  BifocalPrototype3
//
//  Created by Henry Lightfoot on 26/09/2025.
//

import SwiftUI


struct clickablePill: View {
    let text: String
    let isSelected: Bool
    let skillColor: Color
    let onClick: () -> Void


    var body: some View {
        HStack(spacing: 4) {
            
            Button(action: onClick) {
                Text(text)
                    .lineLimit(1)
                Image(systemName: isSelected ? "checkmark.circle" : "plus.circle.fill")
            }
            .foregroundStyle(.white)
        }
        .font(.subheadline)
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        .foregroundStyle(isSelected ? .white : .primary)
        .background(isSelected ? .brandAccent : skillColor)
        .clipShape(Capsule())
    }
}

struct staticPill: View {
    let text: String
    let style: Int

    var body: some View {
        HStack(spacing: 4) {
            switch style {
                case 1:
                    Text(text)
                        .font(.subheadline.weight(.medium))
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(.clear)
                        .padding(2)
                        .background(.brandAccent)
                        .clipShape(Capsule())
                default:
                    Text(text)
                        .font(.subheadline.weight(.medium))
                        .foregroundColor(.darkDate)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(.clear)
                        .padding(2)
                        .background(.white)
                        .clipShape(Capsule())
            }
            
        }
    }
}



