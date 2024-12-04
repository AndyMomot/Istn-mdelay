//
//  TimersView.swift
//  Istnymdelay
//
//  Created by Andrii Momot on 03.12.2024.
//

import SwiftUI

struct TimersView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Asset.listBg.swiftUIImage
                    .resizable()
                    .ignoresSafeArea()
                
                VStack(spacing: 10) {
                    HStack {
                        BackButton(title: "Timer", canDismiss: false)
                        Spacer()
                        Button {
                            viewModel.showMotivation = true
                        } label: {
                            Image(systemName: "star")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(.white)
                                .frame(width: 39)
                        }
                    }
                    .padding(.horizontal)
                    
                    if !viewModel.tasks.isEmpty {
                        TimersTabView(
                            currentPageIndex: $viewModel.currentPageIndex,
                            items: viewModel.tasks) { action in
                                viewModel.handleCell(action: action)
                            }
                        
                        Text("\(viewModel.currentPageIndex + 1) / \(viewModel.tasks.count)")
                            .foregroundStyle(.white)
                            .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 23))
                            .padding(.horizontal)
                    } else {
                        Text("Nie znaleziono rozpoczętych zadań")
                            .foregroundStyle(.white)
                            .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 23))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                        Spacer()
                    }
                }
                .padding(.bottom)
            }
            .onAppear {
                viewModel.getTasks()
            }
            .navigationDestination(isPresented: $viewModel.showMotivation) {
                MotivationsView()
            }
        }
    }
}

#Preview {
    TimersView()
}
