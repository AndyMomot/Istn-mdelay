//
//  TimersViewModel.swift
//  Istnymdelay
//
//  Created by Andrii Momot on 03.12.2024.
//

import Foundation

extension TimersView {
    final class ViewModel: ObservableObject {
        @Published var tasks: [TaskModel] = []
        @Published var showMotivation = false
        @Published var currentPageIndex = 0
        private var timer: Timer?
        
        func getTasks() {
            DispatchQueue.global().async { [weak self] in
                guard let self else { return }
                let tasks = DefaultsService.shared.tasks.filter { $0.dateStarted != nil }
                DispatchQueue.main.async { [self] in
                    self.tasks = tasks
                    self.startTimer()
                }
            }
        }
        
        func handleCell(action: TimerCell.ViewAction) {
            let shared = DefaultsService.shared
            
            switch action {
            case .pause(let id):
                DispatchQueue.global().async { [weak self] in
                    guard let self else { return }
                    if let index = shared.tasks.firstIndex(where: { $0.id == id }) {
                        shared.tasks[index].stopExecution(with: .prepared)
                        self.getTasks()
                    }
                }
            case .finish(let id):
                DispatchQueue.global().async { [weak self] in
                    guard let self else { return }
                    if let index = shared.tasks.firstIndex(where: { $0.id == id }) {
                        shared.tasks[index].stopExecution(with: .finished)
                        self.getTasks()
                    }
                }
            }
        }
        
        func startTimer() {
            timer?.invalidate()
            timer = nil
            
            timer = .scheduledTimer(withTimeInterval: 60,
                                    repeats: true) { [weak self] _ in
                self?.getTasks()
            }
        }
    }
}
