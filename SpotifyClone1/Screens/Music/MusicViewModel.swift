//
//  MusicViewModel.swift
//  SpotifyClone1
//
//  Created by Paulo Lazarini on 20/07/23.
//

import SwiftUI
import Combine

class MusicViewModel: ObservableObject {
    enum Event {
        case onDismiss
        case nextSong
        case previousSong
    }
    
    @Published var isFavorite = false
    @Published var shouldShuffle = false
    @Published var shouldRepeat = false
    @Published var shouldPlay = true
    @Published var album: Album
    @Published var index = 0
    @Published var musicFullSeconds = Int.random(in: 120...318)
    @Published var progressWidth: CGFloat = 0
    @Published var currentMinute = 0 {
        didSet {
            if currentMinute == musicFullSeconds {
                shouldRepeat ? resetProgressBar() : onEvent.send(.nextSong)
            }
        }
    }
        
    let onEvent = PassthroughSubject<Event, Never>()
    
    var cancelSet = Set<AnyCancellable>()
    
    init(album: Album) {
        self.album = album
        
        index = getAlbumIndex(album: album)
        self.album = albums[index]
        
        self.onEvent
            .sink { [weak self] event in
            guard let self else { return }
                
            switch event {
            case .nextSong:
                resetProgressBar()
                musicFullSeconds = Int.random(in: 120...318)
                if shouldShuffle {
                    shouldGetRandomAlbum()
                    return
                }
                if self.index < albums.count - 1 {
                    self.index += 1
                    self.album = albums[self.index]
                } else {
                    self.index = 0
                    self.album = albums[self.index]
                }
            case .previousSong:
                resetProgressBar()
                musicFullSeconds = Int.random(in: 120...318)
                if shouldShuffle {
                    shouldGetRandomAlbum()
                    return
                }
                
                if self.index != 0 {
                    self.index -= 1
                    self.album = albums[self.index]
                }
            default:
                return
            }
        }.store(in: &cancelSet)
    }
    
    func getAlbumIndex(album: Album) -> Int {
        return albums.firstIndex(where: { $0.album == album.album }) ?? 0
    }
    
    func shouldGetRandomAlbum() {
        album = albums[Int.random(in: 0..<albums.count)]
    }
    
    func resetProgressBar() {
        currentMinute = 0
        progressWidth = 0
    }
    
}
