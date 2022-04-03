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
    static let YOUTUBE_URL = "https://www.youtube.com/embed/"
    static let POPULAR = "/popular"
    static let TOP_RATED = "/top_rated"
    static let NOW_PLAYING = "/now_playing"
    static let REVIEWS = "/reviews"
    static let VIDEOS = "/videos"
    
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
    //VC
    static let movieListViewController = "MovieListViewController"
    static let movieDetailViewController = "MovieDetailViewController"
    
    //CELL
    static let movieCell = "MovieCell"
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
    static let charcoleBlack = "Charcole Black"
    static let pureWhite = "Pure White"
}

struct FontName {
    static let avenirHeavy = "Avenir-Heavy"
}


struct AlertMessage {
    static let noYoutubeTrailer = "No Youtube Trailer"
}
