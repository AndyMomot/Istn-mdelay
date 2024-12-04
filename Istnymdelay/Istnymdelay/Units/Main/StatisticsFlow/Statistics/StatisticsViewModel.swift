//
//  StatisticsViewModel.swift
//  Istnymdelay
//
//  Created by Andrii Momot on 04.12.2024.
//

import Foundation

extension StatisticsView {
    final class ViewModel: ObservableObject {
        @Published var showQuests = false
        @Published var showRecommendations = false
        
        @Published var productiveTimePercent = 0.0
        @Published var unproductiveTimePercent = 0.0
        @Published var tasks: [TaskModel] = []
        private var timer: Timer?
        
        let questItems: [QuestsModel] = [
            .init(
                priority: 0,
                title: "Zacznij sukcesem",
                subtitle: "Nagroda: 10 punktów doświadczenia, +1 do wskaźnika produktywności.",
                text: "Za wykonanie zadań"
            ),
            
            .init(
                priority: 0,
                title: "Nie jestem rozproszony!",
                subtitle: "Nagroda: 20 punktów doświadczenia, unikalna ikona zadania",
                text: "Dla produktywności"
            ),
            
                .init(
                    priority: 1,
                    title: "Tydzień w służbie",
                    subtitle: "Nagroda: 70 punktów doświadczenia, specjalna odznaka „Żelazna Dyscyplina”",
                    text: "O długoterminową dyscyplinę"
                ),
            
                .init(
                    priority: 1,
                    title: "Czas pod kontrolą",
                    subtitle: "Nagroda: 20 punktów doświadczenia, unikalna ikona „zegarmistrza”. „Król terminów”",
                    text: "Za szczególne osiągnięcia"
                ),
            
                .init(
                    priority: 2,
                    title: "Powrót na właściwe tory",
                    subtitle: "Nagroda: 60 punktów doświadczenia, otwarcie osobistej rekomendacji „Jak nie zbłądzić”.",
                    text: "Aby wyeliminować zwlekanie"
                ),
            
                .init(
                    priority: 2,
                    title: "Zwycięzca Roku",
                    subtitle: "Nagroda: 500 punktów doświadczenia, tytuł Mistrza Produktywności, ekskluzywny motyw interfejsu.",
                    text: "Za korzystanie z aplikacji"
                )
        ]
        
        let recommendationItems: [QuestsModel] = [
            .init(
                title: "Wytyczne planowania",
                text: """
                „Rozbij duże zadania na części” Duże zadania mogą wydawać się przytłaczające i powodować stres. Aby ułatwić zarządzanie nimi, spróbuj podzielić je na kilka małych kroków. Na przykład, jeśli chcesz przygotować prezentację, najpierw zbierz materiały, następnie utwórz konspekt, a następnie rozpocznij jego projektowanie. Pracując w ten sposób, możesz łatwo monitorować swoje postępy i zachować motywację.
                
                „Znajdź czas na priorytetowe zadania” Bardzo ważne jest, aby rozpocząć dzień od rzeczy, które są naprawdę ważne. Często ludzie odkładają skomplikowane lub znaczące zadania, przechodząc na prostsze i mniej istotne. W rezultacie zadania priorytetowe pozostają niedokończone. Spróbuj zarezerwować godziny poranne na pracę nad zadaniami o wysokim priorytecie, kiedy jesteś najbardziej skoncentrowany i pełen energii.
                
                „Planuj z wyprzedzeniem” Nawyk planowania poprzedniego wieczoru pomaga rozpocząć następny dzień z jasnym zrozumieniem swoich zadań. Zamiast marnować czas rano na zastanawianie się, co zrobić, od razu zabierzesz się do pracy. Zapisz 3-5 kluczowych zadań, które należy wykonać jutro i rozłóż je w czasie.
                """),
            .init(
                title: "Zarządzanie czasem",
                text: """
                „Użyj techniki Pomodoro” Jeśli zauważysz, że masz trudności z utrzymaniem koncentracji, spróbuj pracować z techniką Pomodoro. Metoda ta polega na 25 minutach pracy w pełnym skupieniu na zadaniu i 5 minutach odpoczynku. Rytm ten pomaga zmniejszyć zmęczenie i zwiększyć produktywność. Po każdych 4 cyklach zrób dłuższą przerwę – około 15-30 minut.
                
                „Zaplanuj czas meldowania się” Wiele osób rozpraszają się komunikatorami internetowymi, pocztą elektroniczną lub sieciami społecznościowymi, co zmniejsza produktywność. Spróbuj zarezerwować określone godziny sprawdzania wiadomości, np. 11:00 i 16:00. Przez resztę czasu wyłącz powiadomienia, aby móc skupić się na zadaniu.
                
                „Rób przerwy” Wielogodzinna praca bez przerwy może mieć szkodliwy wpływ na zdrowie i produktywność. Rób 10-minutowe przerwy co 1–2 godziny. Czas ten można wykorzystać na lekką aktywność fizyczną, która rozciągnie mięśnie i pozwoli odpocząć oczom.
                """),
            .init(
                title: "Aby wyeliminować czynniki rozpraszające",
                text: """
                „Wyłącz powiadomienia” Nowoczesne urządzenia dosłownie bombardują nas powiadomieniami: połączeniami, wiadomościami, aktualizacjami aplikacji. Każde rozproszenie kosztuje Cię nie tylko stratę czasu, ale także kilka minut potrzebnych na odzyskanie koncentracji. Wyłącz powiadomienia lub włącz tryb Nie przeszkadzać podczas pracy nad ważnymi zadaniami.
                
                „Stwórz relaksujące środowisko pracy” Efektywna praca zaczyna się od komfortowego środowiska pracy. Zadbaj o porządek w miejscu pracy: usuń wszystkie niepotrzebne rzeczy, które mogą Cię rozpraszać, przygotuj niezbędne materiały. Jeśli pracujesz w domu, powiedz swoim bliskim, aby nie przeszkadzali Ci w określonych porach. Spokojna atmosfera pomoże Ci szybciej osiągnąć rezultaty.
                
                „Zacznij od małych kroków” Jeśli nie możesz rozpocząć zadania, które wydaje się trudne lub nudne, zacznij od najprostszej rzeczy. Na przykład, jeśli chcesz napisać raport, po prostu otwórz dokument i wpisz tytuł. Często ten mały krok pomaga pokonać wewnętrzną barierę i zaangażować się w pracę.
                """),
            .init(
                title: "Poprzez analizę czasu",
                text: """
                „Przeanalizuj swój nieproduktywny czas” Odwlekanie i rozpraszanie uwagi są nieuniknione, ale ważne jest, aby zrozumieć, ile czasu na nie marnujesz. Z naszej analizy wynika, że ​​dzisiaj spędziłeś 2 godziny na zadaniach o niskim priorytecie i mediach społecznościowych. Zastanów się, jak możesz rozdysponować ten czas, aby zrobić więcej.
                
                „Porównaj plan z rzeczywistością” Jeśli Twoje zadania często trwają dłużej niż planowałeś, może to świadczyć o nadmiernym optymizmie. Spróbuj dodać kolejne 10-15% czasu do każdego zaplanowanego bloku na wypadek nieoczekiwanych opóźnień. Dzięki temu poczujesz się mniej zestresowany i będziesz mieć większą pewność siebie.
                
                „Poszukaj wzorców” Przyjrzyj się swoim danym czasowym z ostatniego tygodnia. Możesz zauważyć, że jesteś najbardziej produktywny rano między 9 a 11, a mniej energii masz po południu. Użyj tych danych, aby zaplanować ważne zadania w godzinach szczytu produktywności.
                """),
            .init(
                title: "Według produktywności",
                text: """
                „Skoncentruj się na jednym zadaniu” Wielozadaniowość stwarza iluzję produktywności, ale w rzeczywistości obniża koncentrację i jakość pracy. Jeśli masz dużo do zrobienia, określ najważniejsze zadanie i poświęć mu całą swoją uwagę. Po jego ukończeniu przejdź do następnego.
                
                „Szukaj prostych rozwiązań” Czasami sami komplikujemy problemy, nawet jeśli istnieją prostsze sposoby ich rozwiązania. Zastanów się, czy możesz oddelegować część pracy, skorzystać z gotowych szablonów, czy też zautomatyzować rutynowe procesy. Dzięki temu zaoszczędzisz czas i wysiłek.
                
                „Wyznaczaj realistyczne terminy”Terminy, które są trudne do dotrzymania, mogą prowadzić do stresu i spadku motywacji. Upewnij się, że Twoje terminy są realistyczne. Jeśli zadanie zajmuje 3 godziny, nie próbuj wykonać go w ciągu 1 godziny. Poprawi to jakość Twojej pracy i Twój stan emocjonalny.
                """),
            .init(
                title: "Zwalczanie prokrastynacji",
                text: """
                „Nagradzaj się za wykonanie zadań” Motywacja działa lepiej, jeśli wykonywanie zadań kojarzysz z przyjemnymi nagrodami. Na przykład obiecaj sobie filiżankę kawy lub obejrzenie ulubionego serialu po wykonaniu trudnego zadania. Tego rodzaju zachęta zwiększa Twoją motywację do działania.
                
                „Minimalizuj prokrastynację” Odkładanie zadań na później, zwłaszcza jeśli są trudne lub nudne, jest rzeczą normalną. Zacznij od małych rzeczy: poświęć tylko 5 minut na wykonanie zadania. Często te 5 minut pomaga Ci „przyspieszyć” i kontynuujesz pracę, nie zauważając już upływu czasu.
                
                „Nie bój się niedoskonałych rezultatów” Czasami zwlekanie jest kojarzone z perfekcjonizmem. Boisz się, że wynik nie będzie idealny, a to uniemożliwia Ci rozpoczęcie. Przypomnij sobie, że zrobienie czegoś na 80% jest lepsze niż nierobienie niczego. Zawsze możesz poprawić wynik później.
                """),
        ]
        
        func getTasks() {
            DispatchQueue.global().async { [weak self] in
                guard let self else { return }
                let tasks = DefaultsService.shared.tasks
                let startedTasks = tasks.filter { $0.dateStarted != nil }
                DispatchQueue.main.async { [self] in
                    self.tasks = tasks
                    self.calculateTimePercent(tasks: startedTasks)
                    self.startTimer()
                }
            }
        }
        
        private func calculateTimePercent(tasks: [TaskModel]) {
            guard !tasks.isEmpty else { return }
            
            let estimatedTime = tasks.map { $0.executionTime * 60 }.reduce(0) { $0 + $1 }
            let totalCompletedTime = tasks.map { $0.executedMinutes }.reduce(0) { $0 + $1 }
            
            if totalCompletedTime > estimatedTime {
                let extraTime = totalCompletedTime - estimatedTime
                unproductiveTimePercent = Double(extraTime) / Double(totalCompletedTime)
                
                let plannedTime = totalCompletedTime - extraTime
                productiveTimePercent = Double(plannedTime) / Double(totalCompletedTime)
            } else {
                productiveTimePercent = Double(totalCompletedTime) / Double(estimatedTime)
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

struct QuestsModel: Identifiable {
    private(set) var id = UUID().uuidString
    var priority: Int?
    var title: String
    var subtitle: String?
    var text: String
}
