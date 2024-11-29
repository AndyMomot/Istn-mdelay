//
//  DynamicHeightTextField.swift
//  Chainestery
//
//  Created by Andrii Momot on 21.08.2024.
//

import SwiftUI

struct DynamicHeightTextField: View {
    var title: String
    var placeholder: String = "Napisz tekst"
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 16))
            
            ZStack(alignment: .topLeading) {
                TextEditor(text: $text)
                    .scrollContentBackground(.hidden)
                    .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 16))
                    .padding()
                
                if text.isEmpty {
                    Text(placeholder)
                        .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 16))
                        .padding(.horizontal, 20)
                        .padding(.vertical, 26)
                        .allowsHitTesting(false)
                }
            }
            .cornerRadius(20, corners: .allCorners)
            .overlay {
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.black, lineWidth: 1)
            }
        }
    }
}

#Preview {
    ZStack {
        Color.gray
        DynamicHeightTextField(
            title: "Uwaga do projektu",
            text: .constant(""))
        .frame(maxHeight: 117)
        .padding()
    }
}
