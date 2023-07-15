//
//  SearchViewModel.swift
//  SpotifyClone1
//
//  Created by Paulo Lazarini on 21/07/23.
//

import SwiftUI
import Combine

class SearchViewModel: ObservableObject {
    @Published var album: Album?
    
    let onEvent = PassthroughSubject<PlaylistViewModel.Event, Never>()
    
    var cancelSet = Set<AnyCancellable>()
    
    init() { }
    
}
