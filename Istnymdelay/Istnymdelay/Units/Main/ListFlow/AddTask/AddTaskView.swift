//
//  AddTaskView.swift
//  Istnymdelay
//
//  Created by Andrii Momot on 29.11.2024.
//

import SwiftUI

struct AddTaskView: View {
    var viewState: ViewState
    
    init(viewState: ViewState) {
        self.viewState = viewState
    }
    
    @StateObject private var viewModel = ViewModel()
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var tabBarVM: TabBar.TabBarViewModel
    
    var body: some View {
        ZStack {
            Asset.listBg.swiftUIImage
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    BackButton(title: "Nowe zadanie")
                    
                    Spacer()
                    
                    Button {
                        viewModel.showImagePicker.toggle()
                    } label: {
                        Image(systemName: viewModel.image == UIImage() ? "photo.badge.plus" : "photo.badge.checkmark")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.white)
                            .frame(width: 30)
                    }
                }
                
                ScrollView {
                    VStack(spacing: 20) {
                        CustomTextField(title: "Sfinalizowanie raportu z projektu",
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
                                ForEach(viewModel.priorities, id: \.description) { priority in
                                    Button {
                                        DispatchQueue.main.async {
                                            viewModel.selectedPriority = priority
                                            switch priority {
                                            case .low:
                                                viewModel.priorityColor = .greenLite
                                            case .regular:
                                                viewModel.priorityColor = .orange
                                            case .high:
                                                viewModel.priorityColor = .red
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
                                    HStack {
                                        Text(viewModel.selectedPriority.description)
                                        Circle()
                                            .fill(viewModel.priorityColor)
                                            .frame(width: 10)
                                    }
                                    Spacer()
                                    Image(systemName: "chevron.down")
                                }
                                .foregroundStyle(.darkBlueGreen)
                                .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 16))
                                .padding(.vertical, 18)
                                .padding(.horizontal, 14)
                                .background(.white)
                                .cornerRadius(8, corners: .allCorners)
                            }
                        }
                        
                        CustomTextField(title: "Czas wykonania, g",
                                   text: $viewModel.executionTime)
                        .keyboardType(.numberPad)
                        
                        CustomTextField(title: "Opis",
                                        isDynamic: true,
                                        text: $viewModel.description)
                    }
                }
                .scrollIndicators(.never)
                
                HStack(spacing: 15) {
                    Button {
                        viewModel.save(viewState) {
                            dismiss.callAsFunction()
                        }
                    } label: {
                        ZStack {
                            Capsule()
                                .fill(.white)
                            Text("Zapisz")
                                .foregroundStyle(.greenCustom)
                                .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 18))
                        }
                    }
                    
                    switch viewState {
                    case .add:
                        EmptyView()
                    case .edit(let item):
                        Button {
                            viewModel.delete(id: item.id) {
                                dismiss.callAsFunction()
                            }
                        } label: {
                            ZStack {
                                Capsule()
                                    .fill(.white)
                                Text("Usuń")
                                    .foregroundStyle(.greenCustom)
                                    .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 18))
                            }
                        }
                    }
                }
                .frame(height: 49)
                .padding(.bottom, 6)
            }
            .padding(.horizontal)
        }
        .onAppear {
            viewModel.setState(viewState)
            withAnimation {
                tabBarVM.showTabBar(false)
            }
        }
        .onDisappear {
            withAnimation {
                tabBarVM.showTabBar(true)
            }
        }
        .sheet(isPresented: $viewModel.showImagePicker) {
            ImagePicker(selectedImage: $viewModel.image)
        }
    }
}



#Preview {
    AddTaskView(viewState: .add)
}
