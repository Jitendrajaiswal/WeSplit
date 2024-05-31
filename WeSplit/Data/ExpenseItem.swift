//
//  ExpenseItem.swift
//  WeSplit
//
//  Created by Jaiswal, Jitendra on 31/05/24.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
