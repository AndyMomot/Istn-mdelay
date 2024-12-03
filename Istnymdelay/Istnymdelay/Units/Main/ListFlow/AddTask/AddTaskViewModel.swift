//
//  AddTaskViewModel.swift
//  Istnymdelay
//
//  Created by Andrii Momot on 29.11.2024.
//

import Foundation
import SwiftUI

extension AddTaskView {
    final class ViewModel: ObservableObject {
        @Published var showImagePicker = false
        @Published var image = UIImage()
        @Published var name = ""
        @Published var deadline = Date().addOrSubtract(component: .hour, value: 1)
        @Published var executionTime = ""
        @Published var description = ""
        
        @Published var selectedPriority = TaskPriority.low
        @Published var priorityColor: Color = .greenLite
        var priorities = TaskPriority.allCases
        
        func setState(_ state: ViewState) {
            switch state {
            case .add:
                break
            case .edit(let item):
                DispatchQueue.global().async { [weak self] in
                    guard let self else { return }
                    // Image
                    FileManagerService().fetchImage(with: item.id) { [self] data in
                        if let data, let uiImage = UIImage(data: data) {
                            DispatchQueue.main.async { [self] in
                                self.image = uiImage
                            }
                        }
                    }
                }
                
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    self.name = item.name
                    self.deadline = item.deadline
                    self.executionTime = "\(item.executionTime)"
                    self.description = item.description
                }
            }
        }
        
        func save(_ state: ViewState, completion: @escaping () -> Void) {
            switch state {
            case .add:
                DispatchQueue.global().async { [weak self] in
                    guard let self, self.validateFields() else { return }
                    let item = TaskModel(
                        name: self.name,
                        description: self.description,
                        deadline: self.deadline,
                        priority: self.selectedPriority.rawValue,
                        executionTime: Int(self.executionTime) ?? .zero,
                        status: 0
                    )
                    
                    DefaultsService.shared.tasks.append(item)
                    if let imageData = self.image.jpegData(compressionQuality: 1) {
                        FileManagerService().saveImage(data: imageData, for: item.id)
                    }
                    
                    DispatchQueue.main.async {
                        completion()
                    }
                }
            case .edit(var item):
                DispatchQueue.global().async { [weak self] in
                    guard let self, self.validateFields() else { return }
                    item.name = self.name
                    item.description = self.description
                    item.deadline = deadline
                    item.priority = self.selectedPriority.rawValue
                    item.executionTime = Int(self.executionTime) ?? .zero
                    item.status = 0
                    
                    if let index = DefaultsService.shared.tasks.firstIndex(where: {
                        $0.id == item.id
                    }) {
                        DefaultsService.shared.tasks[index] = item
                    }
                    
                    if let imageData = self.image.jpegData(compressionQuality: 1) {
                        FileManagerService().saveImage(data: imageData, for: item.id)
                    }
                    
                    DispatchQueue.main.async {
                        completion()
                    }
                }
            }
        }
        
        func delete(id: String, completion: @escaping () -> Void) {
            DispatchQueue.global().async {
                DefaultsService.shared.tasks.removeAll(where: { $0.id == id })
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
    }
}

private extension AddTaskView.ViewModel {
    func validateFields() -> Bool {
        return image != UIImage()
        && !name.isEmpty
        && deadline > .init()
        && Int(executionTime) ?? .zero > .zero
        && !description.isEmpty
    }
}

extension AddTaskView {
    enum ViewState {
        case add
        case edit(item: TaskModel)
    }
}
