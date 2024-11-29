//
//  DotsProgressView.swift
//  Istnymdelay
//
//  Created by Andrii Momot on 29.11.2024.
//

import SwiftUI

struct DotsProgressView: View {
    var progress: Double
    var numberOfDots = 24
    var primaryColor: Color = Colors.greenMiddle.swiftUIColor
    var secondaryColor: Color = Colors.greenLite.swiftUIColor
    
    var body: some View {
        ZStack {
            HStack(spacing: 5) {
                ForEach((0..<numberOfDots), id: \.self) { index in
                    let segment = 1.0 / Double(numberOfDots)
                    let value = Double(index + 1) * segment
                    let isInRange = value <= progress
                    
                    Circle()
                        .fill(isInRange ? primaryColor : secondaryColor)
                }
            }
        }
    }
}

#Preview {
    DotsProgressView(progress: 0.5)
        .padding()
}
