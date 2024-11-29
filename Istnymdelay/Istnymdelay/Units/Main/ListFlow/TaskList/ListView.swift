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
                    
                    List {
                        ForEach(viewModel.tasks, id: \.self) { item in
                            ZStack {
                                Color.green
                                    .frame(height: 450)
                                Text(item)
                            }
                                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                    Button {
                                        withAnimation {
                                            viewModel.delete(item: item)
                                        }
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
                                    Button {
                                        viewModel.edit(item: "")
                                    } label: {
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
                    .background(Color.clear)
                }
                .padding(.horizontal)
                
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
            .navigationDestination(isPresented: $viewModel.showSettings) {
                SettingsView()
            }
            .navigationDestination(isPresented: $viewModel.showAddTask) {
                AddTaskView()
            }
        }
    }
}

#Preview {
    ListView()
}
