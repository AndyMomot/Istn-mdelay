//
//  PrivacyViewModel.swift
//  Apeficonnect
//
//  Created by Andrii Momot on 17.11.2024.
//

import Foundation

extension PrivacyView {
    final class ViewModel: ObservableObject {
        @Published var showPrivacyPolicy = false
        let privacyPolicyURL = URL(string: "https://google.com")
    }
}
