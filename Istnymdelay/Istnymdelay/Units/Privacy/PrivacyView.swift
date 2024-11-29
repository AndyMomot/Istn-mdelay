//
//  PrivacyView.swift
//  Apeficonnect
//
//  Created by Andrii Momot on 17.11.2024.
//

import SwiftUI

struct PrivacyView: View {
    @StateObject private var viewModel = ViewModel()
    @EnvironmentObject private var rootViewModel: RootContentView.RootContentViewModel
    @State private var isAgreed = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 12) {
                Asset.privacyLogo.swiftUIImage
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal)
                
                Asset.privacyBg.swiftUIImage
                    .resizable()
            }
            .ignoresSafeArea(edges: [.horizontal, .bottom])
            
            VStack(spacing: 20) {
                Spacer()
                
                NextButton(title: "Hotovo") {
                    DispatchQueue.main.async {
                        rootViewModel.setFlow(.main)
                    }
                }
                .disabled(!isAgreed)
                .frame(height: 44)
                .padding(.horizontal, 50)
                
                HStack(spacing: 0) {
                    Button {
                        withAnimation {
                            isAgreed.toggle()
                        }
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(.white, lineWidth: 2)
                                .scaledToFit()
                                .frame(width: 18)
                            
                            Image(systemName: "checkmark")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(.white)
                                .frame(width: 12)
                                .opacity(isAgreed ? 1 : 0)
                        }
                        .padding(10)
                    }
                    
                    Button {
                        viewModel.showPrivacyPolicy.toggle()
                    } label: {
                        Text("Souhlasím se zpracováním osobních údajů")
                            .foregroundStyle(.white)
                            .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 16))
                            .underline()
                    }
                }
            }
        }
        .sheet(isPresented: $viewModel.showPrivacyPolicy) {
            SwiftUIViewWebView(url: viewModel.privacyPolicyURL)
        }
    }
}

#Preview {
    PrivacyView()
}
