//
//  TimerCellButton.swift
//  Istnymdelay
//
//  Created by Andrii Momot on 03.12.2024.
//

import SwiftUI

struct TimerCellButton: View {
    var imageSystemName: String
    var title: String
    var action: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            Button {
                action()
            } label: {
                Image(systemName: imageSystemName)
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.greenCustom)
                    .fontWeight(.bold)
                    .frame(width: 16, height: 16)
                    .padding(22)
                    .background(.white)
                    .clipShape(Circle())
            }

            Text(title)
                .foregroundStyle(.white)
                .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 16))
        }
    }
}

#Preview {
    ZStack {
        Color.green
        TimerCellButton(imageSystemName: "pause", title: "Pauza") {}
    }
}
