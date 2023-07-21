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
    }
    
    @Published var isFavorite = false
    
    let onEvent = PassthroughSubject<Event, Never>()
    
    var cancelSet = Set<AnyCancellable>()
    
    init() { }
    
}
