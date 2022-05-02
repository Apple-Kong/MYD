//
//  VideoView.swift
//  MYD
//
//  Created by GOngTAE on 2022/05/02.
//

import SwiftUI
import AVKit
import UIKit


/*
 1. AVPlayer 세팅 [✅]
 2. AVPlayerLayer -> UIView [✅]
 3. SwiftUI 에 UIView 표시하기 [✅]
 4. UIKit <-> SwiftUI 서로 데이터 신호 주고 받는 거 공부하기 [ ]
 https://developer.apple.com/tutorials/swiftui/interfacing-with-uikit
 5.


 
 */
struct VideoView: View {
    var body: some View {
        VideoPlayerView()
            .ignoresSafeArea()
    }
}

/// A view that displays the visual contents of a player object.
class PlayerView: UIView {

    // Override the property to make AVPlayerLayer the view's backing layer.
    override static var layerClass: AnyClass { AVPlayerLayer.self }
    
    // The associated player object.
    var player: AVPlayer? {
        get { playerLayer.player }
        set { playerLayer.player = newValue }
    }
    
    private var playerLayer: AVPlayerLayer { layer as! AVPlayerLayer }
}




struct VideoPlayerView: UIViewRepresentable {

    func makeUIView(context: Context) -> UIView {
        let playerView = PlayerView()
        
        
        //그전에 비디오 경로를 찾아 두어야함 아래 링크 참고
        //https://stackoverflow.com/questions/25348877/how-to-play-a-local-video-with-swift
        //
        
        //파일 경로 탐색
        guard let path = Bundle.main.path(forResource: "video", ofType:"m4v") else {
                    debugPrint("video.m4v not found")
                    return UIView()
            }
        
        //로컬 url
        let url = URL(fileURLWithPath: path)
        //플레이어 객체 생성
        let player = AVPlayer(url: url)
        playerView.player = player
        
        return playerView
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}


struct VideoView_Previews: PreviewProvider {
    static var previews: some View {
        VideoView()
    }
}
