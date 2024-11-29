//
//  TabBar.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 13.06.2024.
//

import SwiftUI

struct TabBar: View {
    @StateObject private var viewModel = TabBarViewModel()
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        TabView(selection: $viewModel.selection) {
            Text("Lista")
                .tag(TabBarSelectionView.start.rawValue)
                .environmentObject(viewModel)
            
            Text("Regulator czasowy")
                .tag(TabBarSelectionView.tracker.rawValue)
            
            Text("Statystyka")
                .tag(TabBarSelectionView.advices.rawValue)
        }
        .overlay {
            if viewModel.isShowTabBar {
                VStack {
                    Spacer()
                    TabBarCustomView(selectedItem: $viewModel.selection)
                        .frame(height: UIScreen.main.bounds.height * 0.1)
                }
                .ignoresSafeArea(edges: .bottom)
            }
        }
    }
}

#Preview {
    TabBar()
}
