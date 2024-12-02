//
//  TaskModel.swift
//  Istnymdelay
//
//  Created by Andrii Momot on 29.11.2024.
//

import Foundation

struct TaskModel: Identifiable, Codable {
    private(set) var id = UUID().uuidString
    var name, description: String
    var deadline: Date
    var priority, executionTime, status: Int
    var executedTime = 0
}

enum TaskPriority: Int, CaseIterable {
    case low = 0
    case regular = 1
    case high = 2
    
    var description: String {
        switch self {
        case .low:
            return "Niski"
        case .regular:
            return "Średni"
        case .high:
            return "Wysoki"
        }
    }
}

enum TaskStatus: Int {
    case prepared = 0
    case inProgress = 1
    case finished = 2
    
    var description: String {
        switch self {
        case .prepared:
            return "Nie rozpoczęto"
        case .inProgress:
            return "W toku"
        case .finished:
            return "Zakończono"
        }
    }
}
