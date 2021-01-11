//
//  MovieDetailViewController.swift
//  TMDBMovie
//
//  Created by Eki Rifaldi on 10/01/21.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var labelTitle: DynamicLabel!
    @IBOutlet weak var labelReleaseDate: DynamicLabel!
    @IBOutlet weak var labelDesc: DynamicLabel!
    @IBOutlet weak var ivPhoto: UIImageView!
    @IBOutlet weak var viewCard: UIView! {
        didSet {
            viewCard.addShadow()
            viewCard.isHidden = true
        }
    }
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.isHidden = true
        }
    }
    
    var movieDetailVM = MovieDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieDetailVM.navigation = self.navigationController
        createObserver()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: NibName.reviewCell, bundle: nil), forCellReuseIdentifier: CellIdentifier.reviewReusableCell)
        
        if let movie = movieDetailVM.selectedMovie {
            movieDetailVM.getDetails(movieId: movie.id)
            movieDetailVM.getReviews(movieId: movie.id)
            movieDetailVM.getMovieVideos(movieId: movie.id)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let movie = movieDetailVM.selectedMovie {
            self.title = movie.title
        }
    }
    
    private func createObserver(){
        let notificationName = Notification.Name(rawValue: NotificationName.getDetailMoviesNotificationKey)
        NotificationCenter.default.addObserver(self, selector: #selector(updateDetailMovie(_:)), name: notificationName, object: nil)
        
        let notificationReviewName = Notification.Name(rawValue: NotificationName.getMovieReviewsNotificationKey)
        NotificationCenter.default.addObserver(self, selector: #selector(updateMovieReviews(_:)), name: notificationReviewName, object: nil)
    }
    
    @objc private func updateMovieReviews(_ notification: NSNotification) {
        guard let dataCount = notification.userInfo?["success"] as? Int else {
            return
        }
        
        if dataCount > 0 {
            tableView.reloadData()
        }
    }
    
    @objc private func updateDetailMovie(_ notification: NSNotification) {
        guard let isDataReady = notification.userInfo?["success"] as? Bool else {
            return
        }
        
        if isDataReady {
            guard let movie = movieDetailVM.movieDetail else {
                return
            }
            
            labelTitle.text = movie.title
            labelDesc.text = movie.overview
            
            let formatter = DateFormatter()
            formatter.dateFormat = DateFormat.releaseDateFormat
            labelReleaseDate.text = formatter.string(from: movie.releaseDate)
            
            let imageUrlString = "\(API.IMAGE_URL)\(movie.posterPath)"
            if let url = URL(string: imageUrlString)
            {
                DispatchQueue.global().async {
                    if let data = try? Data( contentsOf:url)
                    {
                        DispatchQueue.main.async {
                            self.ivPhoto.image = UIImage( data:data)
                        }
                    }
                }
            }
            
            viewCard.isHidden = false
            tableView.isHidden = false
        }
    }
    
    @IBAction private func btnWatchTrailerPressed(_ sender: UIButton) {
        movieDetailVM.goToYoutubeTrailer()
    }
}

extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieDetailVM.movieReviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.reviewReusableCell, for: indexPath) as! ReviewCell
        
        let review = movieDetailVM.movieReviews[indexPath.row]
        cell.labelName.text = review.name
        
        cell.labelRate.text = "\(StringHelper().toStringRoundUp(num: review.rating))/10.0"
        cell.labelContent.text = review.content
        
        let imageUrlString = "\(API.IMAGE_URL)\(review.avatarPath)"
        if let url = URL(string: imageUrlString)
        {
            DispatchQueue.global().async {
                if let data = try? Data( contentsOf:url)
                {
                    DispatchQueue.main.async {
                        cell.ivUserPhoto.image = UIImage( data:data)
                    }
                }
            }
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellHeight = UIScreen.main.bounds.height * 0.1
        return cellHeight
    }
    
}
