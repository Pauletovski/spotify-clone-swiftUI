//
//  Color+extensions.swift
//  SpotifyClone1
//
//  Created by Paulo Lazarini on 14/07/23.
//

import SwiftUI

public extension Color {
    static func random(randomOpacity: Bool = false) -> Color {
        Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            opacity: randomOpacity ? .random(in: 0...1) : 1
        )
    }
}

