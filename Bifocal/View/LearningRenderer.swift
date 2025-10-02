//
//  LearningRenderer.swift
//  BifocalPrototype3
//
//  Created by Henry Lightfoot on 23/09/2025.
//

import SwiftUI

struct LearningRenderer: View {
    let theContent: ContentBlock?
    let skillTheme: Color
    
    var body: some View {
        switch theContent {
        case .some(let unwrappedContent):
            switch unwrappedContent.type ?? "error" {
                case "card":
                    cardView(content: unwrappedContent.content, skillTheme: skillTheme)
                case "bulletCard":
                    bulletCardView(content: unwrappedContent.content, skillTheme: skillTheme)
                case "numberedBulletCard":
                    numberedBulletCardView(content: unwrappedContent.content, skillTheme: skillTheme)
                case "header":
                    headerView(content: unwrappedContent.content)
                case "subtitle":
                    subtitleView(content: unwrappedContent.content)
                default:
                    Text("Unknown content.")
            }
        case .none:
            Text("Unknown content.")
        }
    }
}

struct cardView: View {
    let content: String?
    let skillTheme: Color
    
    var body: some View {
        if let unwrappedContent = content {
            Text(unwrappedContent)
                .font(.headline)
                .foregroundStyle(.brandTextPrimary)
                .padding(.horizontal)
                .padding(.vertical)
                .background(skillTheme.opacity(0.4))
                .cornerRadius(10)
        }
    }
}

struct bulletCardView: View {
    let content: String?
    let skillTheme: Color
    
    var body: some View {
        if let unwrappedContent = content {
            let theLines = unwrappedContent.components(separatedBy: "\n")
            VStack (alignment: .leading) {
                ForEach(theLines, id: \.self) {line in
                    Label {
                        Text(line)
                            .font(.headline.bold())
                            .foregroundStyle(.brandTextPrimary)
                    } icon: {
                        Image(systemName: "checkmark.circle")
                            .foregroundStyle(skillTheme)
                    }
                }
            }
            .cardStyleOne()
        }
    }
}

struct numberedBulletCardView: View {
    let content: String?
    let skillTheme: Color
    
    var body: some View {
        if let unwrappedContent = content {
            let theLines = unwrappedContent.components(separatedBy: "\n")
            VStack (alignment: .leading) {
                ForEach(Array(theLines.enumerated()), id: \.element) {index, line in
                    Label {
                        Text(line)
                            .font(.headline.bold())
                            .foregroundStyle(.brandTextPrimary)
                    } icon: {
                        Image(systemName: "\(index+1).circle")
                            .foregroundStyle(skillTheme)
                    }
                }
            }
            .cardStyleOne()
        }
    }
}

struct headerView: View {
    let content: String?
    
    var body: some View {
        if let unwrappedContent = content {
            Text(unwrappedContent)
                .font(.title.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(.brandTextPrimary)
        }
    }
}


struct subtitleView: View {
    let content: String?
    
    var body: some View {
        if let unwrappedContent = content {
            Text(unwrappedContent)
                .font(.title2)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(.brandTextPrimary)
        }
    }
}
