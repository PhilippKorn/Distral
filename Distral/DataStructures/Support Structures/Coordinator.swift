//
//  Coordinator.swift
//  Distral
//
//  Created by Philipp Korn on 19.02.24.
//

import Foundation
import AVKit
import AVFoundation

class Coordinator: NSObject {
    var parent: VideoPlayerView
    var playerLayer: AVPlayerLayer?
    var player: AVPlayer?

    init(_ parent: VideoPlayerView) {
        self.parent = parent
        super.init()
        loadVideo()
    }

    func loadVideo() {
        guard let path = Bundle.main.path(forResource: parent.videoName, ofType: "mp4"),
              !path.isEmpty else {
            debugPrint("\(parent.videoName).mp4 not found")
            return
        }

        player = AVPlayer(url: URL(fileURLWithPath: path))
        playerLayer = AVPlayerLayer(player: player)
        player?.play()
    }
}

func updateUIView(_ uiView: UIView, context: Context) {
    if let playerLayer = context.coordinator.playerLayer {
        playerLayer.removeFromSuperlayer()
    }

    context.coordinator.loadVideo()

    if let playerLayer = context.coordinator.playerLayer {
        playerLayer.frame = uiView.bounds
        playerLayer.videoGravity = .resizeAspect
        uiView.layer.addSublayer(playerLayer)
    }
}
