//
//  AddView.swift
//  WeSplit
//
//  Created by Jaiswal, Jitendra on 31/05/24.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    var expenses: Expenses
    
    let expenseType = ["Personal", "Business"]
    var body: some View {
        NavigationStack {
            Form {
                TextField("Enter expense name", text: $name)
                
                Picker("Select type of expense", selection: $type) {
                    ForEach(expenseType, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Enter amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add expense")
            .toolbar {
                Button("Save") {
                    let expenseItem = ExpenseItem(name: name, type: type, amount: amount)
                    expenses.items.append(expenseItem)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddView(expenses: Expenses())
}
