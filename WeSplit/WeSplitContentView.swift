//
//  WeSplitContentView.swift
//  WeSplit
//
//  Created by Jaiswal, Jitendra on 20/05/24.
//

import SwiftUI

struct WeSplitContentView: View {
    @State private var checkAmaount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    var totalAmountSpent : Double {
        let tipAmount = Double(tipPercentage) / 100 * checkAmaount
        return checkAmaount + tipAmount
    }
    
    var amountPerHead : Double {
        return totalAmountSpent / Double(numberOfPeople + 2)
    }
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmaount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) People")
                        }
                    }
                }
                
                Section("How much do you want to tip? ") {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text("\($0)%")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Total amount spend") {
                    Text(totalAmountSpent, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .foregroundStyle(tipPercentage == 0 ? .red : .black)
                        
                }
                Section("Amount per person") {
                    Text(amountPerHead, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    WeSplitContentView()
}
