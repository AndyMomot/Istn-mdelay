//
//  OnboardingView.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 12.06.2024.
//

import SwiftUI

struct OnboardingView: View {
    var item: OnboardingView.OnboardingItem
    @Binding var currentPageIndex: Int
    
    @EnvironmentObject private var rootViewModel: RootContentView.RootContentViewModel
    @StateObject private var viewModel = OnboardingViewModel()
    
    var body: some View {
        ZStack {
            Image(item.image)
                .resizable()
                .ignoresSafeArea(edges: [.horizontal, .bottom])
            
            VStack(spacing: 70) {
                Spacer()
                
                VStack {
                    Text(item.text)
                        .foregroundStyle(.white)
                        .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 16))
                        .multilineTextAlignment(.center)
                    
                    HStack(spacing: 10) {
                        Spacer()
                        ForEach(0..<3, id: \.self) { index in
                            let isCurrent = index == item.rawValue
                            
                            Circle()
                                .fill(isCurrent ? Color.greenLite : .white)
                                .frame(width: 17)
                        }
                        Spacer()
                    }
                }
                .padding(.horizontal, 26)
                .padding(.vertical, 10)
                .background(Color.greenCustom)
                
                NextButton(title: "Další") {
                    withAnimation {
                        currentPageIndex = item.next.rawValue
                    }
                    
                    if item == .third {
                        viewModel.showPrivacyPolicy.toggle()
                    }
                }
                .frame(height: 44)
                .padding(.horizontal, 26)
            }
        }
        .navigationDestination(isPresented: $viewModel.showPrivacyPolicy) {
            PrivacyView()
        }
        .fullScreenCover(isPresented: $viewModel.showPrivacyPolicy) {
            PrivacyView()
        }
    }
}

#Preview {
    OnboardingView(item: .third, currentPageIndex: .constant(2))
}
