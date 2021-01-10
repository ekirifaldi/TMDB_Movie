//
//  MovieReviewsModel.swift
//  TMDBMovie
//
//  Created by Eki Rifaldi on 10/01/21.
//

import Foundation

struct MovieReviewsModel {
    let id: Int
    let results: [ReviewDataModel]
}

struct ReviewDataModel {
    let name: String
    let avatarPath: String
    let rating: Double
    let content: String
    let createdAt: Date
    let id: String
}
