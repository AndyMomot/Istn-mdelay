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
}
