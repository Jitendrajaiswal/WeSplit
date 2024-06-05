//
//  Practice2.swift
//  WeSplit
//
//  Created by Jaiswal, Jitendra on 31/05/24.
//

import SwiftUI

struct Practice2: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                ForEach(0..<100) {
                    Text("Item \($0)")
                        .font(.title)
                }
            }
        }
    }
}

#Preview {
    Practice2()
}
