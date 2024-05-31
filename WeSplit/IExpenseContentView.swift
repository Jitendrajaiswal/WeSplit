//
//  IExpenseContentView.swift
//  WeSplit
//
//  Created by Jaiswal, Jitendra on 31/05/24.
//

import SwiftUI

struct IExpenseContentView: View {
    @State private var expenses = Expenses()
    @State private var showingAddExpense = false
    var body: some View {
        NavigationStack {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                                   Text(item.name)
                                       .font(.headline)
                                   Text("(\(item.type))")
                                .font(.footnote)
                               }
                        Spacer()
                        Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD") )
                    }
                    .listRowSeparatorTint(.gray)
                    // .background(item.type == "Pesronal" .red : .white)
                    .padding(10)
                }
                .onDelete(perform: { indexSet in
                    removeItem(at: indexSet)
                })
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add expense", systemImage: "plus") {
//                    expenses.items.append(ExpenseItem(name: "test", type: "business", amount: 44.0))
                    showingAddExpense = true
                }
            }
            .sheet(isPresented: $showingAddExpense, content: {
                AddView(expenses: expenses)
            })
        }
    }
    func removeItem(at offset: IndexSet) {
        expenses.items.remove(atOffsets: offset)
    }
}

#Preview {
    IExpenseContentView()
}
