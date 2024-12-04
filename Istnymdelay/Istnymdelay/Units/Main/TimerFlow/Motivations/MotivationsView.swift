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
            
            VStack(alignment: .leading, spacing: 20) {
                BackButton(title: "Motywacja")
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        ForEach(viewModel.motivations) { motivation in
                            Button {
                                viewModel.motivationToShow = motivation
                                viewModel.showDetails.toggle()
                            } label: {
                                VStack(alignment: .leading, spacing: 10) {
                                    Text(motivation.title)
                                        .font(Fonts.SFProDisplay.semibold.swiftUIFont(size: 18))
                                    
                                    Text(motivation.text)
                                        .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 16))
                                        .lineLimit(1)
                                }
                                .multilineTextAlignment(.leading)
                                .foregroundStyle(.greenUltraLite)
                                .padding(20)
                                .background(.greenCustom)
                                .cornerRadius(20)
                            }
                        }
                    }
                }
                .scrollIndicators(.never)
            }
            .padding(.horizontal)
        }
        .navigationDestination(isPresented: $viewModel.showDetails) {
            if let motivation = viewModel.motivationToShow {
                MotivationDetailsView(item: motivation)
            }
        }
    }
}

#Preview {
    NavigationStack {
        MotivationsView()
    }
}
