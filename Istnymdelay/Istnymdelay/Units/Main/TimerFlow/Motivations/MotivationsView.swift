//
//  MotivationsView.swift
//  Istnymdelay
//
//  Created by Andrii Momot on 03.12.2024.
//

import SwiftUI

struct MotivationsView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        ZStack {
            Asset.listBg.swiftUIImage
                .resizable()
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                BackButton(title: "Motywacja")
            }
        }
    }
}

#Preview {
    MotivationsView()
}
