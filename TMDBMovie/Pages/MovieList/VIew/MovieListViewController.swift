//
//  MovieListViewController.swift
//  TMDBMovie
//
//  Created by Eki Rifaldi on 10/01/21.
//

import UIKit
import Kingfisher

class MovieListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var movieListVM = MovieListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setUpView()
        inisiateView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchMovies()
    }
    
    private func setNavigationBar() {
        let nav = self.navigationController?.navigationBar
        nav?.barTintColor = UIColor.systemBlue
        nav?.tintColor = UIColor.white
        nav?.layer.masksToBounds = false
        nav?.layer.shadowColor = UIColor.lightGray.cgColor
        nav?.layer.shadowOpacity = 0.25
        nav?.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        nav?.layer.shadowRadius = 31
        
    }
    
    private func setUpView(){
        let labelTitle = UILabel()
        labelTitle.text = "TMDBMovie"
        labelTitle.font = UIFont(name: FontName.avenirHeavy, size: DynamicFontSize(fontSize: 17).calculatedFontSize)!
        labelTitle.textColor = UIColor(named: AssetColors.pureWhite)
        labelTitle.sizeToFit()
        
        let leftItem = UIBarButtonItem(customView: labelTitle)
        self.navigationItem.leftBarButtonItem = leftItem
    }
    
    func inisiateView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: NibName.movieCell, bundle: nil), forCellReuseIdentifier: CellIdentifier.movieReusableCell)
        movieListVM.navigation = self.navigationController
    }
    
    func fetchMovies(){
        
        movieListVM.getMovies(completionHandler: { [weak self] dataCount in
            if dataCount > 0 {
                self?.tableView.reloadData()
            }
        })
    }
}

// MARK: - UITableView
extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieListVM.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.movieReusableCell, for: indexPath) as! MovieCell
        
        let movie = movieListVM.movies[indexPath.row]
        
        cell.labelTitle.text = movie.title
        cell.labelDesc.text = movie.overview
        
        if let movieDate = movie.releaseDate {
            let formatter = DateFormatter()
            formatter.dateFormat = DateFormat.releaseDateFormat
            cell.labelReleaseDate.text = formatter.string(from: movieDate)
        } else {
            cell.labelReleaseDate.text = "unknown"
        }
        
        let imageUrlString = "\(API.IMAGE_URL)\(movie.posterPath)"
        let url = URL(string: imageUrlString)
        cell.ivPhoto.kf.setImage(with: url)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        movieListVM.goToDetailMovie(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellHeight = UIScreen.main.bounds.height * 0.2
        return cellHeight
    }
    
    
}
