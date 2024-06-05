//
//  Practice.swift
//  WeSplit
//
//  Created by Jaiswal, Jitendra on 24/05/24.
//

import Observation
import SwiftUI

struct Practice: View {
    @State private var agreedToTerms = false
    @State private var agreedToPrivacyPolicy = false
    @State private var agreedToEmails = false
    @State private var sleepAmount = 8.0
    @State private var wakeUp = Date.now
    
    @State private var animationAmount = 1.0
    @State private var user = User(firstName: "jitendra", lastName: "jaiswal")
    @State private var isSheetShowing = false
    
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    
    // for userDefaults
    // @State private var tapCount = UserDefaults.standard.integer(forKey: "tap_count")
    @AppStorage("tap_count") private var tapCount = 0

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
        
        return NavigationStack {
            VStack {
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
                    ForEach(numbers, id: \.self) { i in
                        Text("Row \(i) : user tap count \(tapCount)")
                    }
                    .onDelete(perform: { indexSet in
                        removeRows(at:  indexSet)
                    })
                }
                Button("Add number"){
                    numbers.append(currentNumber)
                    currentNumber += 1
                    tapCount += 1
                    // below line not required if we use @AppStorage
                    // UserDefaults.standard.setValue(tapCount, forKey: "tap_count")
                    
                    if let data = try? JSONEncoder().encode(user) {
                        printUserDefault()
                        UserDefaults.standard.set(data, forKey: "user")
                        UserDefaults.standard.synchronize()
                        
                    }
                }
                
                Spacer()
                Section {
                    Text("Your name is \(user.firstName) \(user.lastName).")
                    
                    TextField("First name", text: $user.firstName)
                    TextField("Last name", text: $user.lastName)
                }
                
                Button("Show Sheet") {
                    withAnimation {
                        isSheetShowing = true
                    }
                }
                Image(.bird)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal) { size, axis in
                        size * 0.8
                    }
                    // .frame(width: 300, height: 300)
                    .sheet(isPresented: $isSheetShowing) {
                        SecondView()
                            .transition(.move(edge: .trailing))
                            .frame(width: 100, height: 300)
                    }
            }
            .toolbar {
                EditButton()
            }
            .onAppear(perform: printUserDefault)
        }
    }
    
    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
    
    func printUserDefault(){
        if let savedUserData = UserDefaults.standard.data(forKey: "user") {
            if let data = try? JSONDecoder().decode(User.self, from: savedUserData) {
                print("\(data.firstName) \(data.lastName)")
            }
            
        }
    }
    
    func printUserDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        for (key, value) in dictionary {
            print("\(key): \(value)")
        }
    }
}

// Coadable enables object to be stored in user default
// @Observable
struct User : Codable {
    var firstName = "Bilbo"
    var lastName = "Baggins"
}

struct SecondView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        Button("Dismiss") {
            dismiss()
        }
    }
}

#Preview {
    Practice()
}
