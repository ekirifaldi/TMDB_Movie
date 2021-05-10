//
//  MovieDetailViewController.swift
//  TMDBMovie
//
//  Created by Eki Rifaldi on 11/05/21.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var labelMovieDetail: UILabel!
    var movieDetailVM = MovieDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        labelMovieDetail.text = movieDetailVM.movieName
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
