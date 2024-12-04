//
//  StatisticsView.swift
//  Istnymdelay
//
//  Created by Andrii Momot on 04.12.2024.
//

import SwiftUI

struct StatisticsView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Asset.listBg.swiftUIImage
                    .resizable()
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    HStack {
                        BackButton(title: "Statistics", canDismiss: false)
                        Button {
                            viewModel.showQuests.toggle()
                        } label: {
                            Asset.cup.swiftUIImage
                        }
                    }
                    
                    ScrollView {
                        VStack(spacing: 20) {
                            // Charts
                            HStack(alignment: .top, spacing: 20) {
                                VStack(spacing: 10) {
                                    CircularProgressBar(
                                        progress: viewModel.productiveTimePercent,
                                        showProgress: true,
                                        trackColor: .greenCustom,
                                        progressColor: .greenLite,
                                        lineWidth: 30,
                                        textColor: .white,
                                        font: Fonts.SFProDisplay.bold.swiftUIFont(size: 18)
                                    )
                                    
                                    Text("Produktywny czas")
                                        .foregroundStyle(.white)
                                        .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 18))
                                        .multilineTextAlignment(.center)
                                }
                                
                                VStack(spacing: 10) {
                                    CircularProgressBar(
                                        progress: viewModel.unproductiveTimePercent,
                                        showProgress: true,
                                        trackColor: .greenCustom,
                                        progressColor: .greenLite,
                                        lineWidth: 30,
                                        textColor: .white,
                                        font: Fonts.SFProDisplay.bold.swiftUIFont(size: 18)
                                    )
                                    
                                    Text("Bezproduktywny czas")
                                        .foregroundStyle(.white)
                                        .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 18))
                                        .multilineTextAlignment(.center)
                                }
                            }
                            .padding()
                            
                            // Items
                            HStack {
                                Text("Dane dotyczące utraconego czasu:")
                                    .foregroundStyle(.white)
                                    .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 22))
                                Spacer()
                                Button {
                                    viewModel.showRecommendations.toggle()
                                } label: {
                                    Asset.bulb.swiftUIImage
                                }
                            }
                            
                            VStack(spacing: 10) {
                                ForEach(viewModel.tasks) { task in
                                    HStack {
                                        Text(task.name)
                                            .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 19))
                                        
                                        Spacer()
                                        
                                        Text(convertMinutesInTime(minutes: task.executionTime * 60))
                                            .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 22))
                                    }
                                    .foregroundStyle(.white)
                                }
                            }
                        }
                    }
                    .scrollIndicators(.never)
                }
                .padding(.horizontal)
            }
            .onAppear {
                withAnimation {
                    viewModel.getTasks()
                }
            }
            .navigationDestination(isPresented: $viewModel.showQuests) {
                QuestsView(title: "Zadania",
                           items: viewModel.questItems)
            }
            .navigationDestination(isPresented: $viewModel.showRecommendations) {
                QuestsView(title: "Zalecenia",
                           items: viewModel.recommendationItems)
            }
        }
    }
}

#Preview {
    StatisticsView()
}
