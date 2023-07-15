//
//  SearchTextfield.swift
//  SpotifyClone1
//
//  Created by Paulo Lazarini on 14/07/23.
//

import SwiftUI

struct SearchTextfield: View {
    @Binding var text: String
    var placeholder: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .frame(height: 63)
                .foregroundColor(.white)
            
            HStack {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .frame(width: 36, height: 36)
                    .foregroundColor(.black)
                    .padding(.horizontal, 20)
                
                TextField(placeholder, text: $text)
            }
        }
    }
}
