//
//  QuestsCell.swift
//  Istnymdelay
//
//  Created by Andrii Momot on 04.12.2024.
//

import SwiftUI

struct QuestsCell: View {
    var item: QuestsModel
    @State var isHidden = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 10) {
                if let priorityId = item.priority {
                    Circle()
                        .fill(getPriorityColor(priorityId: priorityId))
                        .frame(width: 20)
                }
                
                HStack(alignment: .top, spacing: 10) {
                    Text(item.title)
                        .font(Fonts.SFProDisplay.semibold.swiftUIFont(size: 18))
                    Spacer()
                    Button {
                        withAnimation {
                            isHidden.toggle()
                        }
                    } label: {
                        Image(systemName: isHidden ? "chevron.down" : "chevron.up")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20)
                    }
                }
            }
            
            if let subtitle = item.subtitle {
                Text(subtitle)
                    .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 16))
            }
            
            if !isHidden {
                Text(item.text)
                    .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 16))
                    .lineSpacing(5)
            }
        }
        .padding(20)
        .foregroundStyle(.greenUltraLite)
        .background(.greenCustom)
        .multilineTextAlignment(.leading)
        .cornerRadius(20, corners: .allCorners)
    }
}

private extension QuestsCell {
    func getPriorityColor(priorityId: Int) -> Color {
        if let priority = TaskPriority(rawValue: priorityId) {
            switch priority {
            case .low:
                return .greenLite
            case .regular:
                return .orange
            case .high:
                return .red
            }
        } else {
            return .clear
        }
    }
}

#Preview {
    QuestsCell(item: .init(
        priority: TaskPriority.low.rawValue,
        title: "Start zakończył się sukcesem",
        subtitle: "Nagroda: 10 punktów doświadczenia, +1 do wskaźnika produktywności.",
        text: "Wymagania wstępne: Ukończ pierwsze zadanie."
    ))
}
