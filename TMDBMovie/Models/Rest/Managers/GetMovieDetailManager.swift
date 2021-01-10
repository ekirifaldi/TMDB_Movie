//
//  GetMovieDetailManager.swift
//  TMDBMovie
//
//  Created by Eki Rifaldi on 10/01/21.
//

import Foundation

protocol GetMovieDetailManagerDelegate {
    func didSuccessGetMovieDetail(movieDetailModel: MovieDetailModel)
    func didFailWithClientError(error: Error)
    func didFailWithServerError(response: URLResponse?)
}

class GetMovieDetailManager: BaseRest {
    var delegate: GetMovieDetailManagerDelegate?
    
    func get(movieId: Int){
        let urlStr = "\(API.BASE_URL)/\(movieId)?api_key=\(Key.THEMOVIEDB_API_KEY)"
        
        if let safeUrl = URL(string: urlStr) {
            
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
                    
                    if let model = self.parseJSON(safeData) {
                        self.delegate?.didSuccessGetMovieDetail(movieDetailModel: model)
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) -> MovieDetailModel? {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601standard)
        do {
            let decodedData = try decoder.decode(GetMovieDetailResponse.self, from: data)
            
            let model = MovieDetailModel(id: decodedData.id, overview: decodedData.overview, posterPath: decodedData.poster_path, releaseDate: decodedData.release_date, title: decodedData.title)
            return model
        } catch {
            delegate?.didFailWithClientError(error: error)
            return nil
        }
    }
}

