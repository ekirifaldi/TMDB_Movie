//
//  YoutubeTrailerViewController.swift
//  TMDBMovie
//
//  Created by Eki Rifaldi on 10/01/21.
//

import UIKit
import WebKit

class YoutubeTrailerViewController: UIViewController, WKNavigationDelegate {

    var webView: WKWebView!
    
    var youtubeTrailerlVM = YoutubeTrailerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView = WKWebView()
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        view = webView
        
        showYoutubeTrailer()
    }
    
    func showYoutubeTrailer(){
        guard let youtubeId = youtubeTrailerlVM.youtubeKey else { return }
        let urlStr = "\(API.YOUTUBE_URL)\(youtubeId)"
        if let safeUrl = URL(string: urlStr) {
            webView.load(URLRequest(url: safeUrl))
        }
    }

}
