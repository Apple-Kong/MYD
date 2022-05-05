//
//  CustomVideoPlayer.swift
//  MYD
//
//  Created by GOngTAE on 2022/05/05.
//

import Foundation
import SwiftUI
import AVKit
import Combine

final class PlayerViewModel: ObservableObject {
    let player = AVPlayer()
//    @Published var isInPipMode: Bool = false
    @Published var isPlaying = false
    
    @Published var isEditingCurrentTime = false
    @Published var currentTime: Double = .zero
    @Published var duration: Double?
    
    private var subscriptions: Set<AnyCancellable> = []
    private var timeObserver: Any?
    
    deinit {
        if let timeObserver = timeObserver {
            player.removeTimeObserver(timeObserver)
        }
    }
    
    init() {
        //파일 경로 탐색
        
        $isEditingCurrentTime
            .dropFirst()
            .filter({ $0 == false })
            .sink(receiveValue: { [weak self] _ in
                guard let self = self else { return }
                self.player.seek(to: CMTime(seconds: self.currentTime, preferredTimescale: 1), toleranceBefore: .zero, toleranceAfter: .zero)
                if self.player.rate != 0 {
                    self.player.play()
                }
            })
            .store(in: &subscriptions)
        
        //NSObject 를 사용한 publisher init -> 해당 Key 값에 해당하는 변수를 관찰하는 퍼블리셔 생성
        player.publisher(for: \.timeControlStatus) //
            .sink { [weak self] status in
                switch status {
                case .playing:
                    self?.isPlaying = true
                case .paused:
                    self?.isPlaying = false
                case .waitingToPlayAtSpecifiedRate:
                    break
                @unknown default:
                    break
                }
            }
            .store(in: &subscriptions)
        
        timeObserver = player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 0.2, preferredTimescale: 600), queue: .main) { [weak self] time in
            guard let self = self else { return }
            if self.isEditingCurrentTime == false {
                self.currentTime = time.seconds
            }
        }
    }
    
    func setCurrentItem(_ item: AVPlayerItem) {
        currentTime = .zero
        duration = nil
        player.replaceCurrentItem(with: item)
        
        item.publisher(for: \.status)
            .filter({ $0 == .readyToPlay })
            .sink(receiveValue: { [weak self] _ in
                self?.duration = item.asset.duration.seconds
            })
            .store(in: &subscriptions)
    }
}

class PlayerView: UIView {

    // Override the property to make AVPlayerLayer the view's backing layer.
    override static var layerClass: AnyClass { AVPlayerLayer.self }

    // The associated player object.
    var player: AVPlayer? {
        get { playerLayer.player }
        set { playerLayer.player = newValue }
    }

   var playerLayer: AVPlayerLayer { layer as! AVPlayerLayer }
}


struct CustomVideoPlayer: UIViewRepresentable {
    @ObservedObject var playerVM: PlayerViewModel

    func makeUIView(context: Context) -> PlayerView {
        let view = PlayerView()
        view.player = playerVM.player
        return view
    }
    
    func updateUIView(_ uiView: PlayerView, context: Context) { }
}

struct CustomControlsView: View {
    @ObservedObject var playerVM: PlayerViewModel
    
    var body: some View {
        HStack {
            if playerVM.isPlaying == false {
                Button(action: {
                    playerVM.player.play()
                }, label: {
                    Image(systemName: "play.circle")
                        .imageScale(.large)
                })
            } else {
                Button(action: {
                    playerVM.player.pause()
                }, label: {
                    Image(systemName: "pause.circle")
                        .imageScale(.large)
                })
            }
            
            if let duration = playerVM.duration {
                Slider(value: $playerVM.currentTime, in: 0...duration, onEditingChanged: { isEditing in
                    playerVM.isEditingCurrentTime = isEditing
                })
            } else {
                Spacer()
            }
        }
        .padding()
        .background(.white.opacity(0.9))
        .cornerRadius(10)
    }
}

