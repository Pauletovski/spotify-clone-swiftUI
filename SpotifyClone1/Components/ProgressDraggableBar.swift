//
//  ProgressDraggableBar.swift
//  SpotifyClone1
//
//  Created by Paulo Lazarini on 20/07/23.
//

import SwiftUI
import Combine

struct ProgressDraggableBar: View {
    @State var isDragging: Bool = false
    @State var screenWidth: CGFloat = 0.0
    
    @Binding var progressWidth: CGFloat
    @Binding var musicFullSeconds: Int
    @Binding var currentMinute: Int
    @Binding var shouldPlay: Bool
    @Binding var shouldReplay: Bool
    @Binding var album: Album
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var drag: some Gesture {
        DragGesture()
            .onChanged { value in
                if screenWidth > value.startLocation.x + value.translation.width {
                    progressWidth = value.startLocation.x + value.translation.width
                    
                    let t: CGFloat = screenWidth / CGFloat(musicFullSeconds)
                    currentMinute = Int(progressWidth / t)
                }
                
                if progressWidth < 0 {
                    progressWidth = 0
                }
                
                self.isDragging = true
            }
    }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                progressBar
                    .onReceive(timer, perform: { _ in
                        if currentMinute != musicFullSeconds && shouldPlay {
                            onSecondChange()
                            isDragging = true
                        } else {
                            shouldPlay = false
                            if shouldReplay {
                                currentMinute = 0
                                progressWidth = 0
                                shouldPlay = true
                            }
                        }
                    })
                
                HStack {
                    Text(String(turnIntIntoMinute(currentMinute)))
                    
                    Spacer()
                    
                    Text(turnIntIntoMinute(musicFullSeconds))
                }
                .padding(.horizontal)
                .foregroundStyle(.gray)
                .font(.system(size: 14, weight: .semibold))
            }
        }
    }
    
    func onSecondChange() {
        let t: CGFloat = screenWidth / CGFloat(musicFullSeconds)
        progressWidth += t
        currentMinute += 1
    }
    
    func turnIntIntoMinute(_ int: Int) -> String {
        var minutes: Int = int / 60
        var seconds: Int = int % 60
        
        if seconds < 0 {
            return "00:00"
        }
        
        return seconds > 9 ? "\(minutes):\(seconds)" : "\(minutes):0\(seconds)"
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
                Circle()
                    .frame(width: 10, height: 10)
                    .foregroundStyle(.white)
                
            }
            .gesture(drag)
            .offset(x: isDragging ? (-screenWidth / 2) + progressWidth / 2 : -screenWidth / 2)
        }
    }
}

#Preview {
    MusicView(viewModel: MusicViewModel(album: albums[3]))
}
