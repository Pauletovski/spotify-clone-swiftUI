//
//  ProgressBar.swift
//  SpotifyClone1
//
//  Created by Paulo Lazarini on 21/07/23.
//

import SwiftUI

struct ProgressBar: View {
    @State var screenWidth: CGFloat = 0.0
    
    @Binding var progressWidth: CGFloat
    @Binding var musicFullSeconds: Int
    @Binding var currentMinute: Int
    @Binding var shouldPlay: Bool
    @Binding var shouldReplay: Bool
    @Binding var album: Album
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Color.boxgray.ignoresSafeArea()
            
            VStack {
                progressBar
                    .onReceive(timer, perform: { _ in
                        if currentMinute != musicFullSeconds && shouldPlay {
                            onSecondChange()
                        } else {
                            shouldPlay = false
                            if shouldReplay {
                                currentMinute = 0
                                progressWidth = 0
                                shouldPlay = true
                            }
                        }
                    })
            }
        }
    }
    
    func onSecondChange() {
        let t: CGFloat = screenWidth / CGFloat(musicFullSeconds)
        progressWidth += t
        currentMinute += 1
    }
    
    var progressBar: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: screenWidth, height: 5)
                .foregroundStyle(.gray)
            
            HStack(spacing: .zero) {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: progressWidth, height: 5)
                    .foregroundStyle(.white)
            }
            .offset(x: (-screenWidth / 2) + progressWidth / 2)
        }
    }
}

#Preview {
    MusicView(viewModel: MusicViewModel(album: albums[3]))
}

