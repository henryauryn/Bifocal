//
//  SettingsView.swift
//  BifocalPrototype3
//
//  Created by Henry Lightfoot on 21/09/2025.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("About")) {
                    Text("Version 1.00 (build 5) \nAll rights reserved. \nHenry Lightfoot © 2025")
                }
                Section(header: Text("Important Guidance")) {
                    Text("Disclaimer: This application is intended for informational and educational purposes only. The content is not intended to be a substitute for professional medical advice, diagnosis, or treatment. Always seek the advice of your physician or other qualified health provider with any questions you may have regarding a medical condition. Never disregard professional medical advice or delay in seeking it because of something you have read on this application. This app does not create a therapist-patient relationship.")
                }
                Section(header: Text("Acknowledgements & Attribution")) {
                    Text("Dialectical Behavior Therapy was developed by Dr. Marsha Linehan. \n\nThe skills and concepts presented in this app are based on the principles outlined in Dr. Linehan's foundational texts, including the DBT® Skills Training Manual, Second Edition. \n\nThis application is an independent project and is not affiliated with, sponsored by, or endorsed by Dr. Marsha Linehan, Behavioral Tech, LLC, or The Linehan Institute. It is designed as an educational tool to support your learning of DBT skills and is not a substitute for professional therapy.")
                }
            }
            .navigationTitle("Settings")
            .toolbar {
                Button ("done", systemImage: "checkmark"){
                    dismiss()
                }
            }
        }
    }
}
