//
//  GetMovieDetailResponse.swift
//  TMDBMovie
//
//  Created by Eki Rifaldi on 10/01/21.
//

import Foundation

struct GetMovieDetailResponse: Codable {
    let id: Int
    let overview: String
    let poster_path: String
    let release_date: Date
    let title: String
}
