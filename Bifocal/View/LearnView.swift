//
//  LearnView.swift
//  BifocalPrototype3
//
//  Created by Henry Lightfoot on 22/09/2025.
//

import SwiftUI

struct LearnView: View {
    let theInstructions: NSOrderedSet?
    
    let skillTheme: Color
    
    @Environment(\.dismiss) var dismiss
    @State private var currentStep = 0
    
    var body: some View {
        if let unwrappedInstructions = theInstructions {
            NavigationStack {
                VStack {
                        TabView(selection: $currentStep) {
                            let instructionArray = unwrappedInstructions.array as? [InstructionPage] ?? []
                            ForEach(Array(instructionArray.enumerated()), id: \.element.id) { index, page in
                                    InstructionPageView(page: page, skillTheme: skillTheme)
                                    .tag(index)
                                }
                        }
                        .tabViewStyle(.page(indexDisplayMode: .never))
                }
                .toolbar {
                    ToolbarItemGroup {
                        Button ("cancel", systemImage: "xmark"){
                            dismiss()
                        }
                        if currentStep > 0 {
                            Button ("back", systemImage: "arrow.backward"){
                                currentStep -= 1
                            }
                        }
                        Button ("next", systemImage: "\(currentStep == unwrappedInstructions.count - 1 ? "checkmark" : "arrow.forward")"){
                            if currentStep == unwrappedInstructions.count - 1 {
                                dismiss()
                            } else {
                                currentStep += 1
                            }
                        }
                    }
                }
            }
        }
    }
}

struct InstructionPageView: View {
    let page: InstructionPage
    let skillTheme: Color

    var body: some View {
        VStack {
            if let contentBlocks = page.contentBlocks?.array as? [ContentBlock] {
                ForEach(contentBlocks) { block in
                    LearningRenderer(theContent: block, skillTheme: skillTheme)
                }
            }
            Spacer()
        }
        .padding()
    }
}
