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
    }
    
    let tabBarController = UITabBarController()
    
    private var cancelSet = Set<AnyCancellable>()
    
    let homeViewModel = HomeViewModel()
    
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
                                                                              album: albums,
                                                                              playlist: playlists))
        
        let searchViewController = UIHostingController(rootView: SearchScreenView())
        
        let yourLibraryViewController = UIHostingController(rootView: EmptyView())
        
        homeViewController.tabBarItem = firstTabBarItem
        searchViewController.tabBarItem = secondTabBarItem
        yourLibraryViewController.tabBarItem = thirdTabBarItem

        UITabBar.appearance().barTintColor = UIColor.black
        tabBarController.tabBar.isTranslucent = false
        tabBarController.viewControllers = [homeViewController, searchViewController, yourLibraryViewController]
        navigationController.setViewControllers([tabBarController], animated: false)
    }
    
    func presentPlaylist(playlist: Playlist) {
        let viewModel = PlaylistViewModel()
        presentVC(PlaylistView(playlist: playlist, viewModel: viewModel))
        
        viewModel.onDismiss
            .sink { [weak self] _ in
                
                self?.dismiss()
            }.store(in: &cancelSet)
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
