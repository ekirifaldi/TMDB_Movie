//
//  MovieListViewController.swift
//  TMDBMovie
//
//  Created by Eki Rifaldi on 10/01/21.
//

import UIKit
import Kingfisher
import SnapKit

class MovieListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var activityIndicator: UIActivityIndicatorView! = {
        let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        indicator.color = .systemBlue
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    lazy var viewmodel: MovieListViewModel = {
        return MovieListViewModel()
    }()
    
    var movies = [MovieModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        inisiateView()
        dataBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func setUpView(){
        let nav = self.navigationController?.navigationBar
        
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .systemBlue
            nav?.standardAppearance = appearance
            nav?.scrollEdgeAppearance = self.navigationController?.navigationBar.standardAppearance
        }
        
        
        nav?.barTintColor = UIColor.systemBlue
        nav?.tintColor = UIColor.white
        nav?.layer.masksToBounds = false
        nav?.layer.shadowColor = UIColor.lightGray.cgColor
        nav?.layer.shadowOpacity = 0.25
        nav?.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        nav?.layer.shadowRadius = 31
        
        let labelTitle = UILabel()
        labelTitle.text = "TMDBMovie"
        labelTitle.font = UIFont(name: FontName.avenirHeavy, size: DynamicFontSize(fontSize: 17).calculatedFontSize)!
        labelTitle.textColor = UIColor(named: AssetColors.pureWhite)
        labelTitle.sizeToFit()
        
        let leftItem = UIBarButtonItem(customView: labelTitle)
        self.navigationItem.leftBarButtonItem = leftItem
        
        self.view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { cnst in
            cnst.center.equalToSuperview()
        }
    }
    
    private func inisiateView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: R.nib.movieCell.name, bundle: R.nib.movieCell.bundle), forCellReuseIdentifier: R.nib.movieCell.identifier)
    }
    
    private func dataBinding(){
        
        viewmodel.loadingStatus.bind { [weak self] isLoading in
            DispatchQueue.main.async {
                if isLoading {
                    self?.activityIndicator.startAnimating()
                } else {
                    self?.activityIndicator.stopAnimating()
                }
            }
        }
        
        viewmodel.fetchMoviesSuccess.bind { [weak self] movies in
            DispatchQueue.main.async {
                if movies.count > 0 {
                    self?.movies = movies
                    self?.tableView.reloadData()
                }
            }
        }
        
        viewmodel.fetchFailed.bind { [weak self] error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error: \(error)")
                }
            }
        }
        
        viewmodel.getMovies()
    }
}

// MARK: - UITableView
extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:  R.nib.movieCell.identifier, for: indexPath) as! MovieCell
        
        let movie = self.movies[indexPath.row]
        
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
        let movieDetailVC = MovieDetailViewController()
        movieDetailVC.movieName = movies[indexPath.row].title
        self.navigationController?.pushViewController(movieDetailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellHeight = UIScreen.main.bounds.height * 0.2
        return cellHeight
    }
    
    
}
