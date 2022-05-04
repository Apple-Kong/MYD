//
//  ResultViewModel.swift
//  MYD
//
//  Created by GOngTAE on 2022/05/03.
//

import Foundation


class ResultViewModel: ObservableObject {
    
    let manager = YoutubeManager()
    
    @Published var videos: [YoutubeSearchList] = []
    
    var resultGenre = ""
    
    func getThumbnailImageURL() -> URL? {
        
        return nil
    }
    
    // 비디오 ID 를 가져와서 그 목록을 가지고 다시 비디오 데이터 가져오기
    func getVideoData() -> [String] {
        
        manager.fetchVideoIDs(query: "hiphop dance tutorial") { videoIDs, error in
            
            guard error == nil else {
                print("DEBUG: \(error?.localizedDescription)")
                return
            }
            
            self.manager.fetchVideoInfoList(videoIDs: videoIDs) { videoInfos, error in
                guard error == nil else {
                    print("DEBUG: \(error?.localizedDescription)")
                    return
                }
                
                print("DEBUG: Completion handling... in fetchVideoInfoList ")
            }
        }
        return []
    }
}

