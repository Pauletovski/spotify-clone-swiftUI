//
//  PlaylistViewModel.swift
//  SpotifyClone1
//
//  Created by Paulo Lazarini on 16/07/23.
//

import SwiftUI
import Combine

class PlaylistViewModel: ObservableObject {
    enum Event {
        case onDismiss
        case presentMusicDetails(Album)
        case selectSong(Album)
    }
    
    @Published var isFavorite = false
    @Published var album: Album?
    
    let onEvent = PassthroughSubject<Event, Never>()
    
    var cancelSet = Set<AnyCancellable>()
    
    init() {
        self.onEvent
            .sink { [weak self] event in
                switch event {
                case .presentMusicDetails(let album):
                    self?.album = album
                case .selectSong(let album):
                    self?.album = album
                default:
                    return
                }
            }.store(in: &cancelSet)
    }
    
}
