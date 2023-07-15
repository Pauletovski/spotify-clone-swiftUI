//
//  LogInPageViewModel.swift
//  SpotifyClone1
//
//  Created by Paulo Lazarini on 14/07/23.
//

import SwiftUI
import Combine

class LogInPageViewModel: ObservableObject {
    @Published var loginButtons: [LoginButtons] = [
        LoginButtons(name: "Sign up free", image: nil),
        LoginButtons(name: "Continue with phone number", image: "iphone"),
        LoginButtons(name: "Continue with Google", image: "googleLogo"),
        LoginButtons(name: "Continue with Facebook", image: "facebookLogo")
    ]
    
    let onLoggedIn = PassthroughSubject<Void, Never>()
    
    var cancelSet = Set<AnyCancellable>()
    
    init() { }
    
}
