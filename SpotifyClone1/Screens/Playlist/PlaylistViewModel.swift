//
//  PlaylistViewModel.swift
//  SpotifyClone1
//
//  Created by Paulo Lazarini on 16/07/23.
//

import SwiftUI
import Combine

class PlaylistViewModel: ObservableObject {
    @Published var isFavorite = false
    
    let onDismiss = PassthroughSubject<Void, Never>()
    
    var cancelSet = Set<AnyCancellable>()
    
    init() { }
    
}
