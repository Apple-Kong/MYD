//
//  YoutubeManager.swift
//  MYD
//
//  Created by GOngTAE on 2022/05/03.
//

import Foundation
import Alamofire



class Constant {
    //스네이크 케이스 잘 안쓴다.

    static let YOUTUBE_URL_SEARCH = "https://www.googleapis.com/youtube/v3/search"
    static let YOUTUBE_URL_VIDEO = "https://www.googleapis.com/youtube/v3/videos"
}



class YoutubeManager {

    typealias VideoID = String
    
    //get 단어 지양 -> fetch
    func fetchVideoIDs(query: String, completion: @escaping ([VideoID], Error?) -> Void) {
        
        let parameters: [String: String] = [
            "key" : "AIzaSyC9mBcLMbYAyXvTaSddxzS3HYsCh1Z6MHo",
            "type" : "video",
            "q" : query
        ]
        
        AF.request(Constant.YOUTUBE_URL_SEARCH, method: .get, parameters: parameters, encoder: URLEncodedFormParameterEncoder.default)
            .validate()
            .responseDecodable(of: SearchResponse.self) { response in
                
                var result: [VideoID] = []
                
                switch response.result {
                case .success(let response):
                    for item in response.items {
                        print("DEBUG: video ID is \(item.id.videoID)")
                        result.append(item.id.videoID)
                    }
                    
                    
                    //completion 에도 error 타입이 필요해보임.
                    completion(result, nil)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    completion([], error)
                }
            }
    }
    
    // 가져온 비디오 아이디의 목록으로 자세한 비디오 정보를 가져오는 비디오 인포
    func fetchVideoInfoList(videoIDs: [VideoID], completion: @escaping ([YoutubeSearchList], Error?) -> Void) {
        
//        var idString = ""
//
//        for id in videoIDs {
//            idString.append(id)
//
//            if id != videoIDs.last {
//                idString.append(contentsOf: ",")
//            }
//        }
        
        let parameters: [String: String] = [
            "key" : "AIzaSyC9mBcLMbYAyXvTaSddxzS3HYsCh1Z6MHo",
            "type" : "video",
            "maxResults" : "15",
            "part" : "snippet",
            "q" : "hiphop dance tutorial",
            "regionCode" : "US"
        ]
        
        AF.request(Constant.YOUTUBE_URL_SEARCH, method: .get, parameters: parameters, encoder: URLEncodedFormParameterEncoder.default)
            .responseString { response in
                print("DEBUG: \(response)")
            }
            .responseDecodable(of: YoutubeSearchList.self) { response in
                switch response.result {
                case .success(let response):
                    
                    
                    for item in response.items {
                        print("DEUBG: 동영상 제목 : \(item.snippet.title)")
                    }
                    
                case .failure(let error):
                    print("DEBUG: \(error.localizedDescription)")
                }
            }
        //Decoding 할 예정
    }
}


struct YoutubeSearchList: Codable {
    let kind: String
    let etag: String
    let nextPageToken: String
    let regionCode: String
    let items: [YouTubeSearchItem]
}

struct YouTubeSearchItem: Codable {
    let id: YouTubeId
    let snippet: Snippet
}

struct YouTubeId: Codable {
    let kind: String
    let videoId: String
}

struct Snippet: Codable {
    let title: String
    let description: String
    let thumbnails: ThumbnailInfo
}

struct ThumbnailInfo: Codable {
    let `default`: ThumbDefaultInfo?
    let high: ThumbHighInfo?
}

struct ThumbDefaultInfo: Codable {
    let url: String
    let width: Int
    let height: Int
}

struct ThumbHighInfo: Codable {
    let url: String
    let width: Int
    let height: Int
}




