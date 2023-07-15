//
//  Coordinator.swift
//  SpotifyClone1
//
//  Created by Paulo Lazarini on 15/07/23.
//

import UIKit
import SwiftUI
import Combine

class Coordinator {

    var navigationController: UINavigationController
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
        self.homeViewModel.onPresentPlaylist
            .sink { [weak self] playlist in
                
                self?.presentPlaylist(playlist: playlist)
            }.store(in: &cancelSet)
        
        self.homeViewModel.onEvent
            .sink { [weak self] event in
                switch event {
                case .presentMusicDetails:
                    self?.presentMusic()
                default:
                    return
                }
            }.store(in: &cancelSet)
        
        self.searchViewModel.onEvent
            .sink { [weak self] event in
                switch event {
                case .presentMusicDetails:
                    self?.presentMusic()
                default:
                    return
                }
            }.store(in: &cancelSet)
    }
    
    var album: Album?
    
    let tabBarController = UITabBarController()
    
    private var cancelSet = Set<AnyCancellable>()
    
    var homeViewModel = HomeViewModel(playlist: playlists)
    var playlistViewModel = PlaylistViewModel()
    var searchViewModel = SearchViewModel()
    var musicViewModel = MusicViewModel(album: albums.first!)
    
    func start() {
        let viewModel = LogInPageViewModel()
        let view = LogInPageView(viewModel: viewModel)
        
        viewModel.onLoggedIn
            .sink { [weak self] _ in
                guard let self else { return }
                
                self.showTabBar()
            }.store(in: &cancelSet)
        
        pushVC(view)
    }
    
    func showTabBar() {
        let firstTabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        let secondTabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        let thirdTabBarItem = UITabBarItem(title: "Your Library", image: UIImage(systemName: "books.vertical"), tag: 2)
        
        let homeViewController = UIHostingController(rootView: HomeScreenView(viewModel: homeViewModel,
                                                                              musicViewModel: musicViewModel))
        
        if let album = homeViewModel.album {
            playlistViewModel.album = album
        }
        
        let searchViewController = UIHostingController(rootView: SearchScreenView(musicViewModel: musicViewModel,
                                                                                  viewModel: searchViewModel))
        
        let yourLibraryViewController = UIHostingController(rootView: EmptyView())
        
        homeViewController.tabBarItem = firstTabBarItem
        searchViewController.tabBarItem = secondTabBarItem
        yourLibraryViewController.tabBarItem = thirdTabBarItem

        UITabBar.appearance().barTintColor = UIColor.boxgray
        tabBarController.tabBar.backgroundColor = UIColor.boxgray
        tabBarController.tabBar.isTranslucent = false
        tabBarController.tabBar.tintColor = .white
        tabBarController.viewControllers = [homeViewController, searchViewController, yourLibraryViewController]
        navigationController.setViewControllers([tabBarController], animated: false)
    }
    
    func presentPlaylist(playlist: Playlist) {
        navigationController.navigationBar.isHidden = true
        pushVC(PlaylistView(playlist: playlist, viewModel: playlistViewModel, musicViewModel: musicViewModel))
        
        playlistViewModel.onEvent
            .sink { [weak self] event in
                switch event {
                case .onDismiss:
                    self?.popVC()
                case .presentMusicDetails(_):
                    self?.presentMusic()
                case .selectSong(let album):
                    self?.musicViewModel.album = album
                    self?.homeViewModel.album = album
                    self?.searchViewModel.album = album
                    self?.album = album
                }
            }.store(in: &cancelSet)
        
        musicViewModel.onEvent
            .sink { [weak self] event in
                switch event {
                case .nextSong:
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                        self?.playlistViewModel.album = self?.musicViewModel.album
                        self?.homeViewModel.album = self?.musicViewModel.album
                        self?.searchViewModel.album = self?.musicViewModel.album
                        self?.album = self?.musicViewModel.album
                    }
                case .previousSong:
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                        self?.playlistViewModel.album = self?.musicViewModel.album
                        self?.homeViewModel.album = self?.musicViewModel.album
                        self?.searchViewModel.album = self?.musicViewModel.album
                        self?.album = self?.musicViewModel.album
                    }
                default:
                    return
                }
            }.store(in: &cancelSet)
    }
    
    func presentMusic() {
        let view = MusicView(viewModel: musicViewModel)
        
        musicViewModel.onEvent
            .sink { [weak self] event in
                switch event {
                case .onDismiss:
                    self?.dismiss()
                default:
                    return
                }
            }.store(in: &cancelSet)
        
        presentVC(view)
    }
}

extension Coordinator {
    private func pushVC(_ view: some View) {
        let vc = UIHostingController(rootView: view)
        navigationController.pushViewController(vc, animated: true)
    }
    
    private func presentVC(_ view: some View) {
        let vc = UIHostingController(rootView: view)
        navigationController.present(vc, animated: true)
    }
    
    private func dismiss() {
        navigationController.dismiss(animated: true)
    }
    
    private func popVC() {
        navigationController.popViewController(animated: true)
    }
}
