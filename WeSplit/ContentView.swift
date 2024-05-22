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
                    Text("Hello, world!")
                    Text("Hello, world!")
                    Text("Hello, world!")
                    Text("Hello, world!")
                    Text("Hello, world!")
                    Text("Hello, world!")
                    Text("Hello, world!")
                    Text("Hello, world!")
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

#Preview {
    ContentView()
}
