//
//  Practice.swift
//  WeSplit
//
//  Created by Jaiswal, Jitendra on 24/05/24.
//

import SwiftUI

struct Practice: View {
    @State private var agreedToTerms = false
        @State private var agreedToPrivacyPolicy = false
        @State private var agreedToEmails = false
    @State private var sleepAmount = 8.0
    @State private var wakeUp = Date.now

        var body: some View {
            let agreedToAll = Binding<Bool>(
                get: {
                    agreedToTerms && agreedToPrivacyPolicy && agreedToEmails
                },
                set: {
                    agreedToTerms = $0
                    agreedToPrivacyPolicy = $0
                    agreedToEmails = $0
                }
            )

            return VStack {
                Toggle("Agree to terms", isOn: $agreedToTerms)
                Toggle("Agree to privacy policy", isOn: $agreedToPrivacyPolicy)
                Toggle("Agree to receive shipping emails", isOn: $agreedToEmails)
                Toggle("Agree to all", isOn: agreedToAll)
                
                Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12)
                DatePicker("Please select date time", selection: $wakeUp,
                           in: Date.now...)
                    .labelsHidden()
                Text(Date.now, format: .dateTime.hour().minute())
                Text(Date.now, format: .dateTime.day().month().year())
                Text(Date.now, format: .dateTime.year().month().day())
                
                List {
                    ForEach(1..<5) { i in
                        Section("Section \(i)") {
                                Text("Static row 1")
                                Text("Static row 2")
                            }
                        Text("Hello World")
                        Text("Hello World")
                        Text("Hello World")
                    }
                }
            }
        }
}

#Preview {
    Practice()
}
