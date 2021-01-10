//
//  Constant.swift
//  TMDBMovie
//
//  Created by Eki Rifaldi on 10/01/21.
//

import Foundation

struct Method {
    static let POST = "POST"
    static let GET = "GET"
    static let PATCH = "PATCH"
    static let DELETE = "DELETE"
    static let PUT = "PUT"
}

struct API {
    static let BASE_URL = "https://api.themoviedb.org/3/movie"
    static let IMAGE_URL = "https://image.tmdb.org/t/p/w500"
    static let POPULAR = "/popular"
    static let TOP_RATED = "/top_rated"
    static let NOW_PLAYING = "/now_playing"
    static let REVIEWS = "/reviews"
    
}

struct Key {
    static let THEMOVIEDB_API_KEY = "a1698e3d52e277568910588535152399"
}

struct DateFormat {
    static let standardDateFormat = "yyyy-MM-dd"
    static let timestampDateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    static let releaseDateFormat = "YYYY, MMM d"
}

struct NibName {
    static let movieListViewController = "MovieListViewController"
    static let movieDetailViewController = "MovieDetailViewController"
    static let movieCell = "MovieCell"
    static let reviewCell = "ReviewCell"
}


struct CellIdentifier {
    static let movieReusableCell = "MovieReusableCell"
    static let reviewReusableCell = "ReviewReusableCell"
}


struct AssetImages {
    static let favoriteImage = "fav"
    static let favTrue = "fav_true"
    static let favFalse = "fav_false"
}

struct AssetColors {
//    static let navigationBarColor = "NavigationBarColor"
}


struct NotificationName {
    static let getMoviesNotificationKey = "get_movies"
    static let getDetailMoviesNotificationKey = "get_detail_movie"
    static let getMovieReviewsNotificationKey = "get_movie_reviews"
}

