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
        
        func delete(id: String) {
            DispatchQueue.global().async { [weak self] in
                guard let self else { return }
                DefaultsService.shared.tasks.removeAll(where: { $0.id == id })
                self.getTasks()
            }
        }
        
        func handleTask(action: TaskCell.ViewAction, taskId: String) {
            let shared = DefaultsService.shared
            
            switch action {
            case .start:
                DispatchQueue.global().async { [weak self] in
                    guard let self else { return }
                    if let index = shared.tasks.firstIndex(where: { $0.id == taskId }) {
                        shared.tasks[index].startExecution()
                        self.getTasks()
                    }
                }
            case .finish:
                DispatchQueue.global().async { [weak self] in
                    guard let self else { return }
                    if let index = shared.tasks.firstIndex(where: { $0.id == taskId }) {
                        shared.tasks[index].stopExecution(with: .finished)
                        self.getTasks()
                    }
                }
            }
        }
    }
}
