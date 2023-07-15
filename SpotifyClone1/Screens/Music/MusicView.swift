//
//  MusicView.swift
//  SpotifyClone1
//
//  Created by Paulo Lazarini on 14/07/23.
//

import SwiftUI

struct MusicView: View {
    
    @ObservedObject var viewModel: MusicViewModel
    
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
            Color.boxgray.ignoresSafeArea()
            
            VStack {
                buildHeader
                
                buildAlbumImage
                    .gesture(drag)
                
                buildAlbumsInfos
                
                progressBar
                
                buttonsView
                
                Spacer()
            }
            .padding(.horizontal, 20)
        }
    }
    
    var buttonsView: some View {
        HStack {
            Button {
                viewModel.shouldShuffle.toggle()
            } label: {
                Image(systemName: "shuffle")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundStyle(viewModel.shouldShuffle ? .green : .white)
            }
            
            Spacer()
            
            Button {
                viewModel.onEvent.send(.previousSong)
            } label: {
                Image(systemName: "backward.end")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundStyle(.white)
            }
            
            Spacer()
            
            Button {
                viewModel.shouldPlay.toggle()
            } label: {
                ZStack(alignment: .center) {
                    Circle()
                        .frame(width: 65, height: 65)
                        .foregroundStyle(.white)
                    
                    Image(systemName: viewModel.shouldPlay ? "pause.fill" : "play.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundStyle(.black)
                        .offset(x: viewModel.shouldPlay ? 0 : 4)
                    
                }
            }
            
            Spacer()
            
            Button {
                viewModel.onEvent.send(.nextSong)
            } label: {
                Image(systemName: "forward.end")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundStyle(.white)
            }
            
            Spacer()
            
            Button {
                viewModel.shouldRepeat.toggle()
            } label: {
                Image(systemName: "repeat")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundStyle(viewModel.shouldRepeat ? .green : .white)
            }
        }
        .padding(.horizontal, 15)
    }
    
    var progressBar: some View {
        ProgressDraggableBar(screenWidth: UIScreen.main.bounds.width - 60,
                             progressWidth: $viewModel.progressWidth,
                             musicFullSeconds: $viewModel.musicFullSeconds,
                             currentMinute: $viewModel.currentMinute,
                             shouldPlay: $viewModel.shouldPlay,
                             shouldReplay: $viewModel.shouldRepeat,
                             album: $viewModel.album)
    }
    
    var buildAlbumsInfos: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(viewModel.album.album)
                    .font(.system(size: 24, weight: .bold))
                    .lineLimit(1)
                    .foregroundStyle(.white)
                
                Text(viewModel.album.artist)
                    .font(.system(size: 21))
                    .lineLimit(1)
                    .foregroundStyle(.gray)
            }
            
            Spacer()
            
            Button {
                viewModel.isFavorite.toggle()
            } label: {
                Image(systemName: viewModel.isFavorite ? "heart.fill" : "heart")
                    .resizable()
                    .frame(width: 32, height: 28)
                    .foregroundStyle(viewModel.isFavorite ? .red : .white)
            }
            .padding(.leading, 10)
        }
        .padding(.horizontal, 15)
        .padding(.top, 45)
    }
    
    var buildAlbumImage: some View {
        Image(viewModel.album.img)
            .resizable()
            .frame(width: 362, height: 410)
            .padding(.top, 45)
            .offset(x: progressY)
    }
    
    var buildHeader: some View {
        ZStack {
            HStack {
                Button {
                    viewModel.onEvent.send(.onDismiss)
                } label: {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .frame(width: 13, height: 25)
                        .rotationEffect(Angle(degrees: -90))
                }

                Spacer()
            }
            
            VStack {
                Text("PLAYING FROM PLAYLIST")
                    .font(.system(size: 14))
                
                Text("'\(viewModel.album.album)' in Songs")
                    .font(.system(size: 16, weight: .semibold))
                    .lineLimit(1)
            }
            
            HStack {
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: "ellipsis")
                        .resizable()
                        .frame(width: 24, height: 6)
                        .rotationEffect(Angle(degrees: 90))
                }
            }
        }
        .padding(.top)
        .foregroundStyle(.white)
    }
}

#Preview {
    MusicView(viewModel: MusicViewModel(album: albums[3]))
}
