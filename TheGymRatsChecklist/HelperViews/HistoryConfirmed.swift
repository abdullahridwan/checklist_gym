//
//  HistoryConfirmed.swift
//  TheGymRatsChecklist
//
//  Created by Abdullah Ridwan on 3/21/22.
//

import SwiftUI

struct HistoryConfirmed: View {
    @State private var animationAmount = 1.0
    var body: some View {
        VStack {
            Text("Logged! 🥳")
                .font(.title2)
                .fontWeight(.light)
                .padding()
            Image(systemName: "chevron.compact.down")
                .animation(
                    .easeInOut(duration: 1)
                        .repeatCount(3, autoreverses: true),
                    value: animationAmount
                )
        }
        
    }
}

struct HistoryConfirmed_Previews: PreviewProvider {
    static var previews: some View {
        HistoryConfirmed()
    }
}
