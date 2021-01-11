//
//  GetVideosResponse.swift
//  TMDBMovie
//
//  Created by Eki Rifaldi on 10/01/21.
//

import Foundation

struct GetVideosResponse: Codable {
    let id: Int
    let results: [VideoData]
}

struct VideoData: Codable {
    let id: String
    let key: String
    let name: String
    let site: String
}
