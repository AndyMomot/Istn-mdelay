//
//  SettingsButton.swift
//  Istnymdelay
//
//  Created by Andrii Momot on 03.12.2024.
//

import SwiftUI

struct SettingsButton: View {
    var title: String
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Text(title)
                Spacer()
                Image(systemName: "chevron.right")
            }
            .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 19))
            .foregroundStyle(.white)
            .padding(.vertical, 10)
        }
    }
}

#Preview {
    ZStack {
        Color.green
        SettingsButton(title: "Share") {}
            .padding()
    }
}
