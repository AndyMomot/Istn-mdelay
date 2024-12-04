//
//  MotivationsViewModel.swift
//  Istnymdelay
//
//  Created by Andrii Momot on 03.12.2024.
//

import Foundation

extension MotivationsView {
    final class ViewModel: ObservableObject {
        var motivations: [MotivationModel] = [
            .init(title: "Co byś zrobił, gdybyś nie zwlekał?",
                  text: "Zwlekanie często powoduje, że odkładamy ważne rzeczy na później, ale każde opóźnienie oznacza utratę szans i zmniejszenie szans na sukces. Wyobraź sobie, co byś zrobił, gdybyś nie bał się zacząć? Gdybyś nie szukał wymówek i tracił czasu na wątpliwości? Zrób plan, podziel zadania na części i zacznij już teraz. Nie czekaj na „najlepszy moment” – nadejdzie on dopiero, gdy zaczniesz działać. Pamiętaj, że małe kroki dzisiaj prowadzą do wielkich rezultatów jutro."),
            .init(title: "Jak wygląda Twój idealny dzień?",
                  text: "Gdybyś mógł stworzyć swój idealny dzień, co byś zrobił? Jak wyobrażałbyś sobie swój dzień, gdyby wszystko poszło zgodnie z planem i osiągnąłbyś najwyższą produktywność? Godzina po godzinie możesz osiągnąć wszystkie swoje cele, a na koniec dnia będziesz dumny ze swojego sukcesu. Teraz możesz sprawić, że ten dzień stanie się rzeczywistością. Nie pozwól, aby odkładanie spraw na później lub rozpraszanie uwagi marnowały Twój cenny czas. Podziel zadania na mniejsze, aby nie wydawały się zbyt trudne, i idź do przodu. Twój idealny dzień zaczyna się od dzisiejszego kroku."),
            .init(title: "Czy jesteś gotowy na sukces?",
                  text: "Sukces nie przychodzi sam. Opiera się na każdej Twojej decyzji i działaniu. Każdego dnia podejmujesz decyzje, które albo przybliżają Cię do sukcesu, albo oddalają. Aby osiągnąć to, czego chcesz, musisz zrobić to, co inni odkładają i działać, gdy inni wątpią. Pamiętaj, że sukces to nie jeden ogromny wysiłek, ale zbiór małych zwycięstw, które osiągasz każdego dnia. Czy jesteś gotowy na sukces? Zacznij już dziś i niech każde podjęte przez Ciebie działanie będzie krokiem w stronę Twoich celów."),
            .init(title: "Co się stanie, jeśli zaczniesz już teraz?",
                  text: "Nie zawsze łatwo jest zrobić pierwszy krok. Często nie jesteśmy pewni, czy podołamy danemu zadaniu i odkładamy je na później. Ale co się stanie, jeśli zaczniesz już teraz? Moment, w którym zajmiesz się biznesem, będzie punktem zwrotnym w Twojej produktywności. Może się okazać, że zadanie nie jest tak trudne, jak myślałeś. Możesz nawet cieszyć się tym procesem. Najważniejsze, żeby nie marnować czasu na wątpliwości. Możesz to zrobić! Zrób pierwszy krok, a przyszłość będzie łatwiejsza."),
            .init(title: "Czy zrobiłeś dzisiaj krok do przodu?",
                  text: "Każdy dzień daje nam szansę stania się lepszymi. Nawet jeśli nie udało Ci się osiągnąć wszystkich celów, nie zapominaj, że każdy krok, choćby najmniejszy, przybliża Cię do sukcesu. Już dziś możesz zrobić coś, co przyniesie korzyść Twojej przyszłości. Możesz mieć wrażenie, że przed Tobą jeszcze dużo pracy, ale jedyne, co musisz zrobić, to każdego dnia robić przynajmniej jeden krok do przodu. Najważniejsze to się nie zatrzymywać. Nawet jeśli będziesz robić małe kroki, nadal będziesz posuwać się do przodu. I to jest najważniejsze."),
            .init(title: "Co możesz zrobić w 10 minut?",
                  text: "Nie zawsze potrzeba dużo czasu, aby zrobić coś znaczącego. Czasami wystarczy tylko 10 minut. 10 minut na rozpoczęcie pracy nad projektem, uporządkowanie spraw, zrozumienie, co należy dalej zrobić. 10 minut na wykonanie pierwszego kroku i rozpoczęcie procesu. Czasami nie liczy się ilość czasu, ale jego prawidłowe wykorzystanie. Masz teraz 10 minut. Wydaj go mądrze. Zacznij od tego, co odkładałeś, a zobaczysz, jak powoli zacznie się ten ruch. Będziesz zaskoczony, jak wiele możesz osiągnąć w krótkim czasie, jeśli skupisz się na jednej rzeczy i zaczniesz już teraz."),
        ]
        var motivationToShow: MotivationModel?
        @Published var showDetails = false
    }
}

struct MotivationModel: Identifiable, Hashable {
    private(set) var id = UUID().uuidString
    var title, text: String
}
