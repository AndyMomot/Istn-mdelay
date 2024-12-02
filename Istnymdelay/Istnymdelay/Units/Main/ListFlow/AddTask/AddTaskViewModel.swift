//
//  AddTaskViewModel.swift
//  Istnymdelay
//
//  Created by Andrii Momot on 29.11.2024.
//

import Foundation
import UIKit.UIImage

extension AddTaskView {
    final class AddTaskViewModel: ObservableObject {
        @Published var showImagePicker = false
        @Published var image = UIImage()
        @Published var name = ""
        @Published var deadline = Date()
    }
}
