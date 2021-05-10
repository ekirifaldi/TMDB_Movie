//
//  MovieListViewModel.swift
//  TMDBMovie
//
//  Created by Eki Rifaldi on 10/01/21.
//

import UIKit

class MovieListViewModel {
    var alaGetMovies = AlaGetMoviesManager()
    
    var movies = [MovieModel]()
    var navigation: UINavigationController? = nil
    let movieCategories: [MovieCategory] = [.POPULAR,.TOP_RATED,.NOW_PLAYING]
    var selectedCategory: MovieCategory = .TOP_RATED
    var moviePage: Int = 1
    
    func getMovies(category: MovieCategory, page: Int){
        if let nav = navigation {
            
            let alert = Alert().loadingAlert()
            
            nav.present(alert, animated: true, completion: {
                self.alaGetMovies.get(selectedCategory: category, page: page, completionHandler: { [self] (response) in
                    if let moviesData = response {
                        moviePage += 1
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
                })
            })
            
        }
    }
    
    func goToDetailMovie(index: Int){
//        let movieDetailVC = MovieDetailViewController(nibName: NibName.movieDetailViewController, bundle: nil)
//        self.navigation!.pushViewController(movieDetailVC, animated: true)
    }
    
}
