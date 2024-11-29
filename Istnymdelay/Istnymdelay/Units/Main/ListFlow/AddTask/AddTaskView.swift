//
//  AddTaskView.swift
//  Istnymdelay
//
//  Created by Andrii Momot on 29.11.2024.
//

import SwiftUI

struct AddTaskView: View {
    
    @StateObject private var viewModel = AddTaskViewModel()
    
    var body: some View {
        Text("Add a new task")
    }
}

#Preview {
    AddTaskView()
}
