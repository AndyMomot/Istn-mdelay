//
//  MotivationDetailsView.swift
//  Istnymdelay
//
//  Created by Andrii Momot on 04.12.2024.
//

import SwiftUI

struct MotivationDetailsView: View {
    var item: MotivationModel
    
    var body: some View {
        ZStack {
            Asset.listBg.swiftUIImage
                .resizable()
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 20) {
                BackButton(title: item.title)
                
                ScrollView {
                    Text(item.text)
                        .foregroundStyle(.greenUltraLite)
                        .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 20))
                        .multilineTextAlignment(.leading)
                        .lineSpacing(4)
                        .padding(20)
                        .background(.greenCustom)
                        .cornerRadius(20, corners: .allCorners)
                }
                .scrollIndicators(.never)
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    MotivationDetailsView(
        item: .init(
            title: "Co byś zrobił, gdybyś nie zwlekał?",
            text: "Zwlekanie często powoduje, że odkładamy ważne rzeczy na później, ale każde opóźnienie oznacza utratę szans i zmniejszenie szans na sukces. Wyobraź sobie, co byś zrobił, gdybyś nie bał się zacząć? Gdybyś nie szukał wymówek i tracił czasu na wątpliwości? Zrób plan, podziel zadania na części i zacznij już teraz. Nie czekaj na „najlepszy moment” – nadejdzie on dopiero, gdy zaczniesz działać. Pamiętaj, że małe kroki dzisiaj prowadzą do wielkich rezultatów jutro."))
}
