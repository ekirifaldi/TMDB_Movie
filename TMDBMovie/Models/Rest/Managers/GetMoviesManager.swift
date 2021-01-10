//
//  GetMovieManager.swift
//  TMDBMovie
//
//  Created by Eki Rifaldi on 10/01/21.
//

import Foundation

protocol GetMoviesManagerDelegate {
    func didSuccessGetMovies(moviesData: [MovieModel])
    func didFailWithClientError(error: Error)
    func didFailWithServerError(response: URLResponse?)
}

class GetMoviesManager: BaseRest {
    var delegate: GetMoviesManagerDelegate?
    
    func get(selectedCategory category: MovieCategory){
        var urlStr: String?
        switch category {
        case .POPULAR:
            urlStr = "\(API.BASE_URL)\(API.POPULAR)?api_key=\(Key.THEMOVIEDB_API_KEY)"
        case .TOP_RATED:
            urlStr = "\(API.BASE_URL)\(API.TOP_RATED)?api_key=\(Key.THEMOVIEDB_API_KEY)"
        case .NOW_PLAYING:
            urlStr = "\(API.BASE_URL)\(API.NOW_PLAYING)?api_key=\(Key.THEMOVIEDB_API_KEY)"
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
                    
                    if let model = self.parseJSON(safeData) {
                        self.delegate?.didSuccessGetMovies(moviesData: model)
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) -> [MovieModel]? {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601standard)
        do {
            let decodedDatas = try decoder.decode(GetMoviesResponse.self, from: data).results

            var models = [MovieModel]()
            for decodedData in decodedDatas {
                let model = MovieModel(id: decodedData.id, overview: decodedData.overview, posterPath: decodedData.poster_path, releaseDate: decodedData.release_date, title: decodedData.title)
                
                models.append(model)
            }
            
            return models
        } catch {
            delegate?.didFailWithClientError(error: error)
            return nil
        }
    }
}
