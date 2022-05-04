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
    func fetchVideoInfoList(videoIDs: [VideoID], completion: @escaping ([VideoResponse], Error?) -> Void) {
        
        var idString = ""
        
        for id in videoIDs {
            idString.append(id)
        
            if id != videoIDs.last {
                idString.append(contentsOf: ",")
            }
        }
        
        let parameters: [String: String] = [
            "key" : "AIzaSyC9mBcLMbYAyXvTaSddxzS3HYsCh1Z6MHo",
            "part" : "snippet",
            "id" : idString
        ]
        
        AF.request(Constant.YOUTUBE_URL_VIDEO, method: .get, parameters: parameters, encoder: URLEncodedFormParameterEncoder.default)
            .responseString { response in
                print("DEBUG: \(response)")
            }
            .responseDecodable(of: VideoResponse.self) { response in
                switch response.result {
                case .success(let response):
                    for item in response.items {
                        print("DEBUG: Video title is... \(item)")
                    }
                    
                case .failure(let error):
                    print("DEBUG: \(error.localizedDescription)")
                }
            }
        //Decoding 할 예정
    }
}




// MARK: - VideoResponse
struct VideoResponse: Codable {
    let kind, etag: String
    let nextPageToken: String?
    let prevPageToken: String?
    let items: [VideoItem]
    let pageInfo: PageInfo
}

// MARK: - Item
struct VideoItem: Codable {
    let kind, etag, id: String
    let snippet: Snippet
}

// MARK: - Snippet
struct Snippet: Codable {
    let publishedAt: Date
    let channelID, title, snippetDescription: String
    let thumbnails: Thumbnails
    let channelTitle: String
    let tags: [String]
    let categoryID, liveBroadcastContent: String
    let localized: Localized
    let defaultAudioLanguage: String?

    enum CodingKeys: String, CodingKey {
        case publishedAt
        case channelID = "channelId"
        case title
        case snippetDescription = "description"
        case thumbnails, channelTitle, tags
        case categoryID = "categoryId"
        case liveBroadcastContent, localized, defaultAudioLanguage
    }
}

// MARK: - Localized
struct Localized: Codable {
    let title, localizedDescription: String

    enum CodingKeys: String, CodingKey {
        case title
        case localizedDescription = "description"
    }
}

// MARK: - Thumbnails
struct Thumbnails: Codable {
    //이부분이 문제인 듯함
    let thumbnailsDefault, medium, high, standard: Default?
    let maxres: Default?

    enum CodingKeys: String, CodingKey {
        case thumbnailsDefault = "default"
        case medium, high, standard, maxres
    }
}

// MARK: - Default
struct Default: Codable {
    let url: String
    let width, height: Int
}
