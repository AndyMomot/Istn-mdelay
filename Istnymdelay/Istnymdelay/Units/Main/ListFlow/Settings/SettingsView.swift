//
//  SettingsView.swift
//  Istnymdelay
//
//  Created by Andrii Momot on 29.11.2024.
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel = ViewModel()
    @EnvironmentObject private var rootVM: RootContentView.RootContentViewModel
    
    var body: some View {
        ZStack {
            Asset.listBg.swiftUIImage
                .resizable()
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                BackButton(title: "Ustawienia")
                
                ScrollView {
                    VStack(spacing: 20) {
                        if let url = URL(string: viewModel.appUrl) {
                            SettingsButton(title: "Udział") {
                                DispatchQueue.main.async {
                                    share(url: url.absoluteString)
                                }
                            }
                            
                            SettingsButton(title: "Oceń aplikację") {
                                DispatchQueue.main.async {
                                    UIApplication.shared.open(url)
                                }
                            }
                        }
                        
                        SettingsButton(title: "Wyczyść pamięć podręczną") {
                            withAnimation {
                                viewModel.showClearCacheAlert = true
                            }
                        }
                    }
                }
                .scrollIndicators(.never)
            }
            .padding(.horizontal)
            
            if viewModel.showLoader {
                ProgressView()
            }
        }
        .alert("Usuwanie danych", isPresented: $viewModel.showClearCacheAlert) {
            Button("Anulować", role: .cancel) {}
            
            Button("Usuwać", role: .destructive) {
                withAnimation { viewModel.showLoader = true }
                viewModel.clearCache {
                    withAnimation {
                        viewModel.showLoader = false
                        rootVM.setFlow(.onboarding)
                    }
                }
            }
        } message: {
            Text("Czy na pewno chcesz usunąć dane?")
        }
    }
}

#Preview {
    SettingsView()
}
