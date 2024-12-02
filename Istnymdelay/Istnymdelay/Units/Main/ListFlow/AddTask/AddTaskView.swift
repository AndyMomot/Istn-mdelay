//
//  AddTaskView.swift
//  Istnymdelay
//
//  Created by Andrii Momot on 29.11.2024.
//

import SwiftUI

struct AddTaskView: View {
    
    @StateObject private var viewModel = AddTaskViewModel()
    
    @State private var selectedPriority = TaskPriority.low
    @State private var priorityColor: Color = .greenLite
    private var priorities = TaskPriority.allCases
    
    var body: some View {
        ZStack {
            Asset.listBg.swiftUIImage
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    BackButton(title: "Sfinalizowanie raportu z projektu")
                    
                    Spacer()
                    
                    Button {
                        viewModel.showImagePicker.toggle()
                    } label: {
                        Image(systemName: "photo.badge.plus")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.white)
                            .frame(width: 30)
                    }
                }
                
                ScrollView {
                    VStack(spacing: 20) {
                        InputField(title: "Sfinalizowanie raportu z projektu",
                                   text: $viewModel.name)
                        
                        HStack {
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Termin")
                                    .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 19))
                                    .foregroundStyle(.white)
                                
                                DatePicker("", selection: $viewModel.deadline, in: Date()..., displayedComponents: [.date, .hourAndMinute])
                                    .labelsHidden()
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 14)
                                    .background(.white)
                                    .cornerRadius(8, corners: .allCorners)
                            }
                            Spacer()
                        }
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Priorytet zadania")
                                .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 19))
                                .foregroundStyle(.white)
                            
                            Menu {
                                ForEach(priorities, id: \.description) { priority in
                                    Button {
                                        DispatchQueue.main.async {
                                            selectedPriority = priority
                                            switch priority {
                                            case .low:
                                                priorityColor = .greenLite
                                            case .regular:
                                                priorityColor = .orange
                                            case .high:
                                                priorityColor = .red
                                            }
                                        }
                                    } label: {
                                        Text(priority.description)
                                            .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 16))
                                            .foregroundStyle(.darkBlueGreen)
                                    }
                                }
                            } label: {
                                HStack {
                                    Text(selectedPriority.description)
                                        .foregroundStyle(priorityColor)
                                    Spacer()
                                    Image(systemName: "chevron.down")
                                        .foregroundStyle(.darkBlueGreen)
                                }
                                .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 16))
                                .padding(.vertical, 18)
                                .padding(.horizontal, 14)
                                .background(.white)
                                .cornerRadius(8, corners: .allCorners)
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
        .sheet(isPresented: $viewModel.showImagePicker) {
            ImagePicker(selectedImage: $viewModel.image)
        }
    }
}

#Preview {
    AddTaskView()
}
