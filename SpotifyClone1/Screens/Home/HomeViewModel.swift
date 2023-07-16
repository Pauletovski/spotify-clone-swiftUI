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
    
    var cancelSet = Set<AnyCancellable>()
    
    init() { }
    
}
