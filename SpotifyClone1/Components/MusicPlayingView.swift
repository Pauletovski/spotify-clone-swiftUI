//
//  MusicPlayingView.swift
//  SpotifyClone1
//
//  Created by Paulo Lazarini on 21/07/23.
//

import SwiftUI
import Combine

struct MusicPlayingView: View {
    
    @ObservedObject var viewModel: MusicViewModel
    
    @Binding var album: Album?
    let passtrough: PassthroughSubject<PlaylistViewModel.Event, Never>
    
    @State var progressY: CGFloat = 0
    
    var drag: some Gesture {
        DragGesture()
            .onChanged { value in
                progressY = value.translation.width
            }
            .onEnded { value in
                if progressY > 50 {
                    viewModel.onEvent.send(.previousSong)
                }
                
                if progressY < -40 {
                    viewModel.onEvent.send(.nextSong)
                }
                
                progressY = 0
            }
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.blue)
            
            leftInfo
                .padding(.leading, 10)
            
            rightInfo
                .padding(.trailing, 10)
            
            progressBar
                .frame(height: 5)
                .offset(y: 70 / 2)
        }
        .gesture(drag)
        .padding(.horizontal)
        .frame(height: 65)
        .onTapGesture {
            if let album = album {
                passtrough.send(.presentMusicDetails(album))
            }
        }
    }
    
    var leftInfo: some View {
        HStack {
            Image(album?.img ?? "")
                .resizable()
                .frame(width: 55, height: 50)
                .zIndex(1)
            
            HStack {
                Text(album?.album ?? "")
                    .font(.system(size: 16))
                    .foregroundStyle(.white)
                    .lineLimit(1)
                
                Text(".")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundStyle(.white)
                    .offset(y: -10)
                
                
                Text(album?.artist ?? "")
                    .font(.system(size: 14))
                    .foregroundStyle(.gray)
                    .lineLimit(1)
            }
            .offset(x: progressY)
            
            Spacer()
        }
    }
    
    var rightInfo: some View {
        HStack(spacing: 20) {
            Spacer()
            
            Button {
                
            } label: {
                Image(systemName: "headphones")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(.green)
            }
            
            
            Button {
                viewModel.shouldPlay.toggle()
            } label: {
                Image(systemName: viewModel.shouldPlay ? "pause.fill" : "play.fill")
                    .resizable()
                    .frame(width: 15, height: 15)
                    .foregroundStyle(.white)
            }
        }
    }
    
    var progressBar: some View {
        ProgressBar(screenWidth: UIScreen.main.bounds.width - 50,
                    progressWidth: $viewModel.progressWidth,
                    musicFullSeconds: $viewModel.musicFullSeconds,
                    currentMinute: $viewModel.currentMinute,
                    shouldPlay: $viewModel.shouldPlay,
                    shouldReplay: $viewModel.shouldRepeat,
                    album: $viewModel.album)
    }
}

#Preview {
    PlaylistView(playlist: playlists[0], viewModel: PlaylistViewModel(), musicViewModel: MusicViewModel(album: albums.first!))
}
