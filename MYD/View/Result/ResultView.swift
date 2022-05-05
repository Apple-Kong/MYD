//
//  ResultView.swift
//  MYD
//
//  Created by GOngTAE on 2022/05/03.
//
//                    TutorialButton(info: YoutubeVideo(id: "ujREEgxEP7g", title: "3 dance moves for begginers", channel: nil, thumbnailUrlString: "https://img.youtube.com/vi/ujREEgxEP7g/hqdefault.jpg")) {
//                        openURL(URL(string: "https://youtu.be/ujREEgxEP7g")!)
//                    }
                    
//                    ForEach(
//
                    


import SwiftUI
import Kingfisher


class ResultViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published var videos: [YoutubeVideo] = []
    
    let manager = YoutubeManager()
    var resultGenre = "hiphop"
    
    init() {
        fetchVideoDataWtihPlaylistID()
    }
    
    func fetchVideoDataWtihPlaylistID() {
        manager.fetchVideoInfo(playlistID: "PLOuzAY2stNg71WMno7PemBkhKEiNOrWuu") { response, error in
            
        
            guard error == nil else {
                return
            }
            guard let response = response else {
                return
            }

            
            var result: [YoutubeVideo] = []
    
            
            for item in response.items {
                result.append(YoutubeVideo(id: item.snippet.resourceId.videoId, title: item.snippet.title, channel: item.snippet.channelTitle, thumbnailUrlString: item.snippet.thumbnails.high.url))
                print("DEBUG: title is ..\(item.snippet.title)")
            }
            
            self.videos = result
        }
    }
}


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
                    GridItem(.fixed(180), spacing: 0)
                ], spacing: 10) {
            
                    ForEach(viewModel.videos, id: \.self) { video in
                        Button {
                            print("DEBUG: video button Tapped \(video.title)")
                            openURL(URL(string: "https://www.youtube.com/watch?v=\(video.id)")!)
                        } label: {
                            VStack(alignment: .leading) {
                                //이미지 비동기 호출 및 플레이스홀더
                                
                                KFImage(video.thumbnailURL)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(height: 120)
                                    .clipped()
                                
                                
                                Text(video.title)
                                    .font(.footnote)
                                    .foregroundColor(.white)
                                    .fontWeight(.semibold)
                                    .lineLimit(3)
                                    .multilineTextAlignment(.leading)
                                    .padding(.horizontal, 12)
//                                    .padding(.top, 14)
                                    
                                Spacer()

                            }
                            .frame(width: 160, height: 180)
                            .background(Color("Container"))
                            .cornerRadius(10)
                            
                        }
                    }
                }
                .padding(.leading, 20)
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
