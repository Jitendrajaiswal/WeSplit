//
//  ContentView.swift
//  WeSplit
//
//  Created by Jaiswal, Jitendra on 20/05/24.
//

import SwiftUI

struct ContentView: View {
    @State private var tapCount = 0
    let students = ["Harry","Harmoine", "Ron"]
    @State private var slectedStudent = "Harry"
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Text("Hello, world!")
                }
                
                Section {
                    Text("Hello, world!")
                    Text("Hello, world!")
                }
                
                Section {
                    VStack {
                        Text("Hello...., world!")
                            .blur(radius: 2)
                        Text("Hello, world!")
                        Text("Hello, world!")
                        Text("Hello, world!")
                        Text("Hello, world!")
                        Text("Hello, world!")
                        Text("Hello, world!")
                        Text("Hello, world!")
                        CapsuleText(text: "capsule 1")
                            .foregroundColor(.red)
                        CapsuleText(text: "Capsule 2")
                    }
                    //.blur(radius: 5)
                }
                
                Picker("Selected student ", selection: $slectedStudent) {
                    
                    ForEach(students, id: \.self) {
                        Text($0)
                    }
                }
            }
            Button("TapCount \(tapCount)") {
                self.tapCount += 1
            }
            .navigationTitle("WeSplit")
            .navigationBarTitleDisplayMode(.automatic)
        }
    }
}

struct CapsuleText: View {
    var text: String

    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
            // .foregroundStyle(.white)
            .background(.blue)
            .clipShape(.capsule)
    }
}

#Preview {
    ContentView()
}
