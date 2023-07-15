//
//  SearchView.swift
//  SpotifyClone1
//
//  Created by Paulo Lazarini on 14/07/23.
//

import SwiftUI

struct SearchScreenView: View {
    @State var topGenres: [String] = [
        "Pop",
        "Bollywood"
    ]
    @State var browseAllGenres: [String] = [
        "Podcasts",
        "New Releases",
        "Chars",
        "Concerts",
        "Made for You",
        "At Home"
    ]
    
    @State var text = ""
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(alignment: .leading) {
                navigationTitle
                
                
                SearchTextfield(text: $text, placeholder: "Artist, songs, or podcasts")
                    .padding(.bottom)
                
                ScrollView {
                    VStack(alignment: .leading) {
                        subtitle("Your top genres")
                        
                        genresView(genres: topGenres)
                        
                        subtitle("Browse all")
                        
                        genresView(genres: browseAllGenres)
                    }
                }
            }
            .padding(.all, 14)
        }
    }
    
    func genresView(genres: [String]) -> some View {
        LazyVGrid(columns: columns) {
            ForEach(genres, id: \.self) { genre in
                genreCard(genre: genre)
            }
        }
    }
    
    func genreCard(genre: String) -> some View {
        Button {
            
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .frame(height: 116)
                    .foregroundColor(Color.random())
                
                VStack {
                    HStack {
                        Text(genre)
                            .foregroundColor(.white)
                            .font(.system(size: 18))
                            .bold()
                        
                        Spacer()
                    }
                    
                    Spacer()
                }
                .padding(10)
            }
        }
    }
    
    var navigationTitle: some View {
        HStack {
            Text("Search")
                .font(.system(size: 42))
                .foregroundColor(.white)
                .bold()
            
            Spacer()
        }
    }
    
    func subtitle(_ text: String) -> some View {
        Text(text)
            .bold()
            .font(.system(size: 28))
            .foregroundColor(.white)
    }
    
}

struct SearchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SearchScreenView()
    }
}
