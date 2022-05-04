//
//  ResultViewModel.swift
//  MYD
//
//  Created by GOngTAE on 2022/05/03.
//

import Foundation

class ResultViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published var videos: [YoutubeVideo] = []
    
    let manager = YoutubeManager()
    var resultGenre = "hiphop"
    
    //MARK: - Methods
    func getThumbnailImageURL() -> URL? {
        
        return nil
    }
    
    func fetchVideoData() {
        manager.fetchVideoInfoList(query: resultGenre + " dance tutorial") { items, error in
            guard error != nil else {
                    //에러 핸들링 -> 경고 메세지 전달
                print("DEBUG: \(error?.localizedDescription ?? "")")
                return
            }
            var result: [YoutubeVideo] = []
            
            for item in items {
                result.append(YoutubeVideo(id: item.id.videoId, title: item.snippet.title, channel: nil, thumbnailUrlString: item.snippet.thumbnails.high?.url))
            }
            
            self.videos = result
        }
    }
}
