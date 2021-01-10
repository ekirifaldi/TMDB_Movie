//
//  GetMovieReviewsManager.swift
//  TMDBMovie
//
//  Created by Eki Rifaldi on 10/01/21.
//

import Foundation

protocol GetMovieReviewsManagerDelegate {
    func didSuccessGetMovieReviews(movieReviewsModel: MovieReviewsModel)
    func didFailWithClientError(error: Error)
    func didFailWithServerError(response: URLResponse?)
}

class GetMovieReviewsManager: BaseRest {
    var delegate: GetMovieReviewsManagerDelegate?
    
    func get(movieId: Int){
        let urlStr = "\(API.BASE_URL)/\(movieId)\(API.REVIEWS)?api_key=\(Key.THEMOVIEDB_API_KEY)"
        
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
                        self.delegate?.didSuccessGetMovieReviews(movieReviewsModel: model)
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) -> MovieReviewsModel? {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601timestamp)
        do {
            let decodedData = try decoder.decode(GetMovieReviewsResponse.self, from: data)
            var reviewDataModel = [ReviewDataModel]()
            if let results = decodedData.results {
                for data in results {
                    let model = ReviewDataModel(name: data.author_details.name, avatarPath: data.author_details.avatar_path, rating: data.author_details.rating, content: data.content, createdAt: data.created_at, id: data.id)

                    reviewDataModel.append(model)
                }
            }
            
            let model = MovieReviewsModel(id: decodedData.id, results: reviewDataModel)
            
            return model
        } catch {
            delegate?.didFailWithClientError(error: error)
            return nil
        }
    }
}
