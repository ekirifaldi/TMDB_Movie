//
//  GetMoviesResponse.swift
//  TMDBMovie
//
//  Created by Eki Rifaldi on 10/01/21.
//

import Foundation

struct GetMoviesResponse: Codable {
    let page: Int
    let results: [MovieModel]
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
    }
}

struct MovieModel: Codable {
    let adult: Bool
    let backdropPath: String?
    let genreIds: [Int]
    let id: Int
    let originalLanguage: String
    let overview: String
    let popularity: Double
    let posterPath: String
    let releaseDate: Date?
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
