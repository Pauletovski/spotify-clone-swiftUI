//
//  HomeView.swift
//  SpotifyClone1
//
//  Created by Paulo Lazarini on 14/07/23.
//

import SwiftUI

struct HomeScreenView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    @ObservedObject var musicViewModel: MusicViewModel

    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ZStack {
            Color.boxgray.ignoresSafeArea()
            
            VStack {
                header
                
                ScrollView(.vertical, showsIndicators: true) {
                    VStack(spacing: 45) {
                        playlistRecomendations(playlistsInfo: viewModel.playlist)
                            
                        trendingNowView(songsInfo: albums)
                            
                        topPicksView(playlistsInfo: viewModel.playlist)
                    }
                    .padding(.bottom, 45)
                }
            }
            .padding(.horizontal, 10)
        }
        .overlay(alignment: .bottom) {
            if viewModel.album != nil {
                MusicPlayingView(viewModel: musicViewModel,
                                 album: $viewModel.album,
                                 passtrough: viewModel.onEvent)
                .padding(.vertical, 5)
            }
        }

    }
    
    func subtitle(_ text: String) -> some View {
        Text(text)
            .bold()
            .font(.system(size: 28))
            .foregroundColor(.white)
    }
    
    func topPicksView(playlistsInfo: [Playlist]) -> some View {
        VStack(alignment: .leading, spacing: 20) {
            subtitle("Top picks for you")
              
            
            LazyVGrid(columns: columns) {
                ForEach(playlistsInfo, id: \.self) { info in
                    playlistRecomendations(playlistInfo: info)
                }
            }
        }
    }
    
    func playlistRecomendations(playlistsInfo: [Playlist]) -> some View {
        LazyVGrid(columns: columns) {
            ForEach(playlistsInfo, id: \.self) { info in
                playlistRecomendations(playlistInfo: info)
            }
        }
    }
    
    func playlistRecomendations(playlistInfo: Playlist) -> some View {
        VStack(alignment: .leading) {
            Button {
                viewModel.onPresentPlaylist.send(playlistInfo)
            } label: {
                Image(playlistInfo.img)
                    .resizable()
                    .frame(width: 175, height: 175)
                    .foregroundColor(.white)
            }

            Text(playlistInfo.name)
                .foregroundColor(.gray)
                .font(.system(size: 14))
                .bold()
        }
    }
    
    func trendingNowView(songsInfo: [Album]) -> some View {
        VStack(alignment: .leading) {
            subtitle("Trending now")
            
            ScrollView(.horizontal) {
                HStack(spacing: 16) {
                    ForEach(songsInfo, id: \.self) { song in
                        trendingNowCell(songInfo: song)
                    }
                }
            }
        }
    }
    
    func trendingNowCell(songInfo: Album) -> some View {
        VStack(alignment: .leading) {
            Image(songInfo.img)
                .resizable()
                .frame(width: 175, height: 175)
                .foregroundColor(.white)
            
            Text(songInfo.artist)
                .foregroundColor(.gray)
                .font(.system(size: 18))
                .bold()
            
            Text("Song . \(songInfo.artist)")
                .foregroundColor(.gray)
                .font(.system(size: 14))
                .bold()
        }
    }
    
    var header: some View {
        HStack {
            subtitle("Made for you")
            
            Spacer()
            
            headerButtons
        }
        .foregroundColor(.white)
    }
    
    var headerButtons: some View {
        HStack(spacing: 28) {
            Button {
                
            } label: {
                Image(systemName: "bell")
                    .resizable()
                    .frame(width: 20, height: 20)
            }
            
            Button {
                
            } label: {
                Image(systemName: "clock.arrow.circlepath")
                    .resizable()
                    .frame(width: 20, height: 20)
            }
            
            Button {
                
            } label: {
                Image(systemName: "gearshape")
                    .resizable()
                    .frame(width: 20, height: 20)
            }
        }
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView(viewModel: HomeViewModel(playlist: playlists), musicViewModel: MusicViewModel(album: albums.first!))
    }
}
