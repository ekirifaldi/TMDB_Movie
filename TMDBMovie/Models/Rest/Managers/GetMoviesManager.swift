//
//  GetMovieManager.swift
//  TMDBMovie
//
//  Created by Eki Rifaldi on 10/01/21.
//

import Foundation

protocol GetMoviesManagerDelegate {
    func didSuccessGetMovies(page: Int, moviesData: [MovieModel])
    func didFailWithClientError(error: Error)
    func didFailWithServerError(response: URLResponse?)
}

class GetMoviesManager: BaseRest {
    var delegate: GetMoviesManagerDelegate?
    
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
        
        if let safeUrlStr = urlStr, let safeUrl = URL(string: safeUrlStr) {
            
            var urlRequest = URLRequest(url: safeUrl)
            urlRequest.httpMethod = Method.GET
            
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: urlRequest) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithClientError(error: error!)
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse,
                    (200...299).contains(httpResponse.statusCode) else {
                        self.delegate?.didFailWithServerError(response: response)
                    return
                }
                
                if let safeData = data {
                    
//                    let outputStr  = String(data: safeData, encoding: String.Encoding.utf8)! as String
//                    print("response: \(outputStr)")
                    
//                    if let parsedData = self.parseJSON(safeData) {
//                        self.delegate?.didSuccessGetMovies(page: parsedData.0, moviesData: parsedData.1)
//                    }
                }
            }
            
            task.resume()
        }
    }
    
//    func parseJSON(_ data: Data) -> (Int, [MovieModel])? {
//        let decoder = JSONDecoder()
//        decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601standard)
//        do {
//            let decodedResponse = try decoder.decode(GetMoviesResponse.self, from: data)
//            let decodedDatas = decodedResponse.results
//
//            var models = [MovieModel]()
//            for decodedData in decodedDatas {
//                let model = MovieModel(id: decodedData.id, overview: decodedData.overview, posterPath: decodedData.posterPath, releaseDate: decodedData.releaseDate, title: decodedData.title)
//
//                models.append(model)
//            }
//
//            return (decodedResponse.page, models)
//        } catch {
//            delegate?.didFailWithClientError(error: error)
//            return nil
//        }
//    }
}
