//
//  TutorialDetailView.swift
//  Distral
//
//  Created by Philipp Korn on 19.02.24.
//

import SwiftUI
import AVKit

struct TutorialDetailView: View {
    var videoName: String
    var title: String
    var text: String
    
    @State private var player : AVPlayer?
    
    var body: some View {
        VStack(alignment: .leading) {
            
            VideoPlayer(player: player)
                .frame(height: 300)
            Text(title)
                .font(.headline)
            Text(text)
                .font(.subheadline)
        }
        .padding()
        .onAppear {
            if !videoName.isEmpty, let path = Bundle.main.path(forResource: videoName, ofType: "mp4") {
                let url = URL(fileURLWithPath: path)
                player = AVPlayer(url: url)
                player?.play()
            }
        }
        .onDisappear {
            player?.pause()
            player = nil
        }
        .onChange(of: videoName) { newVideoName in
            if !newVideoName.isEmpty, let path = Bundle.main.path(forResource: newVideoName, ofType: "mp4") {
                let url = URL(fileURLWithPath: path)
                player = AVPlayer(url: url)
                player?.play()
            } else {
                player?.pause()
                player = nil
            }
        }
    }
}

#Preview {
    TutorialDetailView(videoName: "", title: "TutorialText", text: "Beschreibungstext")
}
