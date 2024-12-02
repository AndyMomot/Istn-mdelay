//
//  ListViewModel.swift
//  Istnymdelay
//
//  Created by Andrii Momot on 29.11.2024.
//

import Foundation

extension ListView {
    final class ViewModel: ObservableObject {
        @Published var showSettings = false
        @Published var showAddTask = false
        @Published var tasks: [TaskModel] = []
        
        func getTasks() {
            DispatchQueue.global().async { [weak self] in
                guard let self else { return }
                let tasks = DefaultsService.shared.tasks
                DispatchQueue.main.async { [self] in
                    self.tasks = tasks
                }
            }
        }
        
        func delete(item: String) {
            
        }
        
        func edit(item: String) {
            
        }
    }
}
