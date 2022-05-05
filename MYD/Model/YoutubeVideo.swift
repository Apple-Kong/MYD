//
//  YoutubeVideo.swift
//  MYD
//
//  Created by GOngTAE on 2022/05/04.
//

import Foundation

struct YoutubeVideo: Hashable, Identifiable {
 
    
    
    //MARK: - Stored
    let id: String
    var title: String
    let channel: String?
    let thumbnailUrlString: String?
    
    
    //MARK: - Computed
    var thumbnailURL: URL? {
        if let urlString = thumbnailUrlString {
            return URL(string: urlString)
        } else {
            return nil
        }
    }
}
