//
//  Coordinator.swift
//  SpotifyClone1
//
//  Created by Paulo Lazarini on 15/07/23.
//

import UIKit
import SwiftUI
import Combine
//import Moya

class Coordinator {

    var navigationController: UINavigationController
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    let tabBarController = UITabBarController()
    
    var cancelSet = Set<AnyCancellable>()
    
    
    lazy var logInPageViewModel: LogInPageViewModel = LogInPageViewModel()
    
    func start() {
        let view = LogInPageView(viewModel: logInPageViewModel)
        
        pushVC(view)
        
        sleep(2)
        
        
        showTabBar()
    }
    
    func showTabBar() {
        let firstTabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        let secondTabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        let thirdTabBarItem = UITabBarItem(title: "Your Library", image: UIImage(systemName: "books.vertical"), tag: 2)
        let homeViewController = UIHostingController(rootView: HomeScreenView())
        let searchViewController = UIHostingController(rootView: SearchScreenView())
        let yourLibraryViewController = UIHostingController(rootView: EmptyView())
        homeViewController.tabBarItem = firstTabBarItem
        searchViewController.tabBarItem = secondTabBarItem
        yourLibraryViewController.tabBarItem = thirdTabBarItem

        tabBarController.tabBar.backgroundColor = .black
        tabBarController.viewControllers = [homeViewController, searchViewController, yourLibraryViewController]
        navigationController.setViewControllers([tabBarController], animated: false)
    }
}

extension Coordinator {
    private func pushVC(_ view: some View) {
        let vc = UIHostingController(rootView: view)
        navigationController.pushViewController(vc, animated: true)
    }
}
