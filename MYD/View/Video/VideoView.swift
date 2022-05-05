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
 4. UIKit <-> SwiftUI 서로 데이터 신호 주고 받는 거 공부하기 [✅]
 https://developer.apple.com/tutorials/swiftui/interfacing-with-uikit
 5. Combine 을 이용한 비디오 신호 비동기 커뮤니케이션 [✅]
 https://www.createwithswift.com/custom-video-player-with-avkit-and-swiftui-supporting-picture-in-picture/
 */

struct VideoView: View {
    @StateObject private var viewModel = PlayerViewModel()
    
    var body: some View {
        ZStack {
            
            
            CustomVideoPlayer(playerVM: viewModel)
                .scaledToFill()
                .ignoresSafeArea()
                .onAppear {
                    guard let path = Bundle.main.path(forResource: "popping_1", ofType:"mp4") else {
                                debugPrint("popping_0.mp4 not found")
                                return
                        }
                    //로컬 url
                    let url = URL(fileURLWithPath: path)
                    
                    viewModel.setCurrentItem(AVPlayerItem(url: url))
                    viewModel.player.play()
                    
                }
                .onDisappear {
                    viewModel.player.pause()
                }
//
//            CustomControlsView(playerVM: viewModel)
//                .frame(width: 300, height: 100)
            
            VStack {
                
                Spacer()
                NavigationLink {
                    ResultView()
                } label: {
                    Text("다음")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                .buttonStyle(PreferenceButtonStyle())
                .frame(width: 360)
                
            }
            .padding()
            
            
        }
        .navigationBarHidden(true)
        
        
    }
}

struct VideoView_Previews: PreviewProvider {
    static var previews: some View {
        VideoView()
    }
}
