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
        VStack(spacing: .zero) {
            TabView(selection: $viewModel.selection) {
                ScrollView {
                    VStack {
                        ForEach(0..<8) { _ in
                            Rectangle()
                                .frame(height: 100)
                                .overlay {
                                    Rectangle()
                                        .stroke(.red, lineWidth: 4)
                                }
                                .padding(.vertical, 4)
                        }
                    }
                }
                .tag(TabBarSelectionView.list.rawValue)
                .environmentObject(viewModel)
                
                Text("Regulator czasowy")
                    .tag(TabBarSelectionView.timer.rawValue)
                
                Text("Statistics")
                    .tag(TabBarSelectionView.statistics.rawValue)
            }
            
            TabBarCustomView(selectedItem: $viewModel.selection)
                .frame(height: UIScreen.main.bounds.height * 0.12)
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    TabBar()
}
