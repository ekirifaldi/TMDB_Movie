//
//  GetMoviesResponse.swift
//  TMDBMovie
//
//  Created by Eki Rifaldi on 10/01/21.
//

import Foundation

struct GetMoviesResponse: Codable {
    let page: Int
    let results: [MovieData]
}

struct MovieData: Codable {
    let adult: Bool
    let backdrop_path: String
    let genre_ids: [Int]
    let id: Int
    let original_language: String
    let original_title: String
    let overview: String
    let popularity: Double
    let poster_path: String
    let release_date: Date
    let title: String
    let video: Bool
    let vote_average: Double
    let vote_count: Int
}
