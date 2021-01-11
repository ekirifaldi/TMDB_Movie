//
//  MovieListViewModel.swift
//  TMDBMovie
//
//  Created by Eki Rifaldi on 10/01/21.
//

import UIKit

class MovieListViewModel {
    var getMovies = GetMoviesManager()
    var movies = [MovieModel]()
    var navigation: UINavigationController? = nil
    let movieCategories: [MovieCategory] = [.POPULAR,.TOP_RATED,.NOW_PLAYING]
    var selectedCategory: MovieCategory = .TOP_RATED
    var moviePage: Int = 1
    
    func getMovies(category: MovieCategory, page: Int){
        if let nav = navigation {
            
            let alert = Alert().loadingAlert()
            
            nav.present(alert, animated: true, completion: {
                self.getMovies.delegate = self
                self.getMovies.get(selectedCategory: category, page: page)
            })
            
        }
    }
    
    func goToDetailMovie(movie: MovieModel){
        let movieDetailVC = MovieDetailViewController(nibName: NibName.movieDetailViewController, bundle: nil)
        movieDetailVC.movieDetailVM.selectedMovie = movie
        self.navigation!.dismiss(animated: true, completion: nil)
        self.navigation!.pushViewController(movieDetailVC, animated: true)
    }
    
}

extension MovieListViewModel: GetMoviesManagerDelegate {
    func didSuccessGetMovies(page: Int, moviesData: [MovieModel]) {
        moviePage += 1
        print("DEBUG1 RESPONSE PAGE: \(page)")
        print("DEBUG1 NEXT PAGE: \(moviePage)")
        DispatchQueue.main.async {
            if let nav = self.navigation {
                nav.dismiss(animated: false, completion: {
                    if page > 1 {
                        self.movies.append(contentsOf: moviesData)
                    } else {
                        self.movies = moviesData
                    }
                    let notificationName = Notification.Name(rawValue: NotificationName.getMoviesNotificationKey)
                    let dataHash = ["success" : moviesData.count]
                    NotificationCenter.default.post(name: notificationName, object: nil, userInfo: dataHash)
                })
            }
        }
    }
    
    func didFailWithClientError(error: Error) {
        print("DEBUG1 didFailWithClientError: \(error.localizedDescription)")
        print(error.localizedDescription)
        DispatchQueue.main.async {
            if let nav = self.navigation {
                nav.dismiss(animated: false, completion: nil)
            }
        }
    }
    
    func didFailWithServerError(response: URLResponse?) {
        print("DEBUG1 didFailWithServerError: \(response.debugDescription)")
        print(response.debugDescription)
        DispatchQueue.main.async {
            if let nav = self.navigation {
                nav.dismiss(animated: false, completion: nil)
            }
        }
    }
    
    
}
