//
//  GetVideosManager.swift
//  TMDBMovie
//
//  Created by Eki Rifaldi on 10/01/21.
//

import Foundation

protocol GetVideosManagerDelegate {
    func didSuccessGetVideos(videosData: [VideoModel])
    func didFailWithClientError(error: Error)
    func didFailWithServerError(response: URLResponse?)
}

class GetVideosManager: BaseRest {
    var delegate: GetVideosManagerDelegate?
    
    func get(movieId: Int){
        let urlStr = "\(API.BASE_URL)/\(movieId)\(API.VIDEOS)?api_key=\(Key.THEMOVIEDB_API_KEY)"
        
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
                    
//                    let outputStr  = String(data: safeData, encoding: String.Encoding.utf8)! as String
//                    print("response: \(outputStr)")
                    
                    if let model = self.parseJSON(safeData) {
                        self.delegate?.didSuccessGetVideos(videosData: model)
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) -> [VideoModel]? {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601standard)
        do {
            let decodedDatas = try decoder.decode(GetVideosResponse.self, from: data).results

            var models = [VideoModel]()
            for decodedData in decodedDatas {
                
                let model = VideoModel(id: decodedData.id, key: decodedData.key, name: decodedData.name, site: decodedData.site)
                
                models.append(model)
            }
            
            return models
        } catch {
            delegate?.didFailWithClientError(error: error)
            return nil
        }
    }
}
