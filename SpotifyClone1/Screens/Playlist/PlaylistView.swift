//
//  PlaylistView.swift
//  SpotifyClone1
//
//  Created by Paulo Lazarini on 14/07/23.
//

import SwiftUI

struct PlaylistView: View {
    
    let playlist: Playlist
    
    @ObservedObject var viewModel: PlaylistViewModel
    @State var index = 0
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(alignment: .leading) {
                ScrollView {
                    headerImage
                    
                    playlistName
                    
                    playlistCreator
                    
                    playlistLikes
                    
                    playlistButtons
                    
                    songs(albums: albums)
                }
            }
            .padding(.horizontal, 16)
        }
    }
    
    func songs(albums: [Album]) -> some View {
        ForEach(albums, id: \.self) { album in
            song(album: album)
        }
    }
    
    func song(album: Album) -> some View {
        Button {
            viewModel.onEvent.send(.presentMusicDetails(album))
        } label: {
            HStack {
                Image(album.img)
                    .resizable()
                    .frame(width: 65, height: 65)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(album.album)
                        .foregroundStyle(.white)
                        .bold()
                        .font(.system(size: 18))
                        .lineLimit(1)
                    
                    Text(album.artist)
                        .foregroundStyle(.gray)
                        .font(.system(size: 14))
                }
                
                Spacer()
                
                Button {

                } label: {
                    Image(systemName: "ellipsis")
                        .resizable()
                        .frame(width: 24, height: 6)
                        .rotationEffect(Angle(degrees: 90))
                        .foregroundStyle(.white)
                        .padding(.leading, 24)
                }
            }
        }
    }
    
    var playlistButtons: some View {
        HStack {
            Button {
                viewModel.isFavorite.toggle()
            } label: {
                Image(systemName: viewModel.isFavorite ? "heart.fill" : "heart")
                    .resizable()
                    .frame(width: 32, height: 28)
                    .foregroundStyle(viewModel.isFavorite ? .red : .white)
            }
            
            Button {

            } label: {
                Image(systemName: "ellipsis")
                    .resizable()
                    .frame(width: 24, height: 6)
                    .rotationEffect(Angle(degrees: 90))
                    .foregroundStyle(.white)
                    .padding(.leading, 24)
            }
            
            Spacer()
            
            Button {
                
            } label: {
                ZStack(alignment: .center) {
                    Circle()
                        .frame(width: 65, height: 65)
                        .foregroundStyle(.green)
                    
                    Image(systemName: "play.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundStyle(.black)
                        .offset(x: 4)
                        
                }
            }
        }
        .padding(.bottom)
    }
    
    var playlistLikes: some View {
        HStack {
            Text("\(Int.random(in: 1..<1000000)) likes.")
                .foregroundStyle(.gray)
                .font(.system(size: 14))
            
            Text(String("3h 45min"))
                .foregroundStyle(.gray)
                .font(.system(size: 14))
            
            Spacer()
        }
        .padding(.bottom)
    }
    
    var playlistCreator: some View {
        HStack {
            Image("icon")
                .resizable()
                .frame(width: 26, height: 26)
            
            Text(playlist.creator)
                .foregroundStyle(.white)
                .bold()
                .font(.system(size: 20))
            
            Spacer()
        }
        .padding(.bottom)
    }

    
    var playlistName: some View {
        HStack {
            Text(playlist.name)
                .foregroundStyle(.gray)
                .font(.system(size: 18))
            
            Spacer()
        }
        .padding(.vertical)
    }
    
    var headerImage: some View {
        ZStack {
            backButton
            
            Image(playlist.img)
                .resizable()
                .frame(width: 255, height: 285)
        }
        .padding(.vertical)
    }
    
    var backButton: some View {
        Button {
            viewModel.onEvent.send(.onDismiss)
        } label: {
            HStack {
                VStack {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .frame(width: 13, height: 25)
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                Spacer()
            }
        }
    }
}

#Preview {
    PlaylistView(playlist: playlists[0], viewModel: PlaylistViewModel())
}
