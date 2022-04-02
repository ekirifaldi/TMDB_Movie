//
//  MovieListViewModel.swift
//  TMDBMovie
//
//  Created by Eki Rifaldi on 10/01/21.
//

import UIKit

class MovieListViewModel {
    let fetchMoviesSuccess: Box<[MovieModel]> = Box([])
    let fetchFailed:Box<String?> = Box(nil)
    let loadingStatus = Box(false)
    
    var getMoviesService = GetMoviesService()
    
    var movies = [MovieModel]()
    
    func getMovies(){
        
        self.loadingStatus.value = true
        self.getMoviesService.get(completionHandler: { [weak self] response, error  in
            self?.loadingStatus.value = false
            if let moviesData = response {
                self?.fetchMoviesSuccess.value = moviesData
            } else if let error = error {
                self?.fetchFailed.value = error.localizedDescription
            }
        })
    }
    
    
}
