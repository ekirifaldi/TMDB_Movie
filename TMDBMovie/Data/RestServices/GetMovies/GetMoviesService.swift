//
//  AlaGetMoviesManager.swift
//  TMDBMovie
//
//  Created by Eki Rifaldi on 04/05/21.
//

import Foundation
import Alamofire

class GetMoviesService {
    func get(completionHandler: @escaping ([MovieModel]?, Error?) -> Void){
        let urlStr = "\(API.BASE_URL)\(API.POPULAR)?api_key=\(Key.THEMOVIEDB_API_KEY)&page=1"
        AF.request(urlStr)
            .validate()
            .responseDecodable(of: GetMoviesResponse.self, decoder: CustomDecoder()) { (response) in
                switch response.result {
                case .success(let movies):
                    completionHandler(movies.results, nil)
                    break
                case .failure(let error):
                    completionHandler(nil, error)
                    break
                }
            }
    }
}

