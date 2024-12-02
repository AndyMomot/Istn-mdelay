//
//  ListView.swift
//  Istnymdelay
//
//  Created by Andrii Momot on 29.11.2024.
//

import SwiftUI

struct ListView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Asset.listBg.swiftUIImage
                    .resizable()
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    HStack {
                        BackButton(title: "Lista",
                                   canDismiss: false)
                        Spacer()
                        
                        Button {
                            viewModel.showSettings.toggle()
                        } label: {
                            Image(systemName: "gearshape")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(.white)
                                .frame(width: 40)
                        }
                    }
                    .padding(.horizontal)
                    
                    List {
                        ForEach(viewModel.tasks) { task in
                            TaskCell(model: task) { action in
                                DispatchQueue.main.async {
                                    viewModel.handleTask(action: action,
                                                         taskId: task.id)
                                }
                            }
                            .padding(.horizontal)
                            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                Button {
                                    viewModel.delete(id: task.id)
                                } label: {
                                    Asset.trash.swiftUIImage
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundStyle(.white)
                                        .frame(width: 55, height: 55)
                                }
                                .tint(.clear)
                            }
                            .swipeActions(edge: .leading, allowsFullSwipe: false) {
                                NavigationLink(value: task) {
                                    Asset.edit.swiftUIImage
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundStyle(.white)
                                        .frame(width: 55, height: 55)
                                }
                                .tint(.clear)
                            }
                        }
                        .listRowSeparator(.hidden)
                        .listRowBackground(EmptyView())
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                    .scrollIndicators(.never)
                    .background(Color.clear)
                }
                
                VStack {
                    Spacer()
                    Button {
                        viewModel.showAddTask.toggle()
                    } label: {
                        Text("Dodaj zadanie")
                            .foregroundStyle(.greenCustom)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 12)
                            .background(.white)
                            .clipShape(Capsule())
                            .padding(.bottom, 15)
                    }
                }
            }
            .onAppear {
                viewModel.getTasks()
            }
            .navigationDestination(isPresented: $viewModel.showSettings) {
                SettingsView()
            }
            .navigationDestination(isPresented: $viewModel.showAddTask) {
                AddTaskView(viewState: .add)
            }
            .navigationDestination(for: TaskModel.self) { item in
                AddTaskView(viewState: .edit(item: item))
            }
        }
    }
}

#Preview {
    ListView()
}
