//
//  TaskCell.swift
//  Istnymdelay
//
//  Created by Andrii Momot on 29.11.2024.
//

import SwiftUI

struct TaskCell: View {
    var model: TaskModel
    var action: (ViewAction) -> Void
    private var status: TaskStatus = .prepared
    private var priority: TaskPriority = .low
    private var priorityColor: Color = .greenLite
    
    init(model: TaskModel, action: @escaping (ViewAction) -> Void) {
        self.model = model
        self.action = action
        self.status = TaskStatus(rawValue: model.status) ?? .prepared
        self.priority = TaskPriority(rawValue: model.priority) ?? .low
        
        switch priority {
        case .low:
            priorityColor = .greenLite
        case .regular:
            priorityColor = .orange
        case .high:
            priorityColor = .red
        }
    }
    
    @State private var image = Image(systemName: "photo")
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        VStack(spacing: 8) {
            image
                .resizable()
                .scaledToFill()
                .frame(maxHeight: bounds.width * 0.5)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay {
                    VStack {
                        HStack(spacing: 0) {
                            Text("Stan: \(status.description)")
                            Spacer(minLength: 10)
                            HStack(spacing: 5) {
                                Text(priority.description)
                                Circle()
                                    .fill(priorityColor)
                                    .frame(width: 10)
                            }
                        }
                        .foregroundStyle(.white)
                        .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 16))
                        .shadow(radius: 5)
                        
                        Spacer()
                    }
                    .padding(10)
                }
                .overlay {
                    switch status {
                    case .prepared:
                        VStack {
                            Spacer()
                            Button {
                                action(.start)
                            } label: {
                                HStack {
                                    Spacer()
                                    Image(systemName: "play.fill")
                                        .foregroundStyle(.white)
                                    Spacer()
                                }
                                .padding(.vertical, 10)
                                .background(.greenCustom)
                                .cornerRadius(3, corners: .allCorners)
                                .padding(10)
                            }
                        }
                    case .inProgress:
                        VStack {
                            Spacer()
                            
                            VStack(alignment: .trailing, spacing: 5) {
                                Text("\(convertMinutesInTime(minutes: model.executedMinutes))/\(convertMinutesInTime(minutes: model.executionTime * 60))")
                                    .foregroundStyle(.white)
                                    .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 16))
                                    .shadow(radius: 5)
                                
                                Button {
                                    action(.finish)
                                } label: {
                                    HStack {
                                        Spacer()
                                        Image(systemName: "checkmark")
                                            .foregroundStyle(.white)
                                            .fontWeight(.bold)
                                        Spacer()
                                    }
                                    .padding(.vertical, 10)
                                    .background(.greenCustom)
                                    .cornerRadius(3, corners: .allCorners)
                                    .shadow(radius: 5)
                                }
                                .padding(10)
                            }
                        }
                    case .finished:
                        Image(systemName: "checkmark")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.white)
                            .fontWeight(.bold)
                            .padding(20)
                            .background(.greenCustom)
                            .cornerRadius(5)
                            .shadow(radius: 5)
                            .padding(.horizontal, 96)
                    }
                }
            
            Text(model.name)
                .foregroundStyle(.white)
                .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 20))
            
            HStack(spacing: 0) {
                HStack(spacing: 5) {
                    Asset.calendar.swiftUIImage
                    Text("Termin ostateczny:")
                        .foregroundStyle(.white)
                        .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 16))
                }
                
                Spacer(minLength: 10)
                Text(model.deadline.formatted(.dateTime))
                    .foregroundStyle(.white)
                    .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 16))
                    .lineLimit(1)
            }
            
            HStack(spacing: 0) {
                HStack(spacing: 5) {
                    Asset.clock.swiftUIImage
                    Text("Czas realizacji:")
                        .foregroundStyle(.white)
                        .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 16))
                }
                
                Spacer(minLength: 10)
                Text("\(model.executionTime)g")
                    .foregroundStyle(.white)
                    .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 16))
                    .lineLimit(1)
            }
            
            HStack(spacing: 5) {
                Asset.pencil.swiftUIImage
                Text("Opis:")
                    .foregroundStyle(.white)
                    .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 16))
                Spacer()
            }
            
            HStack {
            Text(model.description)
                .foregroundStyle(.white)
                .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 16))
                .lineSpacing(1.5)
                Spacer()
            }
        }
        .padding()
        .background(Colors.greenCustom.swiftUIColor)
        .cornerRadius(10, corners: .allCorners)
        .onAppear {
            withAnimation {
                setData(with: model)
            }
        }
    }
}

private extension TaskCell {
    func setData(with model: TaskModel) {
        DispatchQueue.global().async {
            FileManagerService().fetchImage(with: model.id) { data in
                guard let data, let uiImage = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    image = Image(uiImage: uiImage)
                }
            }
        }
    }
}

extension TaskCell {
    enum ViewAction {
        case start, finish
    }
}

#Preview {
    ScrollView {
        VStack(spacing: 20) {
            TaskCell(model: .init(
                name: "Kompletny raport z projektu",
                description: "Przygotowanie raportu końcowego projektu do zaprezentowania kierownictwu. Dołącz najważniejsze wnioski, wykresy i rekomendacje.",
                deadline: .init().addOrSubtract(component: .day,
                                                value: 1),
                priority: 0,
                executionTime: 3,
                status: 0
            )) {_ in}
            
            TaskCell(model: .init(
                name: "Kompletny raport z projektu",
                description: "Przygotowanie raportu końcowego projektu do zaprezentowania kierownictwu. Dołącz najważniejsze wnioski, wykresy i rekomendacje.",
                deadline: .init().addOrSubtract(component: .hour,
                                                value: 8),
                priority: 1,
                executionTime: 2,
                status: 1
            )) {_ in}
            
            TaskCell(model: .init(
                name: "Kompletny raport z projektu",
                description: "Przygotowanie raportu końcowego projektu do zaprezentowania kierownictwu. Dołącz najważniejsze wnioski, wykresy i rekomendacje.",
                deadline: .init(),
                priority: 2,
                executionTime: 1,
                status: 2
            )) {_ in}
        }
        .padding(.horizontal, 30)
    }
}
