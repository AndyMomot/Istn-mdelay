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
        @Published var tasks = [
            "Task 1",
            "Task 2",
            "Task 3",
            "Task 4",
            "Task 5"
        ]
        
        func delete(item: String) {
            tasks.removeAll(where: { $0 == item})
        }
        
        func edit(item: String) {
            
        }
    }
}
