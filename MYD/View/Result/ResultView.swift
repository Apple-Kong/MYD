//
//  ResultView.swift
//  MYD
//
//  Created by GOngTAE on 2022/05/03.
//

import SwiftUI

struct ResultView: View {
    @Environment(\.openURL) var openURL
    @StateObject var viewModel = ResultViewModel()
    
    let hInset: CGFloat = 20 // 좌우 여백
    
    var body: some View {
        
        
        VStack(alignment: .leading) {
            
            Text("Be like...")
                .foregroundColor(.white)
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.leading, hInset)

            HStack {
                Spacer()
                
                Text("Hiphop Dancer")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .fontWeight(.bold)

            }
            .padding(.trailing, hInset)
            
       
           
            
            Image("hiphop_dance")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            VStack(alignment: .leading) {
                Text("Recommended")
                    .foregroundColor(.white)
                    .font(.title2)
                    .fontWeight(.bold)
                Text("Basic Skills")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
            .padding(.leading, hInset)
            .padding(.top, 20)
            
            // 수평 스크롤 뷰
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: [
                    GridItem(.fixed(200), spacing: 20)
                ], spacing: 20) {
                
                    TutorialButton(info: YoutubeVideo(id: "ujREEgxEP7g", title: "3 dance moves for begginers", channel: nil, thumbnailUrlString: "https://img.youtube.com/vi/ujREEgxEP7g/hqdefault.jpg")) {
                        openURL(URL(string: "https://youtu.be/ujREEgxEP7g")!)
                    }
                    
                    
                    ForEach(viewModel.videos) { videoInfo in
                        TutorialButton(info: videoInfo) {
                            print("DEBUG: video button Tapped \(videoInfo.title)")
                            openURL(URL(string: "https://youtu.be/\(videoInfo.id)")!)
                            
                        }
                    }
                }
                .padding(.leading, 20)
            }
            .onAppear {
                // Youtube API 할당량 돌아오면 재실험 🚧
//                viewModel.fetchVideoData()
                
                //Mockup data
                viewModel.videos = [
                    YoutubeVideo(id: "1WIA6Yvj8Yg", title: "HIP HOP Dance Choreography Tutorial for Beginners - Free Dance Class at Home", channel: nil, thumbnailUrlString: "https://img.youtube.com/vi/1WIA6Yvj8Yg/hqdefault.jpg")
                    
                ]
            }
            Spacer()
        }
        .background(Color("background"))
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Result")
        
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView()
    }
}
