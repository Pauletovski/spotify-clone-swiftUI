//
//  HomeViewModel.swift
//  SpotifyClone1
//
//  Created by Paulo Lazarini on 16/07/23.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    let onPresentPlaylist = PassthroughSubject<Playlist, Never>()
    let onEvent = PassthroughSubject<PlaylistViewModel.Event, Never>()
    
    var cancelSet = Set<AnyCancellable>()
    
    @Published var album: Album?
    @Published var playlist: [Playlist]
    
    init(playlist: [Playlist]) {
        self.playlist = playlist
    }
    
}
