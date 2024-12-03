//
//  TimerCell.swift
//  Istnymdelay
//
//  Created by Andrii Momot on 03.12.2024.
//

import SwiftUI

struct TimerCell: View {
    @State var model: TaskModel
    var action: (ViewAction) -> Void
    
    @State private var progress = 0.0
    
    var body: some View {
        VStack(spacing: 20) {
            Text(model.name)
                .foregroundStyle(.white)
                .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 23))
                .multilineTextAlignment(.center)
            
            VStack(spacing: 30) {
                ZStack {
                    CircularProgressBar(
                        progress: progress,
                        trackColor: .darkGreenCustom.opacity(0.3),
                        progressColor: .greenLite,
                        lineCap: .round
                    )
                    
                    Text(convertMinutesInTime(minutes: model.executedMinutes))
                        .foregroundStyle(.white)
                        .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 30))
                }
                
                Text("\(convertMinutesInTime(minutes: model.executedMinutes))/\(convertMinutesInTime(minutes: model.executionTime * 60))")
                    .foregroundStyle(.white)
                    .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 30))
            }
            .padding(.top, 47)
            .padding(.horizontal, 47)
            .padding(.bottom, 20)
            .background(.greenCustom)
            .cornerRadius(20, corners: .allCorners)
            
            HStack {
                Spacer()
                TimerCellButton(imageSystemName: "pause",
                                title: "Pauza") {
                    action(.pause(id: model.id))
                }
                Spacer()
                TimerCellButton(imageSystemName: "checkmark",
                                title: "Skończyć") {
                    action(.finish(id: model.id))
                }
                Spacer()
            }
        }
        .onAppear {
            calculateProgress()
        }
    }
}

private extension TimerCell {
    func calculateProgress() {
        DispatchQueue.main.async {
            let maxMinutes = Double(model.executionTime * 60)
            let completed = Double(model.executedMinutes)
            let progress = completed / maxMinutes
            
            withAnimation {
                self.progress = progress
            }
        }
    }
    
    func convertMinutesInTime(minutes: Int) -> String {
        // Calculate hours and minutes
        let hours = minutes / 60
        let minutes = minutes % 60

        // Format as "HH:mm"
        let formattedTime = String(format: "%02d:%02d", hours, minutes)
        return formattedTime
    }
}

extension TimerCell {
    enum ViewAction {
        case pause(id: String)
        case finish(id: String)
    }
}

#Preview {
    ZStack {
        Color.green
        
        TimerCell(model: .init(
            name: "Kompletny raport z projektu",
            description: "Przygotowanie raportu końcowego projektu do zaprezentowania kierownictwu. Dołącz najważniejsze wnioski, wykresy i rekomendacje.",
            deadline: .init(),
            priority: 2,
            executionTime: 1,
            status: 2
        )) {_ in}
        .padding(.horizontal, 30)
    }
}
