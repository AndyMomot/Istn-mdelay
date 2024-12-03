//
//  SettingsViewModel.swift
//  Istnymdelay
//
//  Created by Andrii Momot on 29.11.2024.
//

import Foundation

extension SettingsView {
    final class ViewModel: ObservableObject {
        // TODO: - Change app url
        var appUrl = "https://apps.apple.com/app/id6738754615"
        
        @Published var showClearCacheAlert = false
        @Published var showLoader = false
        
        func clearCache(completion: @escaping () -> Void) {
            DispatchQueue.global().async {
                DefaultsService.shared.removeAll()
                FileManagerService().removeAllFiles()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    completion()
                }
            }
        }
    }
}
