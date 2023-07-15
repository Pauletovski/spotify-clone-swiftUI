//
//  SpotifyCloneApp.swift
//  SpotifyClone1
//
//  Created by Paulo Lazarini on 14/07/23.
//
//
//import SwiftUI
//
//@main
//struct SpotifyCloneApp: App {
//    
//    @ObservedObject var loginViewModel = LogInPageViewModel()
//    
//    var body: some Scene {
//        WindowGroup {
//            if !loginViewModel.isLoggedIn {
//                LogInPageView(viewModel: loginViewModel)
//            } else {
//                TabView {
//                    Group {
//                        HomeScreenView()
//                            .tabItem {
//                                Image(systemName: "house")
//                                Text("Home")
//                            }
//                            .toolbarBackground(Color.gray, for: .tabBar)
//                        
//                        SearchScreenView()
//                            .tabItem {
//                                Image(systemName: "magnifyingglass")
//                                Text("Search")
//                            }
//                            .toolbarBackground(Color.gray, for: .tabBar)
//                        
//                        PlaylistView()
//                            .tabItem {
//                                Image(systemName: "books.vertical")
//                                Text("Your Library")
//                            }
//                    }
//                    .toolbarBackground(Color.black, for: .tabBar)
//                }
//            }
//        }
//    }
//}
