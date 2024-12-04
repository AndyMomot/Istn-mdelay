//
//  QuestsView.swift
//  Istnymdelay
//
//  Created by Andrii Momot on 04.12.2024.
//

import SwiftUI

struct QuestsView: View {
    var title: String
    var items: [QuestsModel]
    
    @State var isHidden = true
    
    var body: some View {
        ZStack {
            Asset.listBg.swiftUIImage
                .resizable()
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                BackButton(title: title)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        ForEach(items) { item in
                            QuestsCell(item: item)
                        }
                    }
                }
                .scrollIndicators(.never)
            }
            .padding(.horizontal)
        }
    }
}

#Preview("Zadania") {
    QuestsView(
        title: "Zadania",
        items: [
            .init(
                priority: TaskPriority.low.rawValue,
                title: "Start zakończył się sukcesem",
                subtitle: "Nagroda: 10 punktów doświadczenia, +1 do wskaźnika produktywności.",
                text: "Wymagania wstępne: Ukończ pierwsze zadanie."
            )
        ])
}

#Preview("Zalecenia") {
    QuestsView(
        title: "Zalecenia",
        items: [
            .init(
                title: "Stosowanie metody Pomodoro",
                text: "Jeśli trudno ci utrzymać koncentrację, wypróbuj technikę Pomodoro. Metoda ta polega na pracy przez 25 minut w pełnym skupieniu na wykonywanym zadaniu, po czym następuje 5 minut odpoczynku. Ten rytm pomaga zmniejszyć zmęczenie i zwiększyć produktywność. Co 4 cykle należy zrobić dłuższą przerwę trwającą około 15-30 minut.")
        ])
}
