//
//  OnboardingViewModel.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 12.06.2024.
//

import Foundation

extension OnboardingView {
    final class OnboardingViewModel: ObservableObject {
        @Published var showPrivacyPolicy = false
        let privacyPolicyURL = URL(string: "https://google.com")
    }
    
    enum OnboardingItem: Int, CaseIterable {
        case first = 0
        case second
        case third
        
        var image: String {
            switch self {
            case .first:
                return Asset.onboard1.name
            case .second:
                return Asset.onboard2.name
            case .third:
                return Asset.onboard3.name
            }
        }
        
        var text: String {
            switch self {
            case .first:
                return "Aplikacja Istnуmdelay pomaga określić rzeczywistą wartość czasu spędzonego na nieproduktywnych zajęciach. Wystarczy podać swoją stawkę godzinową, aby dowiedzieć się, ile pieniędzy straciłeś przez prokrastynację lub zbędne czynności."
            case .second:
                return "Jeśli odchodzisz od planu, aplikacja natychmiast obliczy straty finansowe i przedstawi konkretne rekomendacje dotyczące optymalizacji. Na przykład skrócenie czasu spędzanego w mediach społecznościowych lub skupienie się na zadaniach priorytetowych."
            case .third:
                return "Istnуmdelay motywuje do doceniania każdej minuty i przekształcania jej w zysk. Zrób pierwszy krok do efektywności i zacznij oszczędzać nie tylko czas, ale i pieniądze!"
            }
        }

        var next: Self {
            switch self {
            case .first:
                return .second
            case .second, .third:
                return .third
            }
        }
    }
}
