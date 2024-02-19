////
////  VideoPlayerView.swift
////  Distral
////
////  Created by Philipp Korn on 19.02.24.
////
//
//import Foundation
//import SwiftUI
//import AVKit
//import AVFoundation
//
//struct VideoPlayerView: UIViewRepresentable {
//    var videoName: String
//
//    func makeUIView(context: Context) -> UIView {
//        let uiView = UIView(frame: .zero)
//
//        // Pfad des Videos
//        guard let path = Bundle.main.path(forResource: videoName, ofType: "mp4") else {
//            debugPrint("\(videoName).mp4 not found")
//            return uiView
//        }
//        let player = AVPlayer(url: URL(fileURLWithPath: path))
//        let playerLayer = AVPlayerLayer(player: player)
//        playerLayer.videoGravity = .resizeAspect
//        playerLayer.frame = uiView.bounds
//        uiView.layer.addSublayer(playerLayer)
//        player.play()
//        context.coordinator.playerLayer = playerLayer
//
//        return uiView
//    }
//
//    func updateUIView(_ uiView: UIView, context: Context) {
//        context.coordinator.playerLayer?.frame = uiView.bounds
//    }
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    class Coordinator: NSObject {
//        var parent: VideoPlayerView
//        var playerLayer: AVPlayerLayer?
//
//        init(_ parent: VideoPlayerView) {
//            self.parent = parent
//        }
//    }
//}
//
//
//
//
