//
//  LibraryView.swift
//  SpotifyClone1
//
//  Created by Paulo Lazarini on 24/07/23.
//

import SwiftUI
import Combine

struct LibraryView: View {
    
    @ObservedObject var musicViewModel: MusicViewModel
    @ObservedObject var viewModel: LibraryViewModel
    
    var body: some View {
        ZStack {
            Color.boxgray.ignoresSafeArea()
            
            ScrollView {
                navButtons
                
                if viewModel.isMusicSelected {
                    subNavButtons(subButtons: viewModel.musicSubButtons)
                    
                    if viewModel.selectedIndex == 1 {
                        buildPlaylistView()
                    }
                    
                    if viewModel.selectedIndex == 2 {
                        buildArtistsView()
                    }
                    
                    if viewModel.selectedIndex == 3 {
                        buildAlbumsView()
                    }
                    
                }
                
                if viewModel.isPodcastsSelected {
                    subNavButtons(subButtons: viewModel.podcastSubButtons)
                }
            }
            .padding(.horizontal, 16)
        }
        .overlay(alignment: .bottom) {
            if viewModel.album != nil {
                MusicPlayingView(viewModel: musicViewModel,
                                 album: $viewModel.album,
                                 passtrough: viewModel.onMusicEvent)
                .padding(.vertical, 5)
            }
        }

    }
    
    var navButtons: some View {
        HStack(spacing: 20) {
            Button {
                viewModel.isMusicSelected = true
                viewModel.isPodcastsSelected = false
            } label: {
                Text("Music")
                    .foregroundStyle(viewModel.isMusicSelected ? .green : .white)
            }
            
            Button {
                viewModel.isMusicSelected = false
                viewModel.isPodcastsSelected = true
            } label: {
                Text("Podcasts")
                    .foregroundStyle(viewModel.isPodcastsSelected ? .green : .white)
            }
            
            Spacer()
        }
        .font(.system(size: 36, weight: .bold))
        .padding(.vertical, 16)
        
    }
    
    func subNavButtons(subButtons: [SubButtons]) -> some View {
        HStack(spacing: 20) {
            ForEach(subButtons) { button in
                subNavButton(subButton: button)
            }
            
            Spacer()
        }
    }
    
    func subNavButton(subButton: SubButtons) -> some View {
        Button {
            viewModel.onEvent.send(subButton.type)
            viewModel.selectedIndex = subButton.id
        } label: {
            Text(subButton.name)
                .foregroundStyle(viewModel.selectedIndex == subButton.id ? .green : .white)
                .bold()
                
        }
    }
    
    func buildPlaylistView() -> some View {
        VStack {
            ForEach(viewModel.playlist, id: \.self) { playlist in
                playlistCell(playlist: playlist)
            }
        }
    }
    
    func playlistCell(playlist: Playlist) -> some View {
        Button {
            viewModel.onEvent.send(.presentPlaylist(playlist))
        } label: {
            HStack {
                Image(playlist.img)
                    .resizable()
                    .frame(width: 100, height: 100)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(playlist.name)
                        .foregroundStyle(.white)
                        .font(.system(size: 18, weight: .semibold))
                    
                    Text(playlist.creator)
                        .foregroundStyle(.gray)
                        .font(.system(size: 14, weight: .semibold))
                }
                
                Spacer()
            }
        }
    }
    
    func buildArtistsView() -> some View {
        VStack {
            ForEach(viewModel.allAlbums, id: \.self) { artist in
                artistCell(album: artist)
            }
        }
    }
    
    func artistCell(album: Album) -> some View {
        Button {
            
        } label: {
            HStack {
                Image(album.artistimg)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(album.album)
                        .foregroundStyle(.white)
                        .font(.system(size: 18, weight: .semibold))
                    
                    Text(album.artist)
                        .foregroundStyle(.gray)
                        .font(.system(size: 14, weight: .semibold))
                }
                
                Spacer()
            }
        }
    }

    func buildAlbumsView() -> some View {
        VStack {
            ForEach(viewModel.allAlbums, id: \.self) { album in
                albumCell(album: album)
            }
        }
    }
    
    func albumCell(album: Album) -> some View {
        Button {
            
        } label: {
            HStack {
                Image(album.img)
                    .resizable()
                    .frame(width: 100, height: 100)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(album.album)
                        .foregroundStyle(.white)
                        .font(.system(size: 18, weight: .semibold))
                    
                    Text(album.artist)
                        .foregroundStyle(.gray)
                        .font(.system(size: 14, weight: .semibold))
                }
                
                Spacer()
            }
        }
    }

}

#Preview {
    LibraryView(musicViewModel: MusicViewModel(album: albums.first!), viewModel: LibraryViewModel())
}
