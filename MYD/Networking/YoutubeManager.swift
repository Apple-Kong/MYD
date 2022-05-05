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
    
    func fetchVideoInfo(playlistID: String, completion: @escaping ([YoutubePlaylistItem], Error?) -> Void) {
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
                    completion(response.items, nil)
                case .failure(let error):
                    print("DEBUG: \(error.localizedDescription)")
                    completion([], error)
                }
            }
    }
}


// MARK: - Welcome
struct PlaylistResponse: Codable {
    let kind, etag, nextPageToken: String
    let items: [YoutubePlaylistItem]
    let pageInfo: PageInfo
}

// MARK: - Item
struct YoutubePlaylistItem: Codable {
    let kind: String
    let etag: String
    let id: String
    let snippet: Snippet
    
    // MARK: - Snippet
    struct Snippet: Codable {
        let publishedAt: Date
        let channelID, title, snippetDescription: String
        let thumbnails: Thumbnails
        let channelTitle, playlistID: String
        let position: Int
        let resourceID: ResourceID
        let videoOwnerChannelTitle, videoOwnerChannelID: String
        
        // MARK: - ResourceID
        struct ResourceID: Codable {
            let kind, videoID: String

            enum CodingKeys: String, CodingKey {
                case kind
                case videoID = "videoId"
            }
        }

        enum CodingKeys: String, CodingKey {
            case publishedAt
            case channelID = "channelId"
            case title
            case snippetDescription = "description"
            case thumbnails, channelTitle
            case playlistID = "playlistId"
            case position
            case resourceID = "resourceId"
            case videoOwnerChannelTitle
            case videoOwnerChannelID = "videoOwnerChannelId"
        }
        
        // MARK: - Thumbnails
        struct Thumbnails: Codable {
            let thumbnailsDefault, medium, high: Default
            let standard, maxres: Default?

            enum CodingKeys: String, CodingKey {
                case thumbnailsDefault = "default"
                case medium, high, standard, maxres
            }
            
            
            // MARK: - Default
            struct Default: Codable {
                let url: String
                let width, height: Int
            }
        }
        
    }
}














