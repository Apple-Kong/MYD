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
            "key" : "AIzaSyC9mBcLMbYAyXvTaSddxzS3HYsCh1Z6MHo",
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
    func fetchVideoInfoList(query: String, completion: @escaping ([YouTubeSearchItem], Error?) -> Void) {
        
        let parameters: [String: String] = [
            "key" : "AIzaSyC9mBcLMbYAyXvTaSddxzS3HYsCh1Z6MHo",
            "type" : "video",
            "maxResults" : "15",
            "part" : "snippet",
            "q" : query,
            "regionCode" : "US"
        ]
        
        AF.request(Constant.search, method: .get, parameters: parameters, encoder: URLEncodedFormParameterEncoder.default)
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
}






