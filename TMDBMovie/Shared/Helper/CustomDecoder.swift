//
//  CustomDecoder.swift
//  TMDBMovie
//
//  Created by Eki Rifaldi on 10/05/21.
//

import Foundation

//https://www.bitbuildr.com/tech-blog/alamofire-5-and-decodable-dates-the-clean-way
class CustomDecoder: JSONDecoder {
    let dateFormatter = DateFormatter()

    override init() {
        super.init()
        dateDecodingStrategy = .formatted(DateFormatter.iso8601standard)
    }
}
