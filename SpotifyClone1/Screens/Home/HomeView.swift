//
//  HomeView.swift
//  SpotifyClone1
//
//  Created by Paulo Lazarini on 14/07/23.
//

import SwiftUI

struct PlaylistInfo: Hashable {
    let image: String
    let description: String
}


struct SongInfo: Hashable {
    let songName: String
    let singerName: String
    let image: String
}
struct HomeScreenView: View {
    
    @State var songsInfo: [SongInfo] = [
        SongInfo(songName: "Believer", singerName: "Imagine Dragons", image: ""),
        SongInfo(songName: "zap", singerName: "zap", image: ""),
        SongInfo(songName: "zap", singerName: "zap", image: ""),
        SongInfo(songName: "zap", singerName: "zap", image: "")
    ]
    
    @State var playlistInfo: [PlaylistInfo] = [
        PlaylistInfo(image: "", description: "AWDWADAWODKADKOAWDAWDKawodkwdoqw"),
        PlaylistInfo(image: "", description: "AWDWADAWODKADKOAWDAWDKawodkwdoqw")
    ]

    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                header
                
                ScrollView(.vertical, showsIndicators: true) {
                    VStack(spacing: 45) {
                        playlistRecomendations(playlistsInfo: playlistInfo)
                            
                        trendingNowView(songsInfo: songsInfo)
                            
                        topPicksView(playlistsInfo: playlistInfo)
                    }
                    .padding(.bottom, 45)
                }
            }
            .padding(.horizontal, 10)
        }
    }
    
    func subtitle(_ text: String) -> some View {
        Text(text)
            .bold()
            .font(.system(size: 28))
            .foregroundColor(.white)
    }
    
    func topPicksView(playlistsInfo: [PlaylistInfo]) -> some View {
        VStack(alignment: .leading, spacing: 20) {
            subtitle("Top picks for you")
              
            
            HStack {
                ForEach(playlistsInfo, id: \.self) { info in
                    playlistRecomendations(playlistInfo: info)
                }
            }
        }
    }
    
    func playlistRecomendations(playlistsInfo: [PlaylistInfo]) -> some View {
        HStack {
            ForEach(playlistsInfo, id: \.self) { info in
                playlistRecomendations(playlistInfo: info)
            }
        }
    }
    
    func playlistRecomendations(playlistInfo: PlaylistInfo) -> some View {
        VStack(alignment: .leading) {
            Rectangle()
                .frame(width: 175, height: 175)
                .foregroundColor(.white)
            
            Text(playlistInfo.description)
                .foregroundColor(.gray)
                .font(.system(size: 14))
                .bold()
        }
    }
    
    func trendingNowView(songsInfo: [SongInfo]) -> some View {
        VStack(alignment: .leading) {
            subtitle("Trending now")
            
            ScrollView(.horizontal) {
                HStack(spacing: 16) {
                    ForEach(songsInfo, id: \.self) { song in
                        trendingNowCell(songInfo: song)
                    }
                }
            }
        }
    }
    
    func trendingNowCell(songInfo: SongInfo) -> some View {
        VStack(alignment: .leading) {
            Rectangle()
                .frame(width: 175, height: 175)
                .foregroundColor(.white)
            
            Text(songInfo.songName)
                .foregroundColor(.gray)
                .font(.system(size: 18))
                .bold()
            
            Text("Song . \(songInfo.singerName)")
                .foregroundColor(.gray)
                .font(.system(size: 14))
                .bold()
        }
    }
    
    var header: some View {
        HStack {
            subtitle("Made for you")
            
            Spacer()
            
            headerButtons
        }
        .foregroundColor(.white)
    }
    
    var headerButtons: some View {
        HStack(spacing: 28) {
            Button {
                
            } label: {
                Image(systemName: "bell")
                    .resizable()
                    .frame(width: 20, height: 20)
            }
            
            Button {
                
            } label: {
                Image(systemName: "clock.arrow.circlepath")
                    .resizable()
                    .frame(width: 20, height: 20)
            }
            
            Button {
                
            } label: {
                Image(systemName: "gearshape")
                    .resizable()
                    .frame(width: 20, height: 20)
            }
        }
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}
