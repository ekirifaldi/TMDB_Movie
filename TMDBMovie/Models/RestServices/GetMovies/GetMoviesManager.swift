//
//  AlaGetMoviesManager.swift
//  TMDBMovie
//
//  Created by Eki Rifaldi on 04/05/21.
//

import Foundation
import Alamofire

//https://www.raywenderlich.com/6587213-alamofire-5-tutorial-for-ios-getting-started#toc-anchor-007
class GetMoviesManager {
    func get(completionHandler: @escaping ([MovieModel]?) -> Void){
        let urlStr = "\(API.BASE_URL)\(API.POPULAR)?api_key=\(Key.THEMOVIEDB_API_KEY)&page=1"
        AF.request(urlStr)
            .validate()
            .responseDecodable(of: GetMoviesResponse.self, decoder: CustomDecoder()) { (response) in
                guard let movies = response.value else { return }
                completionHandler(movies.results)
            }
    }
}

