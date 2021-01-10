//
//  MovieDetailViewModel.swift
//  TMDBMovie
//
//  Created by Eki Rifaldi on 10/01/21.
//

import UIKit

class MovieDetailViewModel {
    var getMovieDetail = GetMovieDetailManager()
    var movieDetail: MovieDetailModel? = nil
    var navigation: UINavigationController? = nil
    var selectedMovie: MovieModel? = nil
    var getReviews = GetMovieReviewsManager()
    var movieReviews = [ReviewDataModel]()
    
    func getDetails(movieId id: Int){
        if let nav = navigation {
            
            let alert = Alert().loadingAlert()
            
            nav.present(alert, animated: true, completion: {
                self.getMovieDetail.delegate = self
                self.getMovieDetail.get(movieId: id)
            })
            
        }
    }
    
    func getReviews(movieId id: Int){
        self.getReviews.delegate = self
        self.getReviews.get(movieId: id)
    }
}

extension MovieDetailViewModel: GetMovieDetailManagerDelegate {
    func didSuccessGetMovieDetail(movieDetailModel: MovieDetailModel) {
        DispatchQueue.main.async {
            if let nav = self.navigation {
                nav.dismiss(animated: false, completion: {
                    self.movieDetail = movieDetailModel
                    let notificationName = Notification.Name(rawValue: NotificationName.getDetailMoviesNotificationKey)
                    let dataHash = ["success" : true]
                    NotificationCenter.default.post(name: notificationName, object: nil, userInfo: dataHash)
                })
            }
        }
    }
    
    func didFailWithClientError(error: Error) {
        print(error.localizedDescription)
        DispatchQueue.main.async {
            if let nav = self.navigation {
                nav.dismiss(animated: false, completion: nil)
            }
        }
    }
    
    func didFailWithServerError(response: URLResponse?) {
        print(response.debugDescription)
        DispatchQueue.main.async {
            if let nav = self.navigation {
                nav.dismiss(animated: false, completion: nil)
            }
        }
    }
}

extension MovieDetailViewModel: GetMovieReviewsManagerDelegate {
    func didSuccessGetMovieReviews(movieReviewsModel: MovieReviewsModel) {
        DispatchQueue.main.async {
            self.movieReviews = movieReviewsModel.results
            let notificationName = Notification.Name(rawValue: NotificationName.getMovieReviewsNotificationKey)
            let dataHash = ["success" : movieReviewsModel.results.count]
            NotificationCenter.default.post(name: notificationName, object: nil, userInfo: dataHash)
            
        }
    }
    
}

