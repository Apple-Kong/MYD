//
//  SearchResponse.swift
//  MYD
//
//  Created by GOngTAE on 2022/05/03.
//

import Foundation

// MARK: - Search -> Video ID Response
struct SearchResponse: Codable {
    let kind, etag, nextPageToken, regionCode: String
    let pageInfo: PageInfo
    let items: [Item]
}

struct Item: Codable {
    let kind, etag: String
    let id: ID
}

struct ID: Codable {
    let kind, videoID: String

    enum CodingKeys: String, CodingKey {
        case kind
        case videoID = "videoId"
    }
}

struct PageInfo: Codable {
    let totalResults, resultsPerPage: Int
}



// MARK: - Youtube Search -> Video List Response
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
    
    struct YouTubeId: Codable {
        let kind: String
        let videoId: String
    }

    struct Snippet: Codable {
        let title: String
        let description: String
        let thumbnails: ThumbnailInfo
        
        struct ThumbnailInfo: Codable {
            let `default`: ThumbDefaultInfo?
            let high: ThumbHighInfo?
            
            
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
        }
    }
}




