//
//  YoutubeManager.swift
//  MYD
//
//  Created by GOngTAE on 2022/05/03.
//

import Foundation
import Alamofire

class YoutubeManager {

    typealias VideoID = String
    
    func fetchVideoIDs(query: String, completion: @escaping ([VideoID], Error?) -> Void) {
        
        let parameters: [String: String] = [
            "key" : Secret.youtubeAppKey,
            "type" : "video",
            "q" : query
        ]
        
        AF.request(Constant.search, method: .get, parameters: parameters, encoder: URLEncodedFormParameterEncoder.default)
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
    
    // MARK: - query String -> Video infos
    // 🚨API 요청 할당량 Issue 메서드 변경 예정
    func fetchVideoInfoList(query: String, completion: @escaping ([YouTubeSearchItem], Error?) -> Void) {
        
        let parameters: [String: String] = [
            "key" : Secret.youtubeAppKey,
            "type" : "video",
            "maxResults" : "15",
            "part" : "snippet",
            "q" : query,
            "regionCode" : "US"
        ]
        
        AF.request(Constant.search, method: .get, parameters: parameters, encoder: URLEncodedFormParameterEncoder.default)
            .responseString(completionHandler: { response in
                print("DEBUG: \(response)")
            })
            .responseDecodable(of: YoutubeSearchList.self) { response in
                switch response.result {
                case .success(let response):
                    completion(response.items, nil)
                case .failure(let error):
                    completion([], error)
                    print("ERROR: fetchVideoInfoList method \(error.localizedDescription)")
                }
            }
    }
    
    func fetchVideoInfo(playlistID: String, completion: @escaping (PlaylistResponse?, Error?) -> Void) {
        let parameters: [String: String] = [
            "key" : Secret.youtubeAppKey,
            "part" : "snippet",
            "playlistId": playlistID
        ]
        AF.request(Constant.playlistItems, method: .get, parameters: parameters, encoder: URLEncodedFormParameterEncoder.default)
            .responseString { response in
                print("DEBUG: fetchVideoInfo with playlistID - \(response)")
            }
            .responseDecodable(of: PlaylistResponse.self) { response in
                switch response.result {
                case .success(let response):
                    print("DEBUG: fetchVideoInfo with playlistID - \(response.items[0].snippet.title)")
                    completion(response, nil)
                case .failure(let error):
                    print("DEBUG: \(error.localizedDescription)")
                    completion(nil, error)
                }
            }
    }
}

struct PlaylistResponse: Codable {
    let kind: String
    let etag: String
    let nextPageToken: String
    let items: [PlaylistItem]
    
    let pageInfo: PageInfo
        
    
}

struct PlaylistItem: Codable {
    let kind: String
    let etag: String
    let id: String
    
    
    let snippet: Snippet
    
    struct Snippet: Codable {
        let publishedAt: String
        let channelId: String
        let title: String
        let description: String
        let thumbnails: Thumbnails
        
       let channelTitle: String
       let playlistId: String
       let position: Int
       let resourceId: ResourceId
       
       struct ResourceId: Codable {
           let kind: String
           let videoId: String
       }
       
       
      
       let videoOwnerChannelTitle: String
       let videoOwnerChannelId: String
        
        struct Thumbnails: Codable {
            let thumbDefault: Info
            let medium: Info
            let high: Info
            
            enum CodingKeys: String, CodingKey {
                case medium
                case high
                case thumbDefault = "default"
            }
            
            struct Info: Codable {
                let url: String
                let width: Int
                let height: Int
            }

        }
    }
    
}
