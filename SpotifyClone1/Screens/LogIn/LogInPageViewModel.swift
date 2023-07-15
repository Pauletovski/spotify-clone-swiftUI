//
//  LogInPageViewModel.swift
//  SpotifyClone1
//
//  Created by Paulo Lazarini on 14/07/23.
//

import Foundation

class LogInPageViewModel: ObservableObject {
    @Published var loginButtons: [LoginButtons] = [
        LoginButtons(name: "Sign up free", image: nil),
        LoginButtons(name: "Continue with phone number", image: "iphone"),
        LoginButtons(name: "Continue with Google", image: "googleLogo"),
        LoginButtons(name: "Continue with Facebook", image: "facebookLogo")
    ]
    
    @Published var isLoggedIn: Bool = false
}
