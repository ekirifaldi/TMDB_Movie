//
//  MovieListViewModel.swift
//  TMDBMovie
//
//  Created by Eki Rifaldi on 10/01/21.
//

import UIKit

class MovieListViewModel: BaseViewModel {
    var getMovies = GetMoviesManager()
    
    var movies = [MovieModel]()
    
    
    
    func getMovies(completionHandler: @escaping (Int) -> Void){
        if let nav = navigation {
            
            let alert = Alert().loadingAlert()
            
            nav.present(alert, animated: true, completion: {
                self.getMovies.get(completionHandler: { [weak self] (response) in
                    if let moviesData = response {
                        nav.dismiss(animated: false, completion: {
                            self?.movies.append(contentsOf: moviesData)
                            completionHandler(moviesData.count)
                        })
                    }
                })
            })
            
        }
    }
    
    func goToDetailMovie(index: Int){
        if let nav = navigation {
            let movieDetailVC = MovieDetailViewController(nibName: NibName.movieDetailViewController, bundle: nil)
            movieDetailVC.movieDetailVM.movieName = movies[index].title
            nav.pushViewController(movieDetailVC, animated: true)
        }
    }
    
}
