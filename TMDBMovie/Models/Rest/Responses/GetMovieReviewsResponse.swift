//
//  GetMovieReviewsResponse.swift
//  TMDBMovie
//
//  Created by Eki Rifaldi on 10/01/21.
//

import Foundation

struct GetMovieReviewsResponse: Codable {
    let id: Int
    let results: [ReviewData]?
}

struct ReviewData: Codable {
    let author: String
    let author_details: AuthorDetails
    let content: String
    let created_at: Date
    let id: String
}

struct AuthorDetails: Codable {
    let name: String
    let username: String
    let avatar_path: String
    let rating: Double
}
