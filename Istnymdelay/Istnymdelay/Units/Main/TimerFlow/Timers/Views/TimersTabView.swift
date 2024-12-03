//
//  TimersTabView.swift
//  Istnymdelay
//
//  Created by Andrii Momot on 03.12.2024.
//

import SwiftUI

struct TimersTabView: View {
    @Binding var currentPageIndex: Int
    var items: [TaskModel]
    var action: (TimerCell.ViewAction) -> Void
    
    var body: some View {
        TabView(selection: $currentPageIndex) {
            ForEach(items.indices, id: \.self) { index in
                let item = items[index]
                TimerCell(model: item, action: action)
                    .tag(index)
                    .padding(.horizontal)
            }
        }
        .ignoresSafeArea()
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .indexViewStyle(.page(backgroundDisplayMode: .never))
    }
}

#Preview {
    ZStack {
        Color.green
        
        TimersTabView(
            currentPageIndex: .constant(0),
            items: [
                .init(
                    name: "Kompletny raport z projektu",
                    description: "Przygotowanie raportu końcowego projektu do zaprezentowania kierownictwu. Dołącz najważniejsze wnioski, wykresy i rekomendacje.",
                    deadline: .init().addOrSubtract(component: .day,
                                                    value: 1),
                    priority: 0,
                    executionTime: 3,
                    status: 0
                ),
                .init(
                    name: "Kompletny raport z projektu",
                    description: "Przygotowanie raportu końcowego projektu do zaprezentowania kierownictwu. Dołącz najważniejsze wnioski, wykresy i rekomendacje.",
                    deadline: .init().addOrSubtract(component: .hour,
                                                    value: 8),
                    priority: 1,
                    executionTime: 2,
                    status: 1
                ),
                .init(
                    name: "Kompletny raport z projektu",
                    description: "Przygotowanie raportu końcowego projektu do zaprezentowania kierownictwu. Dołącz najważniejsze wnioski, wykresy i rekomendacje.",
                    deadline: .init(),
                    priority: 2,
                    executionTime: 1,
                    status: 2
                )
            ]) {_ in }
    }
}
