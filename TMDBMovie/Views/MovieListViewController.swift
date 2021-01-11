//
//  MovieListViewController.swift
//  TMDBMovie
//
//  Created by Eki Rifaldi on 10/01/21.
//

import UIKit

class MovieListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var toolBar = UIToolbar()
    var picker  = UIPickerView()
    
    var movieListVM = MovieListViewModel()
    let movieCategories = ["Popular","Top Rated","Now Playing"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: NibName.movieCell, bundle: nil), forCellReuseIdentifier: CellIdentifier.movieReusableCell)
        
        movieListVM.navigation = self.navigationController
        createObserver()
        movieListVM.getMovies(category: .POPULAR, page: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        self.title = "TMDBMovie"
        setUpView()
        setNavigationBar()
    }
    
    func setNavigationBar() {
        let nav = self.navigationController?.navigationBar
        nav?.barTintColor = UIColor.systemBlue
        nav?.tintColor = UIColor.white
        nav?.layer.masksToBounds = false
        nav?.layer.shadowColor = UIColor.lightGray.cgColor
        nav?.layer.shadowOpacity = 0.25
        nav?.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        nav?.layer.shadowRadius = 31
        
    }
    
    func setUpView(){
        let labelTitle = UILabel()
        labelTitle.text = "TMDBMovie"
        labelTitle.font = UIFont(name: "Avenir-Heavy", size: DynamicFontSize(fontSize: 17).calculatedFontSize)!
        labelTitle.textColor = UIColor.white
        labelTitle.sizeToFit()
        
        let leftItem = UIBarButtonItem(customView: labelTitle)
        self.navigationItem.leftBarButtonItem = leftItem
    }
    
    func createObserver(){
        let notificationName = Notification.Name(rawValue: NotificationName.getMoviesNotificationKey)
        NotificationCenter.default.addObserver(self, selector: #selector(updateMovies(_:)), name: notificationName, object: nil)
    }
    
    @objc func updateMovies(_ notification: NSNotification) {
        guard let dataCount = notification.userInfo?["success"] as? Int else {
            return
        }
        
        if dataCount > 0 {
            tableView.reloadData()
        }
    }
    
    @IBAction func btnCategoryPressed(_ sender: UIButton) {
        showPicker()
    }
}

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieListVM.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.movieReusableCell, for: indexPath) as! MovieCell
        let movie = movieListVM.movies[indexPath.row]
        cell.labelTitle.text = movie.title
        cell.labelDesc.text = movie.overview
        
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormat.releaseDateFormat
        cell.labelReleaseDate.text = formatter.string(from: movie.releaseDate)
        
        let imageUrlString = "\(API.IMAGE_URL)\(movie.posterPath)"
        if let url = URL(string: imageUrlString)
        {
            DispatchQueue.global().async {
                if let data = try? Data( contentsOf:url)
                {
                    DispatchQueue.main.async {
                        cell.ivPhoto.image = UIImage( data:data)
                    }
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = movieListVM.movies[indexPath.row]
        movieListVM.goToDetailMovie(movie: data)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellHeight = UIScreen.main.bounds.height * 0.2
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == movieListVM.movies.count {
            movieListVM.currentPage += 1
            movieListVM.getMovies(category: movieListVM.selectedCategory, page: movieListVM.currentPage)
        }
    }
}

extension MovieListViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return movieListVM.movieCategories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return movieListVM.movieCategories[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        movieListVM.selectedCategory = movieListVM.movieCategories[row]
    }
    
    @objc func onDoneButtonTapped() {
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
        
        movieListVM.currentPage = 1
        movieListVM.getMovies(category: movieListVM.selectedCategory, page: movieListVM.currentPage)
    }
    
    func showPicker(){
        
        picker = UIPickerView.init()
        picker.delegate = self
        picker.dataSource = self
        picker.backgroundColor = UIColor.white
        picker.setValue(UIColor.black, forKey: "textColor")
        picker.autoresizingMask = .flexibleWidth
        picker.contentMode = .center
        picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(picker)
        
        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barStyle = .default
        toolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))]
        self.view.addSubview(toolBar)
        
    }
}
