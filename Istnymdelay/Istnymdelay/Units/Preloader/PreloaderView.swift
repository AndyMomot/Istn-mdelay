//
//  PreloaderView.swift
//  Libarorent
//
//  Created by Andrii Momot on 06.10.2024.
//

import SwiftUI

struct PreloaderView: View {
    
    var onDidLoad: () -> Void
    
    @State private var timer: Timer?
    @State private var progress: Double = 0.0
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        ZStack {
            Colors.greenUltraLite.swiftUIColor
                .ignoresSafeArea()
            
                Asset.logo.swiftUIImage
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, 37)
            
            VStack {
                Spacer()
                VStack(spacing: 20) {
                    Text("Načítání")
                        .foregroundStyle(.greenMiddle)
                        .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 30))
                    DotsProgressView(progress: progress)
                }
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 30)
        }
        .onAppear {
            startTimer()
        }
    }
}

private extension PreloaderView {
    func startTimer() {
        stopTimer()
        
        timer = .scheduledTimer(withTimeInterval: 0.1,
                                repeats: true, block: { timer in
            updateProgress(value: 0.05)
        })
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func updateProgress(value: Double) {
        DispatchQueue.main.async {
            if progress + value > 1 {
                withAnimation {
                    progress = 1
                }
                stopTimer()
                onDidLoad()
            } else {
                withAnimation {
                    progress = progress + value
                }
            }
        }
    }
}

#Preview {
    PreloaderView {}
}
