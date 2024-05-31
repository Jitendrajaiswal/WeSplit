//
//  Expenses.swift
//  WeSplit
//
//  Created by Jaiswal, Jitendra on 31/05/24.
//

import Foundation

@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItem = UserDefaults.standard.data(forKey: "Items") {
            if let items = try? JSONDecoder().decode([ExpenseItem].self, from: savedItem) {
                self.items = items
                return
            }
            items = []
        }
    }
}
