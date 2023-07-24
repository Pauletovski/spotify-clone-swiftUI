//
//  LibraryViewModel.swift
//  SpotifyClone1
//
//  Created by Paulo Lazarini on 24/07/23.
//

import SwiftUI
import Combine

class LibraryViewModel: ObservableObject {
    enum Event {
        case playlist
        case artists
        case albums
        case episodes
        case downloads
        case shows
        case presentPlaylist(Playlist)
    }
    
    let onEvent = PassthroughSubject<Event, Never>()
    let onMusicEvent = PassthroughSubject<PlaylistViewModel.Event, Never>()
    
    var cancelSet = Set<AnyCancellable>()
    
    @Published var isMusicSelected = true
    @Published var isPodcastsSelected = false
    
    @Published var selectedIndex = 1
    
    @Published var playlist = playlists
    @Published var allAlbums = albums
    
    @Published var album: Album?
    
    
    @Published var musicSubButtons = [
        SubButtons(name: "Playlists", type: .playlist,  id: 1),
        SubButtons(name: "Artists", type: .artists,  id: 2),
        SubButtons(name: "Albums", type: .albums,  id: 3)
        
    ]
    
    @Published var podcastSubButtons = [
        SubButtons(name: "Episodes", type: .episodes, id: 1),
        SubButtons(name: "Downloads", type: .downloads,  id: 2),
        SubButtons(name: "Shows",  type: .shows,  id: 3)
    ]
    
    
    
    init() {
        setupBindings()
    }
    
    private func setupBindings() {
        onEvent
            .sink { [weak self] event in
//                guard let self else { return }
                
                switch event {
                    
                default:
                    return
                }
            }.store(in: &cancelSet)
    }
}

struct SubButtons: Identifiable {
    let name: String
    let type: LibraryViewModel.Event
    let id: Int
    
    init(name: String,
         type: LibraryViewModel.Event,
         id: Int) {
        self.name = name
        self.type = type
        self.id = id
    }
}
