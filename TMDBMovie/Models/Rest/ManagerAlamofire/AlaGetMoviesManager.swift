//
//  AlaGetMoviesManager.swift
//  TMDBMovie
//
//  Created by Eki Rifaldi on 04/05/21.
//

import Foundation
import Alamofire

class AlaGetMoviesManager {
    func get(selectedCategory category: MovieCategory, page: Int){
        var urlStr: String?
        switch category {
        case .POPULAR:
            urlStr = "\(API.BASE_URL)\(API.POPULAR)?api_key=\(Key.THEMOVIEDB_API_KEY)&page=\(page)"
        case .TOP_RATED:
            urlStr = "\(API.BASE_URL)\(API.TOP_RATED)?api_key=\(Key.THEMOVIEDB_API_KEY)&page=\(page)"
        case .NOW_PLAYING:
            urlStr = "\(API.BASE_URL)\(API.NOW_PLAYING)?api_key=\(Key.THEMOVIEDB_API_KEY)&page=\(page)"
        }
    
        
        let request = AF.request(urlStr!)
    
        request.responseJSON { (data) in
            print("REQUEST ALA: \(data)")
        }
    }
}

