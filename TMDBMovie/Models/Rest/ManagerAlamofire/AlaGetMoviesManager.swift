//
//  AlaGetMoviesManager.swift
//  TMDBMovie
//
//  Created by Eki Rifaldi on 04/05/21.
//

import Foundation
import Alamofire

//https://www.raywenderlich.com/6587213-alamofire-5-tutorial-for-ios-getting-started#toc-anchor-007
class AlaGetMoviesManager {
    func get(selectedCategory category: MovieCategory, page: Int, completionHandler: @escaping ([MovieModel]?) -> Void){
        var urlStr: String?
        switch category {
        case .POPULAR:
            urlStr = "\(API.BASE_URL)\(API.POPULAR)?api_key=\(Key.THEMOVIEDB_API_KEY)&page=\(page)"
        case .TOP_RATED:
            urlStr = "\(API.BASE_URL)\(API.TOP_RATED)?api_key=\(Key.THEMOVIEDB_API_KEY)&page=\(page)"
        case .NOW_PLAYING:
            urlStr = "\(API.BASE_URL)\(API.NOW_PLAYING)?api_key=\(Key.THEMOVIEDB_API_KEY)&page=\(page)"
        }
        
        AF.request(urlStr!)
            .validate()
            .responseDecodable(of: GetMoviesResponse.self, decoder: CustomDecoder()) { (response) in
                guard let movies = response.value else { return }
                completionHandler(movies.results)
            }
    }
}

