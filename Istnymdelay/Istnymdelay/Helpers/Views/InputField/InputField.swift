//
//  CreateBicycleField.swift
//
//  Created by Andrii Momot on 26.10.2024.
//

import SwiftUI

struct InputField: View {
    var title: String
    var placeholder: String?
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 19))
                .foregroundStyle(.white)
            
            TextField(text: $text) {
                if let placeholder {
                    Text(placeholder)
                        .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 16))
                        .foregroundStyle(.darkBlueGreen.opacity(0.5))
                }
            }
            .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 16))
            .foregroundStyle(.darkBlueGreen)
            .padding(.horizontal, 12)
            .padding(.vertical, 16)
            .background(.white)
            .cornerRadius(8, corners: .allCorners)
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
            }
        }
    }
}

#Preview {
    ZStack {
        Color.green
        InputField(title: "Typ",
                   placeholder: "Type the text",
                   text: .constant(""))
        .padding()
    }
}
