//
//  LogInPageView.swift
//  SpotifyClone1
//
//  Created by Paulo Lazarini on 14/07/23.
//

import SwiftUI
import Combine

struct LogInPageView: View {
    
    @ObservedObject var viewModel: LogInPageViewModel
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea(.all)
            
            VStack(alignment: .center, spacing: 16) {
                Image("spotifyLogo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .padding(.bottom, 50)
                
                subtitle
                    .padding(.bottom, 50)
                
                loginOptionButtons(buttons: viewModel.loginButtons)
                
                logInButton
            }
            .padding(.horizontal, 16)
        }
    }
    
    var subtitle: some View {
        VStack {
            Text("Millions of Songs")
            Text("Free on Spotify.")
        }
        .font(.system(size: 32))
        .foregroundColor(.white)
        .bold()
    }
    
    func loginOptionButtons(buttons: [LoginButtons]) -> some View {
        VStack(spacing: 6) {
            ForEach(buttons, id: \.self) { button in
                button == buttons.first ? loginOptionButton(button: button, isFirstButton: true) : loginOptionButton(button: button)
            }
        }
    }
    
    func loginOptionButton(button: LoginButtons, isFirstButton: Bool = false) -> some View {
        Button {
           print("test")
        } label: {
            ZStack {
                buttonShape(isFirstButton: isFirstButton)
                
                ZStack {
                    HStack(alignment: .center) {
                        if button.image == "iphone" {
                            Image(systemName: button.image ?? "")
                                .resizable()
                                .frame(width: 20, height: 32)
                                .foregroundColor(.white)
                        } else {
                            Image(button.image ?? "")
                                .resizable()
                                .frame(width: 32, height: 32)
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    
                    HStack {
                        Text(button.name)
                            .foregroundColor(isFirstButton ? .black : .white)
                            .font(.title3)
                            .padding(.horizontal, 20)
                            .bold()
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func buttonShape(isFirstButton: Bool) -> some View {
        if isFirstButton {
            RoundedRectangle(cornerRadius: 20)
                .frame(height: 54)
                .foregroundColor(.green)
        } else {
            RoundedRectangle(cornerRadius: 20)
                .stroke()
                .frame(height: 54)
                .foregroundColor(.white)
        }
    }

    var logInButton: some View {
        Button {
            viewModel.onLoggedIn.send()
        } label: {
            Text("Log in")
                .font(.title3)
                .foregroundColor(.white)
                .bold()
        }
    }
}

struct LoginButtons: Hashable {
    let name: String
    let image: String?
}

struct LogInPageView_Previews: PreviewProvider {
    static var previews: some View {
        LogInPageView(viewModel: LogInPageViewModel(coordinator: Coordinator(navigationController: UINavigationController())))
    }
}
